# Informe sobre vulnerabilidades en Ethereum y Cardano

## E3: DoS por gas

### 1.1 ¿Qué es?

Los **contratos requieren** de **gas** para poder **ejecutar** sus funciones. En el caso de no contar con suficiente gas no se puede ejecutar o completar su ejecución, en caso de que ya haya iniciado, impidiendo al que la invocó obtener los resultados esperados.

---

### 1.2 ¿Por qué existe en ese modelo?

**Ethereum** tiene la característica de ser ***Turing complete***, lo cual le permite computar funciones de cualquier tipo de complejidad. Si combinamos eso con el resultado del ***Halting problem***, de que dado un programa y un input cualesquiera, no es computable determinar si termina, entonces alguien podría crear un contrato que  no termine y, como *por el mecanismo de consenso todos los nodos participantes de la red deben validar cada transacción* ejecutando ese ***smart contract***, permitiríamos que toda la red entre en un estado de loops infinitos. Para evitar eso se inventó el mecanismo de *gas*, el cual sirve para acotar la cantidad de pasos de ejecución y garantizar la terminación, ya que si una ejecución no termina por haber ejecutado todas sus instrucciones, entonces lo hará porque se queda sin *gas*. Al realizar una transacción se le debe proveer de suficiente *gas* para que se pueda ejecutar, el cual se paga con ***ether*** que es la moneda de **Ethereum** y cuya cantidad en circulación está acotada.

---

### 1.3 Ejemplo mínimo que la exhibe

El ejemplo clásico es cuando tenemos que recorrer estructuras que crecen en tamaño con la cantidad de usuario del contrato, aumentando el costo de la transacción y provocando que en caso de no contar con suficiente gas se deba aplicar `revert`.

---

### 1.4 Test que la demuestra

Hacer un test para demostrarlo es bastante complejo. En un principio pensamos que con llenar el arreglo para luego poner un `vm.expectRevert()` al intentar ejecutar `devolver_intereses()` alcanzaría, pero no. Hay dos aspectos a controlar:

- El *gas* propio del test.
- El *gas* de la transacción que queremos demostrar que sufre el *denial of service*.
  
Si no tenés en cuenta el gas que consume el test, entonces este va a fallar por `Evm error: Out of Gas`. Se nos ocurrieron dos formas de tests que pueden servir para demostrar la vulnerabilidad.

- La primera:
  - Consiste en mostrar que cuando el arreglo está muy lleno y un usuario quiera `invertir()` la transacción va a tener un costo muy alto, ya que este crece con la cantidad de inversores en el contrato.
  - Para darnos cuenta de esto podemos usar el *gas* propio del test, así si llegamos a un punto donde ya no podemos realizar más inversiones porque el costo de estas supera el *gas* que nos queda en el test, entonces tranquilamente podría pasarle a un usuario que si el contrato cuenta con muchos inversores el costo de la transacción para invertir sea muy alto y sea revertida por *falta de gas*.
  - Esta se ve en el test `test_dos_por_gas_sin_limitar_gas()`.
- La segunda:
  - Esta consiste en ponerle un límite explícito al gas que tiene disponible para cada llamada a `invertir`, de modo que si en algún momento se alcanza ese límite quiere decir que una transacción de `invertir` requiere de una cantidad de gas mayor a esa.
  - Al igual que en la primera, si la transacción requiere de mucho gas y no dispone de él se revertirá provocando un *denial of service* al cliente que legitimamente quería usar el contrato.
  - Esta se ve en el test `test_dos_por_gas_limitando_gas()`.

Viendo el código de `plazo_fijo` nos dimos cuenta que otro posible **ataque DoS** (aunque no sería por gas), podría ser si una de las transacciones de devolución revierte, lo cual hace que la transacción original de `devolver_intereses()` de `plazo_fijo` no permita que ninguno de los inversores retire el dinero. Para evidenciarla tenemos el test `test_ataque_por_no_implementar_receive()` donde mostramos que si un contrato no implementa el `receive()` ni el `fallback()` podría revertirse cuando `plazo_fijo` intenta devolver los intereses y provocar que nadie pueda sacar plata.

También quedaría expuesto a un **DoS por gas** si uno de estos contratos tiene en su `receive()` código para consumir una cantidad excesiva de gas provocando que la transacción que la llamó se quede sin este y revierta.

---

### 1.5 Fix

Para arreglar esto existe el patrón ***pull-over-push*** visto en clase donde forzamos a que cada inversor deba realizar una transacción para que le devolvamos los intereses, en lugar de que el contrato itere por cada uno, quedando expuesto por realizar llamadas a contratos externos.

Además deberíamos modificar como almacenamos la información de los clientes. Pasando a utilizar un `mapping` nos ahorraríamos tener que iterar por el arreglo para buscar al inversor que necesitamos, reduciendo el consumo de gas.

Ahora cada uno que quiera cobrar sus intereses debe armar una transacción, la cual por tratarse de devolverle a una sola cuenta y no a todas es más barata y evita que cada inversor se vea afectado por cuántas personar invirtieron en nuestro contrato, lo cual debería ser transparente para el.

Respecto al impacto, estamos trasladando la responsabilidad de cobrar los intereses al inversor.

---

### 1.6 ¿Alguna herramienta la detecta?

Corrimos [*slither* sobre el contrato](./ethereum/slither_output.md) y lo único que nos marcó que podría ser un indicio es lo siguiente:

```md
costly-loop
Impact: Informational
Confidence: Medium
 - [ ] ID-395
[plazo_fijo.devolver_intereses()](src/dos_por_gas.sol#L64-L81) has costly operations inside a loop:
  - [inversores.pop()](src/dos_por_gas.sol#L69)
src/dos_por_gas.sol#L64-L81
```

Es decir que dentro de un *loop* estamos realizando una operación costosa. No nos parece que detecte específicamente el **DoS por gas** pero sí te puede dar una pista, ya que si dentro de un *loop* estas haciendo una operación costosa te interesaría que la cantidad de iteraciones de ese *loop* no dependa de la cantidad de usuarios del contrato, en este caso inversores. El punto en contra es que podrías tener operaciones que no sean consideradas por *slither* como costosas dentro de un *loop* que crece exponencialmente con la cantidad de usuarios del contrato y esto no te lo detectaría.

---

### 1.7 ¿Tiene un análogo en el otro modelo?

La más similar que encontramos en el otro modelo es **C5: Unbounded inputs (*fragmentación del estado*)**, ya que ambas buscan elevar el costo de la ejecución de la transacción para que la operación quede inusable, es decir ambas son un ***denial of service***.

---

## C4: Minting policy que no valida el token name ni la cantidad

### 2.1 ¿Qué es?

- Los *tokens* son activos que podemos guardar en los **eUTXOs** de **Cardano**.
- Estos se definen con un `AssetName` y su `policyId`. El `policyId` se obtiene a partir del *hash* del código del *script* que es su ***minting policy***.
- La ***minting policy*** define el validador del *token*.
- Muchos *tokens* distintos pueden tener el mismo *validador* y por lo tanto el mismo `policyId`.
- Si al escribir una ***minting policy*** no diferenciamos por el *token name* permitimos el mismo comportamiento para todos los de mismo `policyId`. Esto es un problema cuando no es lo que se pretendía en un principio, ya que si nuestra intención era que la ***minting policy*** fuera para los *tokens* de un nombre en particular ahora podríamos acabar validando *tokens* que no queríamos.
- Además en una transacción una ***minting policy*** se corre solo una vez, así que si hay múltiples *tokens* con el mismo `policyId`, debemos contemplarlo en el código de la ***minting policy*** para aplicar la validación sobre todos ellos.
- Otro aspecto a tener en cuenta es que en la ***minting policy*** debemos distinguir si la cantidad del *token* es negativa o positiva, ya que en el primer caso debemos quemarlo y en el segundo crearlo. Estas son operaciones distintas que pueden tener distintos requerimientos y que debemos diferenciarlos para tratarlos por separado para evitar que el validador no cumpla lo esperado.

---

### 2.2 ¿Por qué existe en ese modelo?

- **Cardano** decidió tratar a los *tokens* de forma nativa, como los **ADAs**, es decir que es el ***ledger*** de la ***blockchain*** el que lleva registro de las transferencias de estos en lugar de tener que crear un ***smart contract*** específico para ese *token* que se encargue de eso como pasaría en **Ethereum**. Esto reduce costos, repetición de código y complejidad según este [artículo](https://www.iog.io/news/native-tokens-on-cardano). Además que el de ***ledger*** de **Cardano** ha sido extendido para soportar activos más allá de la *cryptocurrency* de la ***blockchain*** para permitir esto (*multi-asset ledger*).
- El hecho de asociar a los *tokens* su ***minting policy*** en la identificación de estos garantiza que esta política no va a cambiar. Además de permitir ahorrarse una tabla global que matchee *tokens* con su ***minting policy***. También permite que las transferencias se hagan sin necesidad de ejecutar código extra, sino que funcionan como una transferencia de **ADAs**. Estos son algunas de las ventajas y razones de por qué se decidió que fuera así en **Cardano** que menciona este [artículo](https://www.iog.io/news/native-tokens-on-cardano-core-principles-and-points-of-difference).
- Al usar una cantidad negativa para referir a quemar *tokens* y una positiva para crear tiene muchas ventajas:
  - Al usar la misma ***minting policy*** tanto para crear como para destruir, podés tener su *hash* como parte del identificador del *token*. Si las tuvieras separadas tendrías que tener ambos o para uno tener una tabla de indirección.
  - Te permite hacer un llamado a la ***minting policy*** por cada `policyId` en vez de tener que hacer una diferenciación de si es *burning* o *minting*. Dejan que se encargue de eso el validador.

---

### 2.3 Ejemplo mínimo que la exhibe

Los ejemplos típicos son:

- Crear un *token* con la misma ***minting policy*** pero con nombre distinto y realizar la transacción, así el validador que no chequea el *token name* lo acepta.
- Intentar quemar un *token* que no debería pero que el validador me lo permita porque hizo los chequeos asumiendo que estaba en el caso de *minting*.

---

### 2.4 Test que la demuestra

- El `test_02_puedo_crear_token_no_valido()` de `minting_policy_vulnerable.ak` muestra como se nos permite crear un *token* con otro nombre, lo cual no es correcto ya que en este problema nos interesa que la ***minting policy*** sirva solo para crear *tokens* de entradas. Si otro contrato asumiera que todos los *tokens* creados con el `policyID` de esta ***minting policy*** son correctos, entonces también quedaría expuesto por esta vulnerabilidad.
- El `test_03_para_quemar_token_necesito_firma_del_usuario()` muestra como al no distinguir entre cantidad positiva y negativa en el *mint*, entonces se aplican los mismos criterios de validación para crear y destruir *tokens*. Puede que por el dominio del problema nos interese que no haya restricciones para quemar pero por este error estemos requiriendo que se cumplan las restricciones para crear. En nuestro caso se nos ocurrió que no es necesaria una firma para quemarlo.
- El `test_05_puedo_crear_muchos_tokens_validos_en_una_transaccion()` muestra como no solo no distringuir entre cantidades positivas y negativas puede ser una vulnerabilidad, sino que también se debe chequear que esten en un rango válido. En ese caso nos deja crear un montón de *tokens* de entradas con una sola transacción.
- El test `test_06_uno_valido_tapa_resto_invalido()` está para mostrar que se deben hacer los chequeos sobre todos los *tokens* a crear/quemar en la transacción, ya que la ***minting policy*** corre una sola vez por transacción y no una por cada token a crear/quemar con ese `policyId`.

---

### 2.5 Fix

1. Agregamos que al crear el validador se deba proveer el nombre del *token* a crear y los que se intentan quemar/crear no coinciden que el validador rechace.
2. Pusimos un límite a la cantidad de *tokens* por transacción.
3. Añadimos que solo para crear se solicite la firma de la organización.
4. Chequeamos que la cantidad de *tokens* a crear esté por debajo o sea igual al límite declarado en un inicio.

---

### 2.6 ¿Alguna herramienta la detecta?

No tenemos un *slither* como en **Ethereum**, así que la única forma de detectarlo es siguiendo una checklist de aspectos a tener en cuenta para evitar vulnerabilidades en **Cardano** y/o hacer *fuzzing*. 

En el código agregamos algunos ejemplos de *fuzzing* donde se ve cómo se encuentran los contraejemplos, en nuestro caso no da más información que los test ya que es un ejemplo sencillo, pero en un proyecto más grande tendría más sentido hacer *fuzzing* sobre todas las propiedades ya que así se prueba sobre más inputs que los que haríamos con test manuales.

---

### 2.7 ¿Tiene un análogo en el otro modelo?

No, porque:

- En el *modelo de cuentas* de **Ethereum** no tenés la particularidad de que los *tokens* sean nativos, sino que necesitás crear un contrato específico para un *token* y en él llevar el registro de quién lo posee y toda la información necesaria.
- En **Ethereum** la implementación del contrato de [ERC-20 de *OpenZeppelin*](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.3.0/contracts/token/ERC20/ERC20.sol) muestra como tiene un método para `_burn()` y otro para `_mint()` por lo que no existe el problema de que ambos métodos sean iguales a menos que se lo haga a propósito. Además ambos reciben enteros positivos así que no tiene sentido chequear si la cantidad es negativa para ver si es *burn* o positiva para ver si es *mint*, esto es una particularidad de Cardano.
- En ese mismo la implementación de *ERC-20* vemos como al crear una instancia de ese contrato debemos proveer el atributo `name`, cuyo análogo en **Cardano** es el *assetName*. Siempre que nos refiramos a esa instancia del contrato se utilizará el único valor de *name* que tiene y no puede pasar que una función de esta instancia se ejecute sobre un *token* con un nombre distinto.
- En **Ethereum** para quemar o crear un *token* necesitás la instancia del contrato específica con la que se lo creó, no sucede que una misma política, como es la ***minting policy*** se ejecute para múltiples *tokens* distintos pero que coincidan en `policyId`.

Si te abstraés de todos estos detalles el problema de fondo es que no se hacen las validaciones necesarias sobre los inputs, este problema si que puede ocurrir tanto en **Cardano** donde tenés validadores como en **Ethereum** donde tampoco tenés que asumir nada sobre lo que te provee el que armó la transacción y tenés que chequear todo.

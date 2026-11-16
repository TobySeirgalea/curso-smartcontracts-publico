# Informe sobre vulnerabilidades en Ethereum y Cardano

## DoS por gas

### ¿Qué es?

Los contratos requieren de gas para poder ejecutar sus funciones. En el caso de no contar con suficiente gas no se puede ejecutar o completar su ejecución, en caso de que ya haya iniciado, impidiendo al que la invocó obtener los resultados esperados.

### ¿Por qué existe en ese modelo?

Ethereum tiene la característica de ser *Turing complete*, lo cual le permite computar funciones de cualquier tipo de complejidad. Si combinamos eso con el resultado del *Halting problem*, de que dado un programa y un input cualesquiera, no es computable determinar si termina, entonces alguien podría crear un contrato que  no termine y, como por el mecanismo de consenso todos los nodos participantes de la red deben validar cada transacción ejecutando ese *smart contract*, permitiríamos que toda la red entre en un estado de loops infinitos. Para evitar eso se inventó el mecanismo de *gas*, el cual sirve para acotar la cantidad de pasos de ejecución y garantizar la terminación, ya que si una ejecución no termina por haber ejecutado todas sus instrucciones, entonces lo hará porque se queda sin *gas*. Al realizar una transacción se le debe proveer de suficiente *gas* para que se pueda ejecutar, el cual se paga con *ether* que es la moneda de *Ethereum* y cuya cantidad en circulación está acotada.

### Ejemplo mínimo que la exhibe

El ejemplo clásico es cuando tenemos que recorrer estructuras que crecen en tamaño con la cantidad de usuario del contrato, aumentando el costo de la transacción y provocando que en caso de no contar con suficiente gas se deba aplicar `revert`.

### Test que la demuestra

Hacer un test para demostrarlo es bastante complejo. En un principio pensamos que con llenar el arreglo para luego poner un `vm.expectRevert()` al intentar ejecutar `devolver_intereses()` alcanzaría, pero no. Hay dos aspectos a controlar: uno es el gas del test y otro es el de la transacción que queremos demostrar que sufre el *denial of service*, si no tenés en cuenta el gas que consume el test, entonces este va a fallar por `Evm error: Out of Gas`. Se nos ocurrieron dos formas de tests que pueden servir para demostrar la vulnerabilidad.

- La primera:
  - Consiste en mostrar que cuando el arreglo está muy lleno y un usuario quiera invertir la transacción va a tener un costo muy alto, ya que este crece con la cantidad de inversores en el contrato.
  - Para darnos cuenta de esto podemos usar el gas propio del test, así si llegamos a un punto donde ya no podemos realizar más inversiones porque el costo de estas supera el gas que nos queda en el test, entonces tranquilamente podría pasarle a un usuario que si el contrato cuenta con muchos inversores el costo de la transacción para invertir sea muy alto y sea revertida por falta de gas.
  - Esta se ve en el test `test_dos_por_gas_sin_limitar_gas()`.

- La segunda:
  - Esta consiste en ponerle un límite explícito al gas que tiene disponible para cada llamada a `invertir`, de modo que si en algún momento se alcanza ese límite quiere decir que una transacción de `invertir` requiere de una cantidad de gas mayor a esa.
  - Al igual que en la primera, si la transacción requiere de mucho gas y no dispone de él se revertirá provocando un *denial of service* al cliente que legitimamente quería usar el contrato.
  - Esta se ve en el test `test_dos_por_gas_limitando_gas()`.

Viendo el código de `plazo_fijo` nos dimos cuenta que otro posible ataque DoS (aunque no sería por gas), podría ser si una de las transacciones de devolución revierte, lo cual hace que la transacción original de `devolver_intereses()` de `plazo_fijo` no permita que ninguno de los inversores retire el dinero. Para evidenciarla tenemos el test `test_ataque_por_no_implementar_receive()` donde mostramos que si un contrato no implementa el `receive()` ni el `fallback()` podría revertirse cuando `plazo_fijo` intenta devolver los intereses y provocar que nadie pueda sacar plata.

También quedaría expuesto a un DoS por gas si uno de estos contratos tiene en su `receive()` código para consumir una cantidad excesiva de gas provocando que la transacción que la llamó se quede sin este y revierta.

### Fix

Para arreglar esto existe el patrón *pull-over-push* visto en clase donde forzamos a que cada inversor deba realizar una transacción para que le devolvamos los intereses, en lugar de que el contrato itere por cada uno, quedando expuesto por realizar llamadas a contratos externos.

Además deberíamos modificar como almacenamos la información de los clientes. Pasando a utilizar un `mapping` nos ahorraríamos tener que iterar por el arreglo para buscar al inversor que necesitamos, reduciendo el consumo de gas.

Ahora cada uno que quiera cobrar sus intereses debe armar una transacción, la cual por tratarse de devolverle a una sola cuenta y no a todas es más barata y evita que cada inversor se vea afectado por cuántas personar invirtieron en nuestro contrato, lo cual debería ser transparente para el.

Respecto al impacto, estamos trasladando la responsabilidad de cobrar los intereses al inversor.

### ¿Alguna herramienta la detecta?

Corrimos [*slither* sobre el contrato](./ethereum/slither_output.md) y lo único que nos marcó que podría ser un indicio es lo siguiente:

```
costly-loop
Impact: Informational
Confidence: Medium
 - [ ] ID-395
[plazo_fijo.devolver_intereses()](src/dos_por_gas.sol#L64-L81) has costly operations inside a loop:
	- [inversores.pop()](src/dos_por_gas.sol#L69)
src/dos_por_gas.sol#L64-L81
```

Es decir que dentro de un loop estamos realizando una operación costosa. No nos parece que detecte específicamente el DoS por gas pero sí te puede dar una pista, ya que si dentro de un loop estas haciendo una operación costosa te interesaría que la cantidad de iteraciones de ese loop no dependa de la cantidad de usuarios del contrato, en este caso inversores. El punto en contra es que podrías tener operaciones que no sean consideradas por *slither* como costosas dentro de un loop que crece exponencialmente con la cantidad de usuarios del contrato y esto no te lo detectaría.

### ¿Tiene un análogo en el otro modelo?

La más similar en el otro modelo es C5: Unbounded inputs (fragmentación del estado), ya que ambas buscan elevar el costo de la ejecución de la transacción para que la operación quede inusable, es decir ambas son un *denial of service* y ambas buscan hacerlo elevando el costo de ejecución.


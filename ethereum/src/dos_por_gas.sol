// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Test.sol";


/// @title dos_por_gas — ahorro en ETH con cierre por parte del owner
contract plazo_fijo {
    //Atributos
    address immutable owner;
    mapping(address => uint256) private cantidad_invertida;
    uint256 immutable interes;
    address[] public inversores;
    bool public inscripcion_abierta;
    
    //Eventos
    event Inversion_realizada(address indexed inversor, uint256 monto_invertido);
    event Interes_devuelto(address indexed inversor);
    error Sin_gas(uint256 gasLeft);
    //Errores
    error Inscripcion_cerrada();
    error Corralito();
    error NotOwner();

    constructor(uint256 interes_prometido) payable{
        require(interes_prometido > 1, "El interes debe ser mayor que 1");
        interes = interes_prometido;
        owner = msg.sender;
        inscripcion_abierta = true;
    }

    // Modifiers
    modifier onlyOwner() {
        if (msg.sender != owner) revert NotOwner();
        _;
    }

    //Funciones
    function cerrar_incripcion() public onlyOwner{
        inscripcion_abierta = false;
    }


    /// @notice Invertir monto_inversion ETH
    function invertir() external payable {
        bool ya_registrado = false;
        uint256 monto_inversion = msg.value;
        uint256 gasPrevio = gasleft();
        if (!inscripcion_abierta) revert Inscripcion_cerrada();
    
        for(uint256 i = 0; i < inversores.length; i++){
            if (inversores[i] == msg.sender){
                ya_registrado = true;
            }
        }
        if (!ya_registrado){
            inversores.push(msg.sender);
        }
        cantidad_invertida[msg.sender] += monto_inversion;
        emit Inversion_realizada(msg.sender, monto_inversion);
    }

    // @notice Devolver intereses del plazo fijo
    function devolver_intereses() external onlyOwner {
        address inversor;
        while (inversores.length > 0){

            inversor = inversores[inversores.length -1]; 
            inversores.pop();
            uint256 monto_invertido = cantidad_invertida[inversor];
            cantidad_invertida[inversor] = 0;

            (bool ok, ) = inversor.call{value: monto_invertido*interes}("");

            if (!ok) {
                revert Corralito();
            }

            emit Interes_devuelto(inversor);
        }
    }
}

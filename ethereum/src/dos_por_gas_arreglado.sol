// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/// @title dos_por_gas — ahorro en ETH con cierre por parte del owner
contract plazo_fijo_arreglado {
    //Atributos
    mapping(address => bool) inversores;
    mapping(address => uint256) private cantidad_invertida;
    uint256 immutable interes;
    bool public inscripcion_abierta;
    address immutable owner;

    //Eventos
    event Inversion_realizada(address indexed inversor, uint256 monto_invertido);
    event Interes_devuelto(address indexed inversor);
    
    //Errores
    error Inscripcion_cerrada();
    error Devolucion_fallida();
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
    // Pasamos a usar un mapping en vez de un arreglo ahorrandonos tener que hacer su recorrido que aumenta consumo de gas a medida que aumenta cantidad de inversores
    function invertir() external payable {
        inversores[msg.sender] = true;
        uint256 monto_inversion = msg.value;
        if (!inscripcion_abierta) revert Inscripcion_cerrada();
    
        cantidad_invertida[msg.sender] += monto_inversion;
        emit Inversion_realizada(msg.sender, monto_inversion);
    }

    // @notice Devolver intereses del plazo fijo
    // En vez de devolverle a todos en una sola transacción, lo cual consume mucho gas por recorrer el arreglo de inversores entero, podemos dejarle esa responsabilidad al inversor. Si el inversor quiere retirar su dinero una vez el banco decide que venza el plazo fijo puede realizar una transacción de extracción. De este modo cada uno crea una transacción y evitamos que en caso de gas insuficiente nadie pueda retirar los fondos por el alto consumo de gas de la transacción, como pasaría si la cantidad de inversores es demasiado grande. Además solucionamos el otro problema de depender de que llamadas externas al contrato (como puede ser enviarle el dinero a cada inversor) nos puedan ocasionar el problema de que ninguno pueda recibir, ya que si una rechaza, toda la transacción rechaza.
    function devolver_intereses() external {
        address inversor = msg.sender;
        require(!inscripcion_abierta, "El plazo fijo debe estar cerrado");     
        require(inversores[inversor], "Debe haber invertido para retirar");
        uint256 monto_invertido = cantidad_invertida[inversor];
        cantidad_invertida[inversor] = 0;
        (bool ok, ) = inversor.call{value: monto_invertido*interes}("");
        if (!ok) {
            revert Devolucion_fallida(); //Ahora ya no es un corralito porque solo falla para el que solicitó la devolución y no para todos los otros inversores
        }
        emit Interes_devuelto(inversor);
    }
}

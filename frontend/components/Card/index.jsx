import React from 'react';
import imagen from "../../assets/171352_calculator_icon.png"
import { Link } from 'react-router-dom';


const Card = () => {
    return (

        <Link to={"/calculator"}>
            <div className="card">
                <img src={imagen} alt="Calculadora" />
                <div className="card-content">
                    <h3>Calculator</h3>
                    <p>"Esta calculadora te permite sumar, restar, multiplicar y dividir números, además de calcular potencias y raíces. Simplemente ingresa un número inicial y selecciona la operación deseada. Obtén resultados precisos y realiza cálculos rápidos en tareas escolares, proyectos o situaciones cotidianas. ¡Descubre la versatilidad de esta práctica calculadora!"</p>
                </div>
            </div>
        </Link>
    );
};

export default Card;
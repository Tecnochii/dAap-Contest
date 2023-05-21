import React from 'react';
import { Link } from 'react-router-dom';

const Nav = () => {
  return (
    <ul className="navbar">
      <li><Link to="/">Home</Link></li>
      <li><Link to="/calculator">Calculator</Link></li>
      {/* <li><a href="#servicios">Servicios</a></li>
      <li><a href="#contacto">Contacto</a></li> */}
    </ul>
  );
};

export default Nav;
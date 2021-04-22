import React from "react";
import Link from "./Link";
import "../style/header.css";

const Header = () => {
  return (
    <div className="navbar">
      <Link href="/" className="item">
        GymFit
      </Link>
      <div className="toggle-button">|||</div>
      <div className="nav-menu">
        <Link href="/trainer" className="item">
          Trainer
        </Link>
        <Link href="/employee" className="item">
          Employee
        </Link>
        <Link href="/client" className="item">
          Client
        </Link>
      </div>
    </div>
  );
};

export default Header;

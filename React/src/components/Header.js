import React, { useState } from "react";
import Link from "./Link";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faBars } from "@fortawesome/free-solid-svg-icons";
import "../style/header.css";
import useWindowSize from "../hooks/useWindowSize";
import { CSSTransition } from "react-transition-group";

const Header = () => {
  const [showMobileMenu, setShowMobileMenu] = useState(false);
  const { width } = useWindowSize();

  let menu;
  let hamburger;
  let mobileMenu;
  let mobileMenuMask;

  if (width >= 768) {
    menu = (
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
    );
  } else {
    hamburger = (
      <div className="toggle-button">
        <FontAwesomeIcon
          icon={faBars}
          onClick={() => setShowMobileMenu(!showMobileMenu)}
        />
      </div>
    );

    mobileMenu = (
      <div className="menu">
        <CSSTransition
          in={showMobileMenu}
          unmountOnExit
          timeout={500}
          classNames="mobile-menu"
        >
          <div className="nav-mobile-menu">
            <Link href="/trainer" className="item-mobile">
              Trainer
            </Link>
            <Link href="/employee" className="item-mobile">
              Employee
            </Link>
            <Link href="/client" className="item-mobile">
              Client
            </Link>
          </div>
        </CSSTransition>
      </div>
    );

    if (showMobileMenu) {
      mobileMenuMask = (
        <div
          className="mobile-menu-mask"
          onClick={() => setShowMobileMenu(false)}
        ></div>
      );
    }
  }

  return (
    <header className="navbar">
      <Link href="/" className="item">
        GymFit
      </Link>
      {mobileMenuMask}
      {mobileMenu}
      {hamburger}
      {menu}
    </header>
  );
};

export default Header;

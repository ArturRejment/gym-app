import React from "react";
import "../style/homepage.css";
import Header from "./Header";

export default function Homepage() {
  return (
    <div className="page-image">
      <Header />
      <div className="landing-page-text">
        <p>
          This is not a sprint,
          <br /> this is a marathon
        </p>
      </div>
    </div>
  );
}

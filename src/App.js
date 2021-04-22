import React from "react";
import Route from "./components/Route";
import Homepage from "./components/Homepage";
import Trainer from "./components/Trainer";
import Employee from "./components/Employee";
import Client from "./components/Client";
// import "./style/style.css";

const App = () => {
  return (
    <div>
      <Route path="/">
        <Homepage />
      </Route>
      <Route path="/trainer">
        <Trainer />
      </Route>
      <Route path="/employee">
        <Employee />
      </Route>
      <Route path="/client">
        <Client />
      </Route>
    </div>
  );
};

export default App;

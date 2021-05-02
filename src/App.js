import React from "react";
import Route from "./components/Route";
import Homepage from "./components/Homepage";
import Login from "./components/Login";

const App = () => {
  return (
    <div>
      <Route path="/">
        <Homepage />
      </Route>
      <Route path="/trainer">
        <Login />
      </Route>
      <Route path="/employee">
        <Login />
      </Route>
      <Route path="/client">
        <Login />
      </Route>
    </div>
  );
};

export default App;

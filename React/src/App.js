import React from 'react';
import Homepage from './components/Homepage';
import Login from './components/Login';
import UserPage from './components/UserPage';
import { BrowserRouter, Route } from 'react-router-dom';

const App = () => {
	return (
		<div>
			<BrowserRouter>
				<div>
					<Route path="/" exact component={Homepage} />
					<Route path="/trainer" exact component={Login} />
					<Route path="/employee" exact component={Login} />
					<Route path="/client" exact component={Login} />
					<Route path="/user" exact component={UserPage} />
				</div>
			</BrowserRouter>
		</div>
	);
};

export default App;

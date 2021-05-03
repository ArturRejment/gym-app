import React, { useState } from 'react';
import LoginForm from './LoginForm';
import { Link } from 'react-router-dom';
import '../style/login.css';
import UserPage from './UserPage';

export default function Login() {
	const adminUser = {
		email    : 'admin@admin.com',
		password : 'admin'
	};

	const [ user, setUser ] = useState({ name: '', email: '' });
	const [ error, setError ] = useState('');

	const Login = (details) => {
		if (details.email === adminUser.email && details.password === adminUser.password) {
			setUser({
				name  : details.name,
				email : details.email
			});
		} else {
			setError('Details do not match!');
		}
	};

	const Logout = () => {
		setUser({ name: '', email: '' });
	};

	return (
		<div className="login">
			<Link to="/" className="back-button">{`< back`}</Link>
			{/* {user.email !== "" ? (
        <UserPage />
      ) : (
        <LoginForm Login={Login} error={error} />
      )} */}
			<LoginForm Login={Login} error={error} />
		</div>
	);
}

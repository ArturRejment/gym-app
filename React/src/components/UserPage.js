import React from 'react';
import useResults from '../hooks/useResults';

function UserPage() {
	const products = useResults('Products');
	const members = useResults('GymMember');
	const trainers = useResults('Trainer');

	const renderedProducts = products.map((product) => {
		return <div key={product.product_id}>{product.product_name}</div>;
	});

	const renderedMembers = members.map((member) => {
		return (
			<div key={member.member_id}>
				{member.first_name} {member.last_name}
			</div>
		);
	});

	const renderedTrainers = trainers.map((trainer) => {
		return (
			<div key={trainer.trainer_id}>
				{trainer.first_name} {trainer.last_name}
			</div>
		);
	});

	return (
		<div>
			<div>{renderedProducts}</div>
			<br />
			<div>{renderedMembers}</div>
			<br />
			<div>{renderedTrainers}</div>
		</div>
	);
}

export default UserPage;

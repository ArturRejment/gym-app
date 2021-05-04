import React from 'react';
import useResults from '../hooks/useResults';
import '../style/user.css';

function UserPage() {
	const addresses = useResults('Address');
	const trainer1hours = useResults('Trainer1');
	const trainer2hours = useResults('Trainer2');

	const renderedAddresses = addresses.map((address) => {
		return <div key={address.address_id}>{address.city}</div>;
	});

	const renderedTrainer1Hours = trainer1hours.map((record) => {
		return (
			<div key={record.working_start}>
				{record.working_start} {record.working_finish}
			</div>
		);
	});

	const renderedTrainer2Hours = trainer2hours.map((record) => {
		return (
			<div key={record.working_start}>
				{record.working_start} {record.working_finish}
			</div>
		);
	});

	return (
		<div>
			<div className="list">{renderedAddresses}</div>
			<br />
			<div className="list">{renderedTrainer1Hours}</div>
			<br />
			<div className="list">{renderedTrainer2Hours}</div>
		</div>
	);
}

export default UserPage;

import { useState, useEffect } from 'react';
import resultsAPI from '../apis/resultsAPI';

const useResults = (term) => {
	const [ results, setResults ] = useState([]);

	useEffect(
		() => {
			getResults(term);
		},
		[ term ]
	);

	const getResults = async (term) => {
		const { data } = await resultsAPI.get(`/${term}`);
		setResults(data);
	};
	return results;
};

export default useResults;

SELECT
	id,
	version,
	created_by,
	DATE_FORMAT(created_on, '%d-%m-%Y %H:%i:%s') AS created_on,
	remarks
FROM `_releases`
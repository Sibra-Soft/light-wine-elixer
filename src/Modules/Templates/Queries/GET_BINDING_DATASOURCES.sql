SELECT
	queries.id,
	queries.`name`
FROM site_templates AS queries
WHERE queries.type = 'sql'
SELECT
	id AS `value`,
	`name` AS caption
FROM site_templates AS templates
WHERE templates.type = 'sql'
ORDER BY `name`
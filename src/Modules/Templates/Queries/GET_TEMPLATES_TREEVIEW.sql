SELECT * FROM (
	SELECT * FROM (
		SELECT
			templates.id,
			templates.`name`,
			templates.type,
			IF(templates.parent_id = 0, 'ROOT', CONCAT(UPPER(parent.type), '|', parent.id)) AS parent_key,
			IF(templates.type = 'folder', 'folder', 'template') AS `group`,
			CONCAT(UPPER(templates.`type`), '|', templates.id) AS object_key,
			CASE
				WHEN templates.type = 'folder' AND templates.parent_id = 0 THEN 0
				WHEN templates.type = 'folder' THEN 1
				ELSE 2
			END AS ordering 
		FROM site_templates AS templates
		LEFT JOIN site_templates AS parent ON parent.id = templates.parent_id
	) AS x
	UNION
	SELECT
		bindings.id,
		bindings.`name`,
		'binding',
		UPPER(CONCAT(templates.type, '|', templates.id)),
		'binding',
		UPPER(CONCAT('binding', '|', bindings.id)),
		2
	FROM site_bindings AS bindings
	INNER JOIN site_templates AS templates ON templates.id = bindings.destination_template_id
) AS x
ORDER BY x.ordering, x.parent_key, x.`name`
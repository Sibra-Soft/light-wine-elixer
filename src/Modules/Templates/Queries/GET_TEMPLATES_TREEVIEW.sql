SELECT
	templates.id,
	templates.`name`,
	templates.type,
	IF(templates.parent_id = 0, 'ROOT', CONCAT(UPPER(parent.type), '|', parent.id)) AS parent_key,
	IF(templates.icon_index = 0 AND templates.type = 'folder', 1, templates.icon_index) AS icon_index,
	CONCAT(UPPER(templates.`type`), '|', templates.id) AS object_key,
	CASE
		WHEN templates.type = 'folder' AND templates.parent_id = 0 THEN 0
		WHEN templates.type = 'folder' THEN 1
		ELSE 2
	END AS ordering 
FROM site_templates AS templates
LEFT JOIN site_templates AS parent ON parent.id = templates.parent_id
ORDER BY ordering, parent_key, templates.`name`
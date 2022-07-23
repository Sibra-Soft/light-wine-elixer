SELECT
	template.`name`,
	UPPER(template.`type`) AS `type`,
	DATE_FORMAT(template.date_added, '%d-%m-%Y %H:%i:%s') AS date_added,
	DATE_FORMAT(template.date_modified, '%d-%m-%Y %H:%i:%s') AS date_modified,
	template.created_by,
	template.modified_by,
	template.template_version_dev,
	template.policies,
	IF(template.active = 1, 'Yes', 'No') AS active
FROM site_templates AS template
WHERE template.id = ?template_id
LIMIT 1;
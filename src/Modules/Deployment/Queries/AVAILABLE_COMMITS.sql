SELECT
	template.id,
	template.`name`,
	template.template_version_live AS `live_version`,
	template.template_version_test AS `test_version`,
	template.template_version_dev AS `current_version`,
	template.type,
	DATE_FORMAT(IFNULL(template.date_modified, template.date_added), '%d-%m-%Y %H:%i:%s') AS date_modified,
	IFNULL(template.modified_by, template.created_by) AS modified_by
FROM `site_templates` AS template
LEFT JOIN _commits_objects AS commit_objects ON commit_objects.template_id = template.id AND commit_objects.template_version = template.template_version_dev
WHERE template.type NOT IN ('folder')
	AND commit_objects.template_version IS NULL
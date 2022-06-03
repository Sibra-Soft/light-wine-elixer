SELECT
	template.id,
	template.`name`,
	template.parent_id,
	template.`order`,
	template.date_added,
	template.date_modified,
	template.scripts,
	template.stylesheets,
	template.created_by,
	template.modified_by,
	template.policies,
	template.type,
	template.active,
	template.caching_hours,
	template.icon_index,

	content.content,
	version.version,

	LENGTH(content.content) AS size
FROM site_templates AS template
INNER JOIN (
	SELECT 
		template_id, 
		MAX(version) AS version
	FROM site_template_versioning
	GROUP BY template_id
) AS version ON version.template_id = template.id
LEFT JOIN site_template_versioning AS content ON content.template_id = template.id AND content.version = version.version

WHERE template.id = ?templateId
LIMIT 1;
SELECT
	templates.id,
	templates.`name`,
	templates.type,
	IF(FIND_IN_SET(templates.id, linked.scripts) > 0 OR FIND_IN_SET(templates.id, linked.stylesheets) > 0, 1, 0) AS linked
FROM site_templates AS templates

# Get the selected HTML template
LEFT JOIN (
	SELECT id, scripts, stylesheets FROM site_templates AS template WHERE template.type = 'html'
) AS linked ON linked.id = ?selected_template

WHERE templates.type IN ('javascript', 'css')
ORDER BY templates.`name`
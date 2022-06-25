SELECT 
	x.*,
	CASE x.method
		WHEN 'GET' THEN 'green'
		WHEN 'POST' THEN 'blue'
		WHEN 'DELETE' THEN 'red'
		WHEN 'PUT' THEN 'orange'
 	END AS color
FROM (
	SELECT
		page_routes.id,
		page_routes.method,
		page_routes.`name`,
		page_routes.url AS path,
		DATE_FORMAT(page_routes.date_created, '%d-%m-%Y %H:%i:%s') AS date_created,
		'PAGE' AS type
	FROM site_routes AS page_routes
	UNION
	SELECT
		api_routes.id,
		api_routes.allowed_methodes,
		api_routes.`name`,
		api_routes.match_pattern,
		DATE_FORMAT(api_routes.date_created, '%d-%m-%Y %H:%i:%s') AS date_created,
		'API' AS type
	FROM site_rest_api AS api_routes
) AS x
ORDER BY x.`name`
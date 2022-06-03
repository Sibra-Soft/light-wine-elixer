SELECT * FROM (
	SELECT
		page_routes.id,
		page_routes.method,
		page_routes.`name`,
		page_routes.url,
		page_routes.date_created,
		'PAGE' AS type
	FROM site_routes AS page_routes
	UNION
	SELECT
		api_routes.id,
		api_routes.allowed_methodes,
		api_routes.`name`,
		api_routes.match_pattern,
		api_routes.date_created,
		'API' AS type
	FROM site_rest_api AS api_routes
) AS x
ORDER BY x.`name`
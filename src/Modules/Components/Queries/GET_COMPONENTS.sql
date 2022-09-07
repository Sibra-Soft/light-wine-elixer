SELECT
	dync_content.id,
	dync_content.`name`,
	dync_content.`mode`,
	dync_content.type,
	DATE_FORMAT(dync_content.added_on, '%d-%m-%Y %H:%i:%s') AS added_on
FROM site_dynamic_content AS dync_content
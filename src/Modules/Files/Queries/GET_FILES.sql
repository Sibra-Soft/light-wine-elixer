SELECT
	files.id,
	files.`filename` AS `name`,
	IFNULL(files.`type`, 'image') AS `type`,
	DATE_FORMAT(files.date_added, '%d-%m-%Y %H:%i:%s') AS date_added,
	DATE_FORMAT(IFNULL(files.date_modified, ''), '%d-%m-%Y %H:%i:%s') AS date_modified,
	FORMAT_BYTES(CAST(IFNULL(LENGTH(files.content), IFNULL(folder_size.size, 0)) AS INT)) AS size,
	files.parent_id,
	CASE files.content_type
		WHEN 'image/png' THEN 'image-png'
		WHEN 'image/jpeg' THEN 'image-jpg'
 	END AS icon,
	IF(files.type = 'folder', TRUE, FALSE) AS is_folder
FROM site_files AS files
LEFT JOIN (
	SELECT 
		SUM(LENGTH(folders.content)) AS size, 
		folders.parent_id
	FROM site_files AS folders
	GROUP BY id
) AS folder_size ON folder_size.parent_id = files.id
WHERE IF(?parent = '#', files.parent_id = 0, files.parent_id = ?parent)
GROUP BY files.id
ORDER BY is_folder DESC, files.filename
SELECT
	commits.id,
	commits.description,
	commits.created_by,
	DATE_FORMAT(commits.created_on, '%d-%m-%Y %H:%i:%s') AS created_on,
	COUNT(objects.id) AS template_count
FROM `_commits` AS commits
INNER JOIN `_commits_objects` AS objects ON objects.commit_id = commits.id
WHERE commits.enviroment < 5
GROUP BY commits.id
ORDER BY commits.created_on DESC
SELECT
	users.id,
	users.username,
	DATE_FORMAT(IFNULL(users.date_added, ''), '%d-%m-%Y %H:%i:%s') AS date_added,
	DATE_FORMAT(IFNULL(users.last_login, ''), '%d-%m-%Y %H:%i:%s') AS last_login,
	users.display_name,
	roles.description AS role
FROM `_users` AS users
INNER JOIN `_user_roles` AS roles ON roles.id = users.role_id
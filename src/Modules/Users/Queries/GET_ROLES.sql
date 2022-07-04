SELECT
	roles.id,
	roles.description,
	DATE_FORMAT(roles.created_on, '%d-%m-%Y %H:%i:%s') AS created_on,
	roles.created_by
FROM _user_roles AS roles
SELECT
	COUNT(translations.id) AS translations_count,
	IFNULL(MAX(translations.date_changed), 'Never') AS last_update,
	languages.`name` AS `language`,
	x.languages,
	languages.is_default AS is_default
FROM site_languages AS languages
LEFT JOIN site_translations AS translations ON translations.language_code = languages.id
LEFT JOIN (
	SELECT GROUP_CONCAT(`name`) AS languages, 1 AS `group`  FROM site_languages
) AS x ON x.`group` = 1
GROUP BY translations.language_code
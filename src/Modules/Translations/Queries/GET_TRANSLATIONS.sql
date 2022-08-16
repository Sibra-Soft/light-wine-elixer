SELECT
	translations.id,
	languages.`name`,
	translations.anchor,
	translations.translation,
	IF(NULLIF(translations.translation, '') IS NULL, 1, 0) AS is_empty
FROM site_translations AS translations
INNER JOIN site_languages AS languages ON languages.id = translations.language_code
ORDER BY translations.anchor
SELECT 
	table_name AS id,
	table_name AS caption 
FROM information_schema.tables 
WHERE table_schema = ?currentDatabase
	AND table_name LIKE '__cust%'
ORDER BY table_name
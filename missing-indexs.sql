SELECT DISTINCT
    t.name AS TableName,
    c.name AS ColumnName,
    i.name AS IndexName
FROM 
    sys.tables AS t
    INNER JOIN sys.columns c ON t.object_id = c.object_id
    LEFT JOIN sys.index_columns ic ON ic.object_id = c.object_id AND ic.column_id = c.column_id
    LEFT JOIN sys.indexes i ON i.object_id = ic.object_id AND i.index_id = ic.index_id
WHERE 
    i.name IS NULL
    AND t.is_ms_shipped = 0
    AND EXISTS (SELECT 1 FROM sys.types WHERE system_type_id = c.system_type_id AND is_user_defined = 0)
ORDER BY 
    t.name, 
    c.name

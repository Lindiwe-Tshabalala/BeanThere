DECLARE @sqlStatement NVARCHAR(MAX);

WITH ForeignKeyConstraints AS (
    SELECT fk.name AS ForeignKeyName, parent_table.name AS ParentTableName
    FROM sys.foreign_keys AS fk
    JOIN sys.tables AS parent_table ON fk.parent_object_id = parent_table.object_id
    JOIN sys.tables AS ref_table ON fk.referenced_object_id = ref_table.object_id
    WHERE (parent_table.name = 'user_roles' 
    AND ref_table.name IN ('farms', 'manufacturers', 'retailers'))
	OR (parent_table.name = 'shipments' 
    AND ref_table.name IN ('manufacturers', 'retailers'))
)

SELECT @sqlStatement = STRING_AGG('ALTER TABLE '+ QUOTENAME(ParentTableName) + ' DROP CONSTRAINT ' + QUOTENAME(ForeignKeyName), '; ')
FROM ForeignKeyConstraints;

EXEC sp_executesql @sqlStatement;



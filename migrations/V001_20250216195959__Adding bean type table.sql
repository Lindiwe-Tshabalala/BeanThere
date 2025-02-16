IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'bean_types')
BEGIN
    CREATE TABLE [bean_types] (
      [bean_id] integer PRIMARY KEY NOT NULL IDENTITY(1, 1),
      [name] varchar(100) NOT NULL
);
END;
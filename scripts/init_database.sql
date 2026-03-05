/*
Create Database and Schemas
Purpose: Creates a new database  named 'DataWarehouse' after checking if it already exists.
If the database already exists, it is dropped and recreated.
The script then sets up  3 seperate schemas within  the database: Bronze, Silver, and  Gold.

WARNING: will drop the entire database so dont use without being sure you dont need any of the data within it.
*/
USE master;
GO

  -- Drop and recreate the 'DataWarehouse' Database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
      ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
      DROP DATABASE DataWarehouse;
END;
GO

  -- Creates database
CREATE DATABASE DataWarehouse;
GO
  -- Creates the seperate schemas for each level
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO

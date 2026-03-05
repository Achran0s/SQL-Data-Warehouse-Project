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


------------------------------------------------------------
/* Create  all the tables for the data to import in from CRM and ERP  data
Purpose:  Creates the empty tables ready to import data in with correct column headings 
          and naming conventions for the Bronze level data sets
          Additionally checks if the table is already present  and drops them before recreating  them if so.
WARNING: Because of this run with caution as  it will delete and similar tables present and all data will be lost
*/
IF OBJECT_ID ('bronze.crm_cust_info',  'U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info (
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_maritalstatus NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATE
);

IF OBJECT_ID ('bronze.crm_prd_info',  'U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info (
prd_id INT,
prd_key NVARCHAR(50),
prd_nm NVARCHAR(50),
prd_cost INT,
prd_line NVARCHAR(50),
prd_start_dt DATETIME,
prd_end_dt DATETIME
);

IF OBJECT_ID ('bronze.crm_sales_details',  'U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details (
sls_ord_num NVARCHAR(50),
sls_prd_key NVARCHAR(50),
sls_cust_id INT,
sls_order_dt INT,
sls_ship_dt INT,
sls_due_dt INT,
sls_sales  INT,
sls_quantity INT,
sls_price INT
);

IF OBJECT_ID ('bronze.erp_CUST_AZ12',  'U') IS NOT NULL
	DROP TABLE bronze.erp_CUST_AZ12;
CREATE TABLE bronze.erp_CUST_AZ12 (
CID NVARCHAR(50),
BDATE DATE,
GEN NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_LOC_A101',  'U') IS NOT NULL
	DROP TABLE bronze.erp_LOC_A101;
CREATE TABLE bronze.erp_LOC_A101  (
CID NVARCHAR(50),
CNTRY NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_PX_CAT_G1V2',  'U') IS NOT NULL
	DROP TABLE bronze.erp_PX_CAT_G1V2;
CREATE TABLE bronze.erp_PX_CAT_G1V2 (
ID NVARCHAR(50),
CAT NVARCHAR(50),
SUBCAT NVARCHAR(50),
MAINTENANCE NVARCHAR(50)
);


----------------------------------------------------------------

EXEC bronze.load_procedure

CREATE OR ALTER PROCEDURE bronze.load_procedure AS
BEGIN
  DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
  BEGIN TRY
            SET @batch_start_time = GETDATE();
            SET @start_time = GETDATE();
			TRUNCATE TABLE bronze.crm_cst_info; -- Ensure that table is empty first

			BULK INSERT bronze.crm_cst_info
			FROM 'C:\Users\HELLO\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
			WITH (
			   FIRSTROW = 2,
			   FIELDTERMINATOR = ',',
			   TABLOCK
			);
			SET @end_time = GETDATE();
			PRINT 'Load Duration' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';

			SET @start_time = GETDATE();
			TRUNCATE TABLE bronze.crm_prd_info; -- Ensure that table is empty first

			BULK INSERT bronze.crm_prd_info
			FROM 'C:\Users\HELLO\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
			WITH (
			   FIRSTROW = 2,
			   FIELDTERMINATOR = ',',
			   TABLOCK
			);
			SET @end_time = GETDATE();
			PRINT 'Load Duration' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';

			SET @start_time = GETDATE();
			TRUNCATE TABLE bronze.crm_sales_details; -- Ensure that table is empty first

			BULK INSERT bronze.crm_sales_details
			FROM 'C:\Users\HELLO\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
			WITH (
			   FIRSTROW = 2,
			   FIELDTERMINATOR = ',',
			   TABLOCK
			);
			SET @end_time = GETDATE();
			PRINT 'Load Duration' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';

			SET @start_time = GETDATE();
			TRUNCATE TABLE bronze.erp_cust_az12; -- Ensure that table is empty first

			BULK INSERT bronze.erp_cust_az12
			FROM 'C:\Users\HELLO\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
			WITH (
			   FIRSTROW = 2,
			   FIELDTERMINATOR = ',',
			   TABLOCK
			);
			SET @end_time = GETDATE();
			PRINT 'Load Duration' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';

			SET @start_time = GETDATE();
			TRUNCATE TABLE bronze.erp_loc_az12; -- Ensure that table is empty first

			BULK INSERT bronze.erp_loc_az12
			FROM 'C:\Users\HELLO\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
			WITH (
			   FIRSTROW = 2,
			   FIELDTERMINATOR = ',',
			   TABLOCK
			);
			SET @end_time = GETDATE();
			PRINT 'Load Duration' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';


			SET @start_time = GETDATE();
			TRUNCATE TABLE bronze.erp_px_cat_g1v2; -- Ensure that table is empty first

			BULK INSERT bronze.erp_px_cat_g1v2
			FROM 'C:\Users\HELLO\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
			WITH (
			   FIRSTROW = 2,
			   FIELDTERMINATOR = ',',
			   TABLOCK
			);
			SET @end_time = GETDATE();
			SET @batch_end_time = GETDATE();
			PRINT 'Load Duration ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
			PRINT 'Batch Load Duration ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
	END TRY
	BEGIN CATCH
	       PRINT 'Error' + CAST (ERROR_STATE() AS NVARCHAR);
	END CATCH
	  
END
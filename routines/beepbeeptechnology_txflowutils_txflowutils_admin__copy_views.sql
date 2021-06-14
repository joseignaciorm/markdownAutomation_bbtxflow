BEGIN
--{"description": "Copies all views from specified datasets into a destination project.  Note that all views referenced in the SQL will be unchanged, and the procedure will fail if any views are invalid (i.e. reference non-existent views or tables). In this case the invalid view can be identified by the view identified in the final VIEW RESULTS in the results window."

DECLARE info_schema_query STRING;

--SELECT datasets_ref_array;

WITH 
in_scope_datasets AS (
SELECT dataset_ref
FROM UNNEST(datasets_ref_array) AS dataset_ref
),

dataset_info_schema_queries AS (
SELECT 
dataset_ref,
FORMAT("SELECT * FROM `"||dataset_ref||"`.INFORMATION_SCHEMA.VIEWS") AS info_schema_query
FROM in_scope_datasets
),

union_info_schema_queries AS (
SELECT ARRAY_TO_STRING(ARRAY_AGG(info_schema_query), "\nUNION ALL \n") AS query_string
FROM dataset_info_schema_queries)

SELECT query_string
FROM union_info_schema_queries;


--select view for debugging

END
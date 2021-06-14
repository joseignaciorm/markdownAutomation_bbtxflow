BEGIN
--{"description": "Copy a list of tables from one project to another project, with optional suffix for the new tables (set as empty string if not suffix is required"}

DECLARE loop_count INT64 DEFAULT 0;
DECLARE source_dataset_ref STRING;
DECLARE new_dataset_name STRING;
DECLARE new_table_name STRING;

WHILE loop_count < ARRAY_LENGTH(source_table_refs) DO
  
  SET source_dataset_ref = source_table_refs[OFFSET(loop_count)];
  SET new_dataset_name = SPLIT(source_dataset_ref, ".")[OFFSET(1)];
  SET new_table_name = SPLIT(source_dataset_ref, ".")[OFFSET(2)];
  SELECT source_dataset_ref, new_dataset_name, new_table_name;
  
  EXECUTE IMMEDIATE """
  CREATE OR REPLACE TABLE `"""||destination_project_id||"""`."""||new_dataset_name||"""."""||CONCAT(new_table_name,optional_suffix)||"""
  AS
  SELECT * FROM `"""||source_dataset_ref||"""`
  """;

SET loop_count = loop_count + 1;
END WHILE;


END
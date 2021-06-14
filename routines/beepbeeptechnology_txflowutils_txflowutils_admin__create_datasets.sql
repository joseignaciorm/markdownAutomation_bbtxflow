BEGIN
--{"description": "Creates new empty datasets from an array of dataset references (project_id.dataset_name)"}

DECLARE loop_count INT64 DEFAULT 0;

WHILE loop_count < ARRAY_LENGTH(datasets_ref_array) DO
  EXECUTE IMMEDIATE """
  CREATE SCHEMA IF NOT EXISTS `"""||datasets_ref_array[OFFSET(loop_count)]||"""`;
  """;
SET loop_count = loop_count + 1;
END WHILE;

END
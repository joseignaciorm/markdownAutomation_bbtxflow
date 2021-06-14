BEGIN
--{"description": "Creates multiple new views with supplied refs and SQl strings"}

DECLARE loop_counter INT64 DEFAULT 0;
DECLARE current_view_specification STRUCT<new_view_ref STRING, new_view_sql STRING>;

WHILE loop_counter < ARRAY_LENGTH(new_views_specifications) DO

  SET current_view_specification = new_views_specifications[OFFSET(loop_counter)];
  SELECT current_view_specification;
  
  EXECUTE IMMEDIATE ("""
  CREATE OR REPLACE VIEW `"""||current_view_specification.new_view_ref||"""`
  AS
  """||current_view_specification.new_view_sql||"""
  """);
  
SET loop_counter = loop_counter + 1; 
END WHILE;

END
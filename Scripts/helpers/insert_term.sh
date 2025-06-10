#!/bin/bash
# 
# 
# 
# 1) Connect to ptdb
# 2) Insert into table
 
DB_NAME="${1:-test}"

TABLE_SOURCE="OfferedCourses_stg"
TABLE_GOAL="semester"

echo "Connection to database '$DB_NAME'..."
db2 "CONNECT TO ${DB_NAME}"

echo "Inserting from staging table into term:"
db2 "INSERT INTO DB2INST1.${TABLE_GOAL} (TERM)
SELECT DISTINCT TERM
  FROM DB2INST1.${TABLE_SOURCE} AS S
 WHERE S.TERM IS NOT NULL
   AND NOT EXISTS (
     SELECT 1
       FROM DB2INST1.SEMESTER AS T
      WHERE T.TERM = S.TERM
   )
;
"



echo "Disconnecting..."
db2 "CONNECT RESET"

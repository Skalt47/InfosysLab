#!/bin/bash
# 
# 
# 
# 1) Connect to ptdb
# 2) Insert into table
 
DB_NAME="${1:-test}"

TABLE_SOURCE="OfferedCourses_stg"
TABLE_GOAL="lecturer"

echo "Connection to database '$DB_NAME'..."
db2 "CONNECT TO ${DB_NAME}"

echo "Inserting from staging table into lecturer:"
db2 "INSERT INTO DB2INST1.${TABLE_GOAL}
  (LECNO, LECNAME, LEC1STN, LECROOM,
   LECNOTES, ISPROF, LECDEPT, SUPERVISOR)
SELECT
  LECNO,
  LECNAME,
  LEC1STN,
  LECROOM,
  LECNOTES,
  ISPROF,
  LECDEPT,
  SUPERVISOR
FROM (
  SELECT
    LECNO,
    LECNAME,
    LEC1STN,
    LECROOM,
    LECNOTES,
    ISPROF,
    LECDEPT,
    SUPERVISOR,
    ROW_NUMBER() 
      OVER (
        PARTITION BY LECNO
        ORDER BY LECNAME
      ) AS RN
  FROM DB2INST1.${TABLE_SOURCE}
  WHERE LECNO IS NOT NULL
) AS FirstLec
WHERE RN = 1
  AND NOT EXISTS (
    SELECT 1
      FROM DB2INST1.LECTURER AS T
     WHERE T.LECNO = FirstLec.LECNO
  )
;
"


echo "Disconnecting..."
db2 "CONNECT RESET"

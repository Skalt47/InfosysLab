#!/bin/bash
# 
# 
# 
# 1) Connect to ptdb
# 2) Insert into table
 
DB_NAME="${1:-test}"

TABLE_SOURCE="OfferedCourses_stg"
TABLE_GOAL="subject"

echo "Connection to database '$DB_NAME'..."
db2 "CONNECT TO ${DB_NAME}"

echo "Inserting from staging table into subject:"
db2 "INSERT INTO DB2INST1.${TABLE_GOAL}
  (SBJNO, SBJLEVEL, STUDYPRG, SBJNAME,
   ELECTIVE, NUMCURR, NUMSCHD, SRVCLIENT, SBJNOTES)
SELECT
  SBJNO,
  SBJLEVEL,
  STUDYPRG,
  SBJNAME,
  ELECTIVE,
  NUMCURR,
  NUMSCHD,
  SRVCLIENT,
  SBJNOTES
FROM (
  SELECT
    SBJNO, SBJLEVEL, STUDYPRG, SBJNAME,
    ELECTIVE, NUMCURR, NUMSCHD, SRVCLIENT, SBJNOTES,
    ROW_NUMBER() OVER (
      PARTITION BY SBJNO
      ORDER BY SBJNAME
    ) AS RN
  FROM DB2INST1.${TABLE_SOURCE}
  WHERE SBJNO IS NOT NULL
) AS FirstRow
WHERE RN = 1
;
"


echo "Disconnecting..."
db2 "CONNECT RESET"

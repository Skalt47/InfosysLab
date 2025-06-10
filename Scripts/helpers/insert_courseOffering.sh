#!/bin/bash
# 
# 
# 
# 1) Connect to ptdb
# 2) Insert into table
 
DB_NAME="${1:-test}"

TABLE_SOURCE="OfferedCourses_stg"
TABLE_GOAL="courseOffering"

echo "Connection to database '$DB_NAME'..."
db2 "CONNECT TO ${DB_NAME}"

echo "Inserting from staging table into coureseOffering:"
db2 "INSERT INTO DB2INST1.${TABLE_GOAL}
  (SBJNO, LECNO, TERM, CNTLEC, CNTCURR, CNTSCHD, ASSNOTES)
SELECT DISTINCT
     S.SBJNO,
     S.LECNO,
     S.TERM,
     S.CNTLEC,
     S.CNTCURR,
     S.CNTSCHD,
     S.ASSNOTES
  FROM DB2INST1.${TABLE_SOURCE} AS S
 WHERE S.SBJNO IS NOT NULL
   AND S.LECNO  IS NOT NULL
   AND S.TERM   IS NOT NULL
   -- skip ones already loaded
   AND NOT EXISTS (
     SELECT 1
       FROM DB2INST1.COURSEOFFERING AS C
      WHERE C.SBJNO = S.SBJNO
        AND C.LECNO = S.LECNO
        AND C.TERM  = S.TERM
   )
;
"



echo "Disconnecting..."
db2 "CONNECT RESET"

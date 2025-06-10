#!/bin/bash
# 
# 
# 
# 1) Connect to ptdb
# 2) Insert into table
 
DB_NAME="${1:-test}"

TABLE_SOURCE="WorkLoadReduction_stg"
TABLE_GOAL="WorkLoadReduction"

echo "Connection to database '$DB_NAME'..."
db2 "CONNECT TO ${DB_NAME}"

echo "Inserting from staging table into WorkLoadReduction:"
db2 "INSERT INTO DB2INST1.WORKLOADREDUCTION (TERM, LECNO, JOBTITLE, REDUCTION)
SELECT
  TERM, LECNO, JOBTITLE, REDUCTION
FROM (
  SELECT
    S.TERM,
    L.LECNO,
    S.JOBTITLE,
    S.REDUCTION,
    ROW_NUMBER() OVER (
      PARTITION BY S.TERM, L.LECNO, S.JOBTITLE
      ORDER BY S.REDUCTION
    ) AS RN
  FROM DB2INST1.WORKLOADREDUCTION_STG AS S
  JOIN DB2INST1.LECTURER      AS L
    ON TRIM(S.NAME) = TRIM(L.LECNAME)
  WHERE S.TERM     IS NOT NULL
    AND S.NAME     IS NOT NULL
    AND S.JOBTITLE IS NOT NULL
) AS firstWork
WHERE firstWork.RN = 1
  AND NOT EXISTS (
      SELECT 1
        FROM DB2INST1.WORKLOADREDUCTION AS W
       WHERE W.TERM     = firstWork.TERM
         AND W.LECNO   = firstWork.LECNO
         AND W.JOBTITLE = firstWork.JOBTITLE
  )
;
"



echo "Disconnecting..."
db2 "CONNECT RESET"

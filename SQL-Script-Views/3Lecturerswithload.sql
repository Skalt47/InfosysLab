SELECT LECNO, TERM, COUNT(*) AS offerings
  FROM DB2INST1.COURSEOFFERING
 GROUP BY LECNO, TERM
HAVING COUNT(*) IN (2,3);
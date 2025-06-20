WITH
  -- 1) total teaching hours per lec/term
  teach AS (
    SELECT lecno
         , term
         , SUM(
    CASE 
      WHEN C.assNotes = 'gekoppelt mit WKB3' THEN 0 
      ELSE C.CNTLEC 
    END
  ) AS teach_hours
    FROM DB2INST1.CourseOffering C
    --WHERE lecno = 21
    GROUP BY lecno, term
  ),
  -- 2) total reduction hours per lec/term
  red AS (
    SELECT lecno
         , term
         , SUM(reduction) AS reduction_hours
    FROM DB2INST1.WorkloadReduction
    --WHERE lecno = 21
    GROUP BY lecno, term
  )
SELECT
  t.lecno
, t.term
, t.teach_hours
, COALESCE(r.reduction_hours,0)    AS reduction_hours
, t.teach_hours
  + COALESCE(r.reduction_hours,0)  AS total_workload
FROM teach t
LEFT JOIN red   r
  ON t.lecno = r.lecno
 AND t.term  = r.term
ORDER BY t.lecno, t.term
;



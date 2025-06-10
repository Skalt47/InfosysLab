USE planningtooldb;

INSERT INTO work_load_reduction (lec_no, term, job_title, reduction)
SELECT
  l.lec_no,
  s.term,
  st.job_title,
  st.reduction
FROM reduction_stg AS st
  JOIN lecturer   AS l ON l.lec_name = st.name
  JOIN semester   AS s ON s.term     = st.term
;

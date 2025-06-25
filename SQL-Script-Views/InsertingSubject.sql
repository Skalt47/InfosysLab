INSERT INTO DB2INST1.SUBJECT (
  SBJNO,
  SBJLEVEL,
  STUDYPRG,
  SBJNAME,
  ELECTIVE,
  NUMCURR,
  NUMSCHD,
  SRVCLIENT,
  SBJNOTES
)
VALUES (
  9999,                    -- Fachnummer
  1,                       -- Fachlevel
  'IT',                    -- Studiengang
  'Testfach View',         -- Fachname
  'N',                     -- Wahlpflichtkennzeichen
  0,                       -- NUMCURR
  0,                       -- NUMSCHD
  'IT',                    -- SRVCLIENT
  'Eintrag zum Test der View'  -- Bemerkung
);
COMMIT;


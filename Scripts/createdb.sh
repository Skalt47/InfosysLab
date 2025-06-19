#!/bin/bash
#
# setup_db.sh
# ───────────
# Creates and connects to the db, creates tables (OfferedCourses, WorkLoadReduction),
# then disconnects.
#
# Usage: ./setup_db.sh <DB_NAME>
#       <DB_NAME> default value: ptdb

set -euo pipefail

DB_NAME="${1:-test}"

TABLE_DEFAULT1="OfferedCourses_stg"
TABLE_DEFAULT2="WorkLoadReduction_stg"

if [[ "$(db2 "list database directory" | grep -io "$DB_NAME")" = "" ]]; then
    echo "Creating database '$DB_NAME'..."
    db2 "create db $DB_NAME"
else
    echo "Database '$DB_NAME' already exists!"
    ##### Force recreate...
    echo "Dropping old database..."
    db2 "drop database $DB_NAME"
    echo "Recreating database..."
    db2 "create db $DB_NAME"
    #####
fi

echo "Connecting to database '$DB_NAME'..."
db2 "CONNECT TO ${DB_NAME}"

if [[ ! "$(db2 "list tables" | grep -io "${TABLE_DEFAULT1}")" = "" ]]; then
    echo "Dropping old version of table '${TABLE_DEFAULT1}'..."
    db2 "drop table ${TABLE_DEFAULT1}"
fi

if [[ ! "$(db2 "list tables" | grep -io "${TABLE_DEFAULT2}")" = "" ]]; then
    echo "Dropping old version of table '${TABLE_DEFAULT2}'..."
    db2 "drop table ${TABLE_DEFAULT2}"
fi

echo "Starting transaction to create tables..."
db2 -t <<- 'EOF'
  -- Turn off statement terminator detection in interactive mode with -t 
  -- (';' to end statements)
  
  CREATE TABLE OfferedCourses_stg (
    sbjNo       VARCHAR(100),
    sbjlevel    INTEGER,
    studyPrg    VARCHAR(4),
    sbjName     VARCHAR(100),
    elective    CHAR(1),
    numCurr     INTEGER,
    numSchd     INTEGER,
    srvProvider VARCHAR(3),
    srvClient   VARCHAR(4),
    sbjNotes    VARCHAR(100),
    lecNo       INTEGER,
    lecName     VARCHAR(100),
    lec1stn     VARCHAR(100),
    lecRoom     VARCHAR(7),
    lecNotes    VARCHAR(100),
    isprof      VARCHAR(100),
    lecDept     VARCHAR(3),
    supervisor  VARCHAR(100),
    term        VARCHAR(7),
    cntLec      DECIMAL(3,2),
    cntCurr     INTEGER,
    cntSchd     INTEGER,
    assNotes    VARCHAR(100)
  );
  
  CREATE TABLE WorkLoadReduction_stg (
    term        VARCHAR(7),
    name        VARCHAR(100),
    jobtitle    VARCHAR(100),
    reduction   integer
  );
  
  -- COMMIT the DDL
  COMMIT;
EOF

echo "Disconnecting..."
db2 "CONNECT RESET"


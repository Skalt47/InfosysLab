#!/bin/bash
# 
# NOTE: Please create the database first with the script createdb.sh and then update the database with the physical model from DbSchema
echo "NOTE: Please create the database first with the script createdb.sh and then update the database with the physical model from DbSchema"
#
# insert.sh
# 1) Connect to ptdb
# 2) Load CSVs into staging tables
 
DB_NAME="${1:-test}"

TABLE_DEFAULT1="OfferedCourses_stg"
TABLE_DEFAULT2="WorkLoadReduction_stg"

echo "Connection to database '$DB_NAME'..."
db2 "CONNECT TO ${DB_NAME}"

echo "1) Import OfferedCourses.csv -> staging table"
db2 "IMPORT FROM OfferedCourses.csv OF DEL INSERT INTO ${TABLE_DEFAULT1}"

echo "2) Import WorkLoadReduction.csv -> staging table"
db2 "IMPORT FROM WorkLoadReduction.csv OF DEL INSERT INTO ${TABLE_DEFAULT2}"

#echo "3)Selecting first 3 rows of the 2 staging tables, to make sure everythings worked fine"
#db2 "SELECT * FROM ${TABLE_DEFAULT1} FETCH FIRST 3 ROWS ONLY"
#db2 "SELECT * FROM ${TABLE_DEFAULT2} FETCH FIRST 3 ROWS ONLY"

echo "Disconnecting..."
db2 "CONNECT RESET"

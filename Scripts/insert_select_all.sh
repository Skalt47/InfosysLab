#!/bin/bash
# 
# Entry point
#
# NOTE: Please insert the data first into the database with the insert_stg.sh file
echo "NOTE: Please insert the data first into the database with the insert_stg.sh file"
#
# insert.sh
# 1) Connect to ptdb
# 2) Insert into tables

DB_NAME="${1:-test}"

echo "0.Inserting data into the staging tables"
./insert_stg.sh ${DB_NAME}

echo "1.Inserting data into table subject"
./helpers/insert_subject.sh ${DB_NAME}

echo "2.Inserting data into table lecturer"
./helpers/insert_lecturer.sh ${DB_NAME}


echo "3.Inserting data into table term"
./helpers/insert_term.sh ${DB_NAME}


echo "4.Inserting data into table courseOffering"
./helpers/insert_courseOffering.sh ${DB_NAME}


echo "5.Inserting data into table workLoadReduction"
./helpers/insert_workLoadReduction.sh ${DB_NAME}


echo "Script end..."


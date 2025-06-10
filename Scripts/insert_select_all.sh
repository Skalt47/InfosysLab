#!/bin/bash
# 
# NOTE: Please insert the data first into the database with the insert_stg.sh file
echo "NOTE: Please insert the data first into the database with the insert_stg.sh file"
#
# insert.sh
# 1) Connect to ptdb
# 2) Insert into tables
 

echo "1.Inserting data into table subject"
./helpers/insert_subject.sh

echo "2.Inserting data into table lecturer"
./helpers/insert_lecturer.sh


echo "3.Inserting data into table term"
./helpers/insert_term.sh


echo "4.Inserting data into table courseOffering"
./helpers/insert_courseOffering.sh


echo "5.Inserting data into table workLoadReduction"
./helpers/insert_workLoadReduction.sh



echo "Script end..."


# InfosysLab

Documentation and installation guide of the information system PTDB.

## Installation guide

How to setup up the database on your vm.

### Requirements

1. Have db2 installed
2. Have DbSchema installed
3. (Optional) Have git installed

### Installation steps

1. Download the repository from GitHub (https://github.com/Skalt47/InfosysLab)
    1. *Clone it via git*
        1. Open the terminal and choose your location
        2. Clone the repository via `'git clone https://github.com/Skalt47/InfosysLab.git'`
    2. *Manual installation*
        1. Go to the GitHub repository in your browser and click on `<> code` then download it as a zip-file
        2. Extract the downloaded zip to your destination on your computer
2. Execute the `createdb.sh` inside the `./Scripts` folder (default name is test) *1
    - Creates a new database where DbSchema can connect to
    - Creates staging tables which are necessary to load the data in
3. Open the physical model `PTDB Physical Design §{version_number}` inside DbSchema
4. In the upper toolbar click on the 'plug'-symbole (`<<your connection>>` or`offline`) and connect to the created database
    1. *Edit active connection*
        - If you already have a connection go on `Edit Active Connection`:
            1. Make sure to use the `jcc.DB2Driver`
            2. Below select `DB2` for the JDBC URL (not manual - so that we can check the connection)
            3. For `Server Location` choose `This computer, default port`
            4. Under `Authentication` type in your credentials for your machine
            5. For `Database` use the name the database was created with (default name is test)
            6. Now check the connection (`Check (Ping)`) *2
            7. Press `Connect` to continue
    2. *Add new connection*
        - If you do not have a connection go on `Add Connection`:
            1. Edit the name of your connection if you want
            2. Make sure the `jcc.DB2Driver` is selected
            3. Below select `DB2` for the JDBC URL (not manual - so that we can check the connection)
            4. For `Server Location` choose `This computer, default port`
            5. Under `Authentication` type in your credentials for your machine
            6. For `Database` use the name the database was created with (default name is test)
            7. Now check the connection (`Check (Ping)`) *2
            8. Press `Connect` to continue
5. Click on the arrow next to `Refresh Model` and choose the option `Create or Upgrade Model in the Database`
6. Check everthing to migrate, click `Ok` and `Execute All`
7. Execute the `insert_select_all.sh` inside the `./Scripts` folder (default name is test)
    - Functions as an 'Entry Point' and inserts the raw data into the staging tables then activtes the scripts to insert data into the model

Now you can connect to the database (default name is test) and for example check the views.

### Troubleshouting

Unexpected problems can occur during the setup. Most, known to us, are listed here with solutions.

##

***1** *Dropping of the old database failed*

If this message (
*SQL1035N  The operation failed because the specified database cannot be connected to in the mode requested.  SQLSTATE=57019*
) shows up after trying to drop the database there are ongoing connections to the database.

To solve this problem disconnect all clients from the database and try again.</br>
If you do not know the clients who are connected try to restart the whole service and force a disconnect on all connected clients.

##

***2** *Connection on default port failed*

If the connection fails on the default port the service is either not running or listening on a different port.

Check if the service is stopped and may start it again.</br>
If the service was running then db2 is not listening on port 5000 (default port). 
You either change it manualy in the configuration file or try to connect to the used port.

*Find out the service name and the corresponding TCP/IP port*:</br>
1. Use the terminal and typ in `'db2 get dbm cfg'`
2. Look for `(SVCENAME)`. You should find a name similar to `db2c_${instance_name}`
3. Now search for your service name in the `services` file and find out the port
    - *On Linux*: `/etc/services`
    - *On Windows*: `C:\winnt\system32\drivers\etc\services`

*Fix the port connection*:</br>
Change the port in the file to the default port 50000 also used by DbSchema.</br>
Then restart the service.

**OR**

When you already have other clients or applications using this port then change the port in DbSchema.
Therefore edit your connection and select `Remote computer or custom port` instead of `This computer, default port`.
Still use `localhost` as the server host but change the port to the one in the file.</br>
Then try to connect again.

---

## Documentation

Documentation of the process and the overall concept of the information system.

### Difficulties during the development

- DbSchema does not save SQL scripts inside the Logical Design
- Auto increments get lost while generating a Pyhsical Design
- `Order By` SQL-Statements are not allowed while creating a view
- DbSchema does not handle comments on views correctly
    - Db2 does not allow comments on a view. They need to get treaded like a table to comment on. 
    DbSchema generates SQL-Commands with `Comment On View` instead of `Comment On Table` which must be change during the execution.

### Updating the model

When updating the model the Physical and therefore the Logical Design need to be changed.

If major changes will be made to the Logical and Physical Design store the current Designs in the `./Old Database Designs` folder and create new ones with an updated version number.

When generating the Physical Design out of the Logical Design make sure to set the auto increments again because those get lost while generating.
Setting auto increment in the Physical Design (`OFFERINGID`, `REDUCTIONID`):
1. Hover and double click on the attribute which should have an auto increment
2. One the bottom right click on the arrow to open up an `Options Dialog` (the corresponding textbox should contain something like `QAUTO_INCREMENTE`)
3. Check `GENERATE`, `ALWAYS`, `AS IDENTITY` and `STARTS WITH`
4. As `startValue` and `incrementValue` use 1
5. Then save all

### History

Here is the history of the different logical and physical models created with DbSchema listed.

##

**v_1** (logical only) *dropped*

Consists of the first data model which was only inspired by some screenshots. 
Therefore it was quickly out-of-date when the actual data was delivered.

Had also user views grouping tables to fit a personalized need.

##

**v_2** (logical only)

A better worked out data model based on the first version.

##

**v_3** (first model based on actual data)

First screach of a data model with the delivered unnormalized data.

##

**v_4** (first functional one)

Working data model with Lecturer, WorkloadReduction, Term, OfferedCourse and Subject.

Everything based on the unnormalized data provided. Each attribute accept of some auto increment ids is from the tables which hold the unnormalized data.

##

**v_5** (with views) 

Based on the fourth version there are also views implemented which show some functionality of this information system.

##

**v_5** (corrected views) *latest*

The views and the entities were sligthly corrected, after some mistakes were found in the meeting with the professor. Got rid of offeringid and switched to a composite key of sbjno, lecno and term. Corrected the view workloadbalance, calculation (sum) was faulty and if a lecture of 2 studyprg is combined, now so is the cntlec (only calculated once and not twice).

</br>

*Fill out the history path*...

---

Write more if needed...

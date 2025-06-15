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
    1. Clone it via git:
        - Open the terminal and choose your location
        - Clone the repository via `'git clone https://github.com/Skalt47/InfosysLab.git'`
    2. Manual installation:
        - Go to the GitHub repository in your browser and click on `<> code` then download it as a zip-file
        - Extract the downloaded zip to your destination on your computer
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

auto increment...

refreshing model...



### Troubleshouting

***1** Dropping of old database failed

If this message (
*SQL1035N  The operation failed because the specified database cannot be connected to in the mode requested.  SQLSTATE=57019*
) shows up after trying to drop the database there are ongoing connections to the database.

To solve this problem disconnect all clients from the database and try again.</br>
If you do not know the clients who are connected try to restart the whole service and force a disconnect on all connected clients.

***2** Connection on default port failed

If the connection fails on the default port the service is either not running or listening on a different port.

...



---

## Documentation

Documentation of the process and the overall concept of the information system.

### History

Here is the history of the different logical and physical models created with DbSchema listed.

##

**v_1** (logical only) *dropped*

Consists of the first data model which was only inspired by some screenshots. Therefore it was quickly out-of-date when the actual data was delivered.

##

**v_2**

Fill out the history path...

v_5 has the views implemented

---

Write more if needed...

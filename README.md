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
    - Clone it via git:
        - Open the terminal and choose your location
        - Clone the repository via `git clone https://github.com/Skalt47/InfosysLab.git`
    - Manual installation:
        - Go to the GitHub repository in your browser and click on `<> code` then download it as a zip-file
        - Extract the downloaded zip to your destination on your computer
2. Execute the `createdb.sh` inside the `./Scripts` folder (default name is test)
    - Creates a new database where DbSchema can connect to
    - Creates staging tables which are necessary to load the data in
3. Open the physical model `PTDB Physical Design §{version_number}` inside DbSchema
4. In the upper toolbar click on the 'plug'-symbole (`no connection` or `offline`) and connect to the created database
    4.1 Edit active connection ...
    4.2 Add new connection ...


**TEST**

- **1.** something
    - **1.1** test
- **2.** another one

---

## Documentation

Documentation of the process and the overall concept of the information system.

### History

Here is the history of the different logical and physical models created with DbSchema listed.

**v_1** (logical only) *also dropped*

Consists of the first data model which was only inspired by some screenshots. Therefore it was quickly out-of-date when the actual data was delivered.

**v_2**

Fill out the history path...

v_5 has the views implemented

---

Write more if needed...

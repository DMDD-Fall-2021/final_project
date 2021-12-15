# Patient Record Management System
## DMDD Term Project on Patient Record System
## Team Members:
- Darshan Dedhia - 001054816
- Jai Devmane - 001059127
- Ruchit Gandhi - 001067481
- Shubham Jain - 001083883

## Project Description:
The project is used to develop a patient record management system for a hospital. The database used in this system is a Oracle based database.

The project records various patient and medical details including but not limited to family history, symptoms, vaccination, diseases, medication, location and the roles that these play in the patient's health.

These records can be used to derive various statistical reports about the patient's health and help the doctor make informed medical decisions.

Running all the scripts will bootstrap the database, create the tables, insert data, and run the queries for getting the reports.

The scripts have two steps:

1. Create & Execute SQL scripts - DDL : The first step is to create and execute the DDL scripts. Thses DDL scripts are integrated in the SQL file and will create the tables required for the project. After the tables have been created, the next step is to add data into the table. Here we insert data using insert statements using DML. The insert statements are integrated in the SQL file. The integrated scripts are called `create_insert_ddl_dml.sql`.

2. Executing Reports - SQL : The third step is to execute the reports. The SQL scripts are called `execute_reports.sql`.
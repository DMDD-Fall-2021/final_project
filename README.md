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

Please run the following files in given order:

1. EXPORT_TABLES.sql - DDL and DML : Drop and Create new Tables and Sequence using the DDL scripts, then add new data into newly created tables using DML scripts in a `create_insert_ddl_dml.sql` manner.

2. ExportFunctions.sql: Drop and Create new functions. On running this, functions will be compiled and will be available for validation and fetching data to be used in Stored Procedures.

3. ExportProcedures.sql: Drop and Create new Stored Procedures. On running this, procedures will be compiled and will be available for users to perform INSERT, UPDATE, DELETE and SELECT operations based on their authorization and requirement.

4. Export_packages.sql: Drop and Create new Packages. On running this, packages will be compiled and will be available for users to perform INSERT, UPDATE, DELETE and SELECT operations based on their authorization and requirement.

5. ExportViews.sql: Drop and Create new Views(Reports). These are views similar to table which gets value from different tables and is readily available for a user to get the data from and perform any further actions on that data.

6. TEST_CASE_POSITIVE.sql : Final step to verify the accuracy of program is to execute the TEST_CASE_POSITIVE.sql. It performs the whole lifecycle of a user creation, performing queries for achieving all business functionalities.

7. TEST_CASE_APP_ADMIN.sql : To identify all the negative test cases performed on INSERT/UPDATE performed by an Admin and test validations, we can run TEST_CASE_APP_ADMIN.sql.

8. TEST_CASE_DOCTOR.sql : To identify all the negative test cases performed on INSERT/UPDATE/DELETE/SELECT performed by a Doctor and test validations, we can run TEST_CASE_DOCTOR.sql.



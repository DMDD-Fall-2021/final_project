set SERVEROUTPUT on;
 -- ADD 2 users to user details as patients
DECLARE

status varchar2(2000);

BEGIN

pk_app_admin.pr_insert_update_user_details('A_280',null, 'Rohit', 'Patwa' , 'Male',sysdate-400, 70, 174, 316, 1, 1 ,'A_280', status);
DBMS_output.put_line(status);
pk_app_admin.pr_insert_update_user_details('A_280',null, 'Asthana', 'shah' , 'Male',sysdate-2000, 70, 174, 316, 1, 1 ,'A_280', status);
DBMS_output.put_line(status);
pk_app_admin.pr_insert_update_user_details('A_280',null, 'Jon', 'Mac' , 'Male',sysdate-7000, 70, 174, 316, 1, 1 ,'A_280', status);
DBMS_output.put_line(status);
END;
/
select * from app_users_audit;
-- MAKE a user doctor, and a Pharmacist
DECLARE

status varchar2(2000);

BEGIN


pk_app_admin.pr_insert_update_app_user('A_280',524, 2 ,'D_524','D_524','A_280', status);
DBMS_output.put_line(status);

pk_app_admin.pr_insert_update_app_user('A_280',525, 3 ,'M_524','M_524','A_280', status);
DBMS_output.put_line(status);

END;
/
-- PATIENT adds habits
DECLARE

status varchar2(2000);

BEGIN

pk_patient.pr_insert_habit_patient('P_523','P_523', 2, 3, ' This is a new habit', status);
DBMS_output.put_line(status);

pk_patient.pr_insert_habit_patient('P_523','P_523', 5, 2, ' This is a old habit', status);
DBMS_output.put_line(status);

END;
/

select * from habits_patient order by hp_id desc;

-- PATIENT adds Allergies
DECLARE

status varchar2(2000);

BEGIN

pk_patient.pr_insert_alergies_patient('P_523','P_523', 2, ' This is a new allergy', status);
DBMS_output.put_line(status);

pk_patient.pr_insert_alergies_patient('P_523','P_523', 5, ' This is old allergy', status);
DBMS_output.put_line(status);

END;
/

select * from allergies_patient order by ap_id desc;
-- Patient adds symptoms 

DECLARE

status varchar2(2000);

BEGIN

pk_patient.pr_insert_symptom_patient('P_523','P_523', 2, ' This is a new symptom', status);
DBMS_output.put_line(status);

pk_patient.pr_insert_symptom_patient('P_523','P_523', 5, ' This is a old symtom', status);
DBMS_output.put_line(status);

END;
/

select * from symptom_patient order by sp_id desc;

-- PATIENT adds a relative

DECLARE

status varchar2(2000);

BEGIN

pk_patient.pr_insert_family('P_523','P_523', 1, status);
DBMS_output.put_line(status);

pk_patient.pr_insert_family('P_523','P_523', 2, status);
DBMS_output.put_line(status);

END;
/

select * from family where relative_id in (1,2);

-- DOCTOR gives a vaccine

DECLARE

status varchar2(2000);
message varchar2(2000);

BEGIN

pk_doctor.pr_add_vaccine_record(1, 523, 524, 'D_524', status, message);
DBMS_output.put_line(message);

pk_doctor.pr_add_vaccine_record(4, 523, 524, 'D_524', status, message);
DBMS_output.put_line(message);

END;
/

select * from vaccine_patient order by date_taken desc;

DECLARE

status varchar2(2000);
message varchar2(2000);

BEGIN

pk_doctor.pr_add_update_disease_patient( null, 524, 3, 523, 'D_524', status, message);
DBMS_output.put_line(message);

END;
/

select * from disease_patient order by dp_id desc;

-- ADDING VISIT HISTORY
DECLARE

status varchar2(2000);
message varchar2(2000);

BEGIN

pk_doctor.pr_add_update_visit_history( null, 2222, 524, 'This is a visitor notes' , 'D_524', status, message);
DBMS_output.put_line(message);

END;
/

select * from visit_history order by visit_id desc;

-- ADDING prescription for a visit history
DECLARE

status varchar2(2000);
message varchar2(2000);

BEGIN

pk_doctor.pr_add_update_prescription( null, 8, 524, 523, 2, '30 MG', 4, sysdate + 2, 'This is prescription random notes', 'D_524', status, message);
DBMS_output.put_line(message);

END;
/

select * from prescription order by p_id desc;

-- PATIENT VIEW
DECLARE
status varchar2(2000);
BEGIN 

pr_patient_report(523, status);

END;
/

--- DOCTOR VIEW

DECLARE

status varchar2(2000);
message varchar2(2000);

BEGIN

pk_doctor.view_patient_details(524, 523, 'D_524', status, message);
DBMS_output.put_line(message);

END;
/


-----------------------------------------------------------------------------------------------------
--- ALLERGY
-----------------------------------------------------------------------------------------------------
SET SERVEROUTPUT ON;

DECLARE
    status VARCHAR2(400);
BEGIN

--- PART A
--- TEST UPDATE ALLERGY
    pk_app_admin.pr_insert_update_allergy('A_280', 7, 'Cotton Allergy', 'A_280', status);
    dbms_output.put_line('TEST UPDATE - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_allergy('A_280', 47, 'Metal Allergy', 'A_280', status);
    dbms_output.put_line('TEST INSERT - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_allergy('A_280', 4, 'Some 123 Allergy', 'A_280', status);
    dbms_output.put_line('TEST NUMBER - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_allergy('A_280', NULL, 'New Allergy', 'A_280', status);
    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_allergy('A_280', 7, 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',
    'A_280', status);
    dbms_output.put_line('TEST TOO LONG - OUTPUT: ' || status);
END;
/

-----------------------------------------------------------------------------------------------------
--- APP_ROLE
-----------------------------------------------------------------------------------------------------

DECLARE
    status VARCHAR2(400);
BEGIN

--- PART B
--- TEST UPDATE APP_ROLE
    pk_app_admin.pr_insert_update_app_role('A_280', 3, 'Chemist', sysdate, 'A_280',
                                          status);
    dbms_output.put_line('TEST UPDATE - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_app_role('A_280', 9, 'Pharmacy', sysdate, 'A_280',
                                          status);
    dbms_output.put_line('TEST INSERT - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_app_role('A_280', 3, 'Some 123', sysdate, 'A_280',
                                          status);
    dbms_output.put_line('TEST NUMBER - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_app_role('A_280', NULL, 'New Role', sysdate, 'A_280',
                                          status);
    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_app_role('A_280', 3, 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',
    sysdate, 'A_280',
                                          status);
    dbms_output.put_line('TEST TOO LONG - OUTPUT: ' || status);    
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_app_role('A_280', 3, 'Pharmacist', sysdate + 5, 'A_280',
                                          status);

    dbms_output.put_line('TEST FUTURE DATE - OUTPUT: ' || status);
END;
/

-----------------------------------------------------------------------------------------------------
--- COUNTRY
-----------------------------------------------------------------------------------------------------

DECLARE
    status VARCHAR2(400);
BEGIN

--- PART C
--- TEST UPDATE COUNTRY
    pk_app_admin.pr_insert_update_country('A_280', 1, 'IN', 'A_280', status);
    dbms_output.put_line('TEST UPDATE - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_country('A_280', 2, 'UK', 'A_280', status);
    dbms_output.put_line('TEST INSERT - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_country('A_280', 1, 'Some 123', 'A_280', status);
    dbms_output.put_line('TEST NUMBER - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_country('A_280', NULL, 'New Country', 'A_280', status);
    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_country('A_280', 1, 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',
    'A_280', status);
    dbms_output.put_line('TEST TOO LONG - OUTPUT: ' || status);
END;
/

-----------------------------------------------------------------------------------------------------
--- DIET
-----------------------------------------------------------------------------------------------------


DECLARE
    status VARCHAR2(400);
BEGIN

--- PART D
--- TEST UPDATE DIET
    pk_app_admin.pr_insert_update_diet('A_280', 9, 'Ovo-Waterarian', 'A_280', status);
    dbms_output.put_line('TEST UPDATE - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_diet('A_280', 17, 'Non Eatarian', 'A_280', status);
    dbms_output.put_line('TEST INSERT - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_diet('A_280', 9, 'Some 123', 'A_280', status);
    dbms_output.put_line('TEST NUMBER - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_diet('A_280', NULL, 'New Diet', 'A_280', status);
    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_diet('A_280', 9, 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',
    'A_280', status);
    dbms_output.put_line('TEST TOO LONG - OUTPUT: ' || status);
END;
/

-----------------------------------------------------------------------------------------------------
--- DISEASES
-----------------------------------------------------------------------------------------------------


DECLARE
    status VARCHAR2(400);
BEGIN

--- PART E
--- TEST UPDATE DISEASES
    pk_app_admin.pr_insert_update_disease('A_280', 20, 'Diarrhea', 'FALSE', 'FALSE',
                                         'FALSE', 'A_280', status);

    dbms_output.put_line('TEST UPDATE - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_disease('A_280', 73, 'Leukemia', 'TRUE', 'TRUE',
                                         'TRUE', 'A_280', status);

    dbms_output.put_line('TEST INSERT - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_disease('A_280', NULL, 'New Disease', 'TRUE', 'FALSE',
                                         'FALSE', 'A_280', status);

    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_medicine('A_280', 20, 'Some 123$', 'A_280', status);
    dbms_output.put_line('TEST NUMBER - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_disease('A_280', 20, 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',
    'FALSE', 'TRUE',
                                         'FALSE', 'A_280', status);

    dbms_output.put_line('TEST TOO LONG - OUTPUT: ' || status);    
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_disease('A_280', 20, 'Hemophilia', 'TRUE', 'TRUE',
                                         'NOTHING', 'A_280', status);

    dbms_output.put_line('TEST TERMINAL WRONG- OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_disease('A_280', 20, 'Hemophilia', 'TRUE', 'NOTHING',
                                         'TRUE', 'A_280', status);

    dbms_output.put_line('TEST HEREDITARY WRONG- OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_disease('A_280', 20, 'Hemophilia', '', 'TRUE',
                                         'TRUE', 'A_280', status);

    dbms_output.put_line('TEST CHRONIC WRONG- OUTPUT: ' || status);
END;
/

-----------------------------------------------------------------------------------------------------
--- ETHNICITY
-----------------------------------------------------------------------------------------------------

DECLARE
    status VARCHAR2(400);
BEGIN

--- PART F
--- TEST UPDATE ETHNICITY
    pk_app_admin.pr_insert_update_ethnicity('A_280', 5, 'Arab', 'A_280', status);
    dbms_output.put_line('TEST UPDATE - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_ethnicity('A_280', 9, 'Nordic', 'A_280', status);
    dbms_output.put_line('TEST INSERT - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_ethnicity('A_280', 5, 'Some 123', 'A_280', status);
    dbms_output.put_line('TEST NUMBER - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_ethnicity('A_280', NULL, 'New Ethnicity', 'A_280', status);
    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_ethnicity('A_280', 5, 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',
    'A_280', status);
    dbms_output.put_line('TEST TOO LONG - OUTPUT: ' || status);
END;
/

-----------------------------------------------------------------------------------------------------
--- HABIT
-----------------------------------------------------------------------------------------------------

DECLARE
    status VARCHAR2(400);
BEGIN

--- PART G
--- TEST UPDATE HABIT
    pk_app_admin.pr_insert_update_habit('A_280', 3, 'Over Sleeping', 'A_280', status);
    dbms_output.put_line('TEST UPDATE - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_habit('A_280', 17, 'Not Eating', 'A_280', status);
    dbms_output.put_line('TEST INSERT - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_habit('A_280', 3, 'Some 123', 'A_280', status);
    dbms_output.put_line('TEST NUMBER - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_habit('A_280', NULL, 'New Habit', 'A_280', status);
    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_habit('A_280', 3, 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',
    'A_280', status);
    dbms_output.put_line('TEST TOO LONG - OUTPUT: ' || status);
END;
/

-----------------------------------------------------------------------------------------------------
--- MEDICINE
-----------------------------------------------------------------------------------------------------


DECLARE
    status VARCHAR2(400);
BEGIN

--- PART H
--- TEST UPDATE MEDICINE
    pk_app_admin.pr_insert_update_medicine('A_280', 10, 'Disprin', 'A_280', status);
    dbms_output.put_line('TEST UPDATE - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_medicine('A_280', 46, 'Combiflam', 'A_280', status);
    dbms_output.put_line('TEST INSERT - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_medicine('A_280', 10, 'Some 123$', 'A_280', status);
    dbms_output.put_line('TEST NUMBER - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_medicine('A_280', NULL, 'New Medicine', 'A_280', status);
    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_medicine('A_280', 10, 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',
    'A_280', status);
    dbms_output.put_line('TEST TOO LONG - OUTPUT: ' || status);
END;
/

-----------------------------------------------------------------------------------------------------
--- SYMPTOMS
-----------------------------------------------------------------------------------------------------


DECLARE
    status VARCHAR2(400);
BEGIN

--- PART I
--- TEST UPDATE SYMPTOMS
    pk_app_admin.pr_insert_update_symptoms('A_280', 35, 'Loose Motion', 'A_280', status);
    dbms_output.put_line('TEST UPDATE - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_symptoms('A_280', 93, 'Blackout', 'A_280', status);
    dbms_output.put_line('TEST INSERT - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_symptoms('A_280', 35, 'Some 123', 'A_280', status);
    dbms_output.put_line('TEST NUMBER - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_symptoms('A_280', NULL, 'New Symptom', 'A_280', status);
    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_symptoms('A_280', 35, 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',
    'A_280', status);
    dbms_output.put_line('TEST TOO LONG - OUTPUT: ' || status);
END;
/

-----------------------------------------------------------------------------------------------------
--- VACCINE
-----------------------------------------------------------------------------------------------------


DECLARE
    status VARCHAR2(400);
BEGIN

--- PART J
--- TEST UPDATE VACCINE
    pk_app_admin.pr_insert_update_vaccine('A_280', 1, 'PCS13', 15, 'A_280',
                                         status);
    dbms_output.put_line('TEST UPDATE - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_vaccine('A_280', 9, 'PSLV4', 13, 'A_280',
                                         status);
    dbms_output.put_line('TEST INSERT - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_vaccine('A_280', 1, 'Some 12^3', 13, 'A_280',
                                         status);
    dbms_output.put_line('TEST INVALID NAME - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_vaccine('A_280', NULL, 'New Vaccine', 13, 'A_280',
                                         status);
    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_vaccine('A_280', 1, 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',
    13, 'A_280',
                                         status);
    dbms_output.put_line('TEST TOO LONG - OUTPUT: ' || status);    

--- TEST UPDATE
    pk_app_admin.pr_insert_update_vaccine('A_280', 1, 'PSLV4', 33, 'A_280',
                                         status);
    dbms_output.put_line('TEST DISEASE NOT EXIST - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_vaccine('A_280', 1, 'PSLV4', NULL, 'A_280',
                                         status);
    dbms_output.put_line('TEST DISEASE NULL - OUTPUT: ' || status);
END;
/

-----------------------------------------------------------------------------------------------------
--- LOCATION_STATISTICS
-----------------------------------------------------------------------------------------------------

DECLARE
    status VARCHAR2(400);
BEGIN

--- PART K
--- TEST UPDATE LOCATION_STATISTICS
    pk_app_admin.pr_insert_update_location_stat('A_280', 1, 1, 140, 140,
                                               140, 140, 70, 'A_280', status);

    dbms_output.put_line('TEST UPDATE - OUTPUT: ' || status);
    
--- TEST INSERT WITH DEFAULT
    pk_app_admin.pr_insert_update_location_stat('A_280', 32000, 31000, '', '',
                                               '', '', '', 'A_280', status);

    dbms_output.put_line('TEST INSERT - OUTPUT: ' || status);
    
--- TEST INSERT
    pk_app_admin.pr_insert_update_location_stat('A_280', 34000, 34000, 100, 100,
                                               100, 100, 100, 'A_280', status);

    dbms_output.put_line('TEST INSERT - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_location_stat('A_280', NULL, 32000, 100, 100,
                                               100, 100, 100, 'A_280', status);

    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_location_stat('A_280', 33000, NULL, '', '',
                                               '', '', '', 'A_280', status);

    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
END;
/

-----------------------------------------------------------------------------------------------------
--- ZIPCODE
-----------------------------------------------------------------------------------------------------

DECLARE
    status VARCHAR2(400);
BEGIN

--- PART L
--- TEST UPDATE ZIPCODE
    pk_app_admin.pr_insert_update_zip_code('A_280', 1, 1, 'Middlesex', 'Boston',
                                          'Massachussetts', 1, 'A_280', status);

    dbms_output.put_line('TEST UPDATE - OUTPUT: ' || status);
    
--- TEST INSERT WITH DEFAULT
    pk_app_admin.pr_insert_update_zip_code('A_280', 32001, 32001, 'Middlesex', 'Boston',
                                          'Massachussetts', 1, 'A_280', status);

    dbms_output.put_line('TEST INSERT - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_zip_code('A_280', NULL, 32000, 'Middlesex', 'Boston',
                                          'Massachussetts', 1, 'A_280', status);

    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_zip_code('A_280', 33000, NULL, 'Middlesex', 'Boston',
                                          'Massachussetts', 1, 'A_280', status);

    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_zip_code('A_280', 1, 1, 'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident',
    'Boston',
                                          'Massachussetts', 1, 'A_280', status);

    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
        
--- TEST UPDATE
    pk_app_admin.pr_insert_update_zip_code('A_280', 1, 1, 'Middlesex', 'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident',
                                          'Massachussetts', 1, 'A_280', status);

    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
        
--- TEST UPDATE
    pk_app_admin.pr_insert_update_zip_code('A_280', 1, 1, 'Middlesex', 'Boston',
                                          'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident',
                                          1, 'A_280', status);

    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_zip_code('A_280', 1, 1, 'Couny123', 'Boston',
                                          'Massachussetts', 1, 'A_280', status);

    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
        
--- TEST UPDATE
    pk_app_admin.pr_insert_update_zip_code('A_280', 1, 1, 'Middlesex', 'City123',
                                          'Massachussetts', 1, 'A_280', status);

    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
        
--- TEST UPDATE
    pk_app_admin.pr_insert_update_zip_code('A_280', 1, 1, 'Middlesex', 'Boston',
                                          'State123', 1, 'A_280', status);

    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_zip_code('A_280', 1, 1, 'Middlesex', 'Boston',
                                          'Massachussetts', 10, 'A_280', status);

    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
END;
/

-----------------------------------------------------------------------------------------------------
--- USER_DETAILS
-----------------------------------------------------------------------------------------------------

DECLARE
    status VARCHAR2(400);
BEGIN

--- PART M
--- TEST UPDATE USER_DETAILS
    pk_app_admin.pr_insert_update_user_details('A_280', 499, 'James', 'Gunn', 'Male',
                                              '12-FEB-89', 86, 174, 2349, 4,
                                              1, 'A_280', status);

    dbms_output.put_line('TEST UPDATE - OUTPUT: ' || status);
    
--- TEST INSERT WITH DEFAULT
    pk_app_admin.pr_insert_update_user_details('A_280', 5000, 'Chuck', 'Buttowski', 'Male',
                                              '11-MAY-79', 90, 184, 1001, 5,
                                              3, 'A_280', status);

    dbms_output.put_line('TEST INSERT - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_user_details('A_280', 499, 'Chriss', 'Hemsworth', 'Male',
                                              sysdate + 5, 99, 184, 1001, 5,
                                              3, 'A_280', status);

    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_user_details('A_280', 499, 'Chriss', 'Hemsworth', 'Male',
                                              '11-MAY-79', 99, 184, 32000, 80,
                                              3, 'A_280', status);

    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
    
--- TEST UPDATE
    pk_app_admin.pr_insert_update_user_details('A_280', 499, 'Chriss', 'Hemsworth', 'Male',
                                              '11-MAY-79', 99, 184, 1001, 5,
                                              40, 'A_280', status);

    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
END;
/

-----------------------------------------------------------------------------------------------------
--- APP_USER
-----------------------------------------------------------------------------------------------------

DECLARE
    status VARCHAR2(400);
BEGIN

--- PART N
--- TEST UPDATE APP_USER
    pk_app_admin.pr_insert_update_app_user('A_280', 489, 2, 'D_489', 'D_489',
                                          'A_280', status);
    dbms_output.put_line('TEST UPDATE - OUTPUT: ' || status);
    
--- TEST INSERT WITH DEFAULT
--    pk_app_admin.pr_insert_update_app_user('A_280', 490, 2, 'D_490', 'D_490',
--                                          'A_280', status);

--    dbms_output.put_line('TEST INSERT - OUTPUT: ' || status);
    
----- TEST UPDATE
--    pk_app_admin.pr_insert_update_app_user('A_280', 469, 3, NULL, NULL,
--                                          'A_280', status);

    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);

--- TEST UPDATE
--    pk_app_admin.pr_insert_update_app_user('A_280', 477, 20, 'D_477', 'D_477',
--                                          'A_280', status);

    dbms_output.put_line('TEST NULL - OUTPUT: ' || status);
END;
/
-----------------------------------------------------------------------------------------------------
--- DELETE APP_USER
-----------------------------------------------------------------------------------------------------

DECLARE
    status VARCHAR2(400);
BEGIN
--    pk_app_admin.pr_delete_app_user('A_280', 489,2, 'A_280', status);
--    dbms_output.put_line('TEST DELETE - OUTPUT: ' || status);
    pk_app_admin.pr_delete_app_user('A_280', 637, 2, 'A_280', status);
    dbms_output.put_line('TEST INVALID USER - OUTPUT: ' || status);
    pk_app_admin.pr_delete_app_user('A_280', 437, 50, 'A_280', status);
    dbms_output.put_line('TEST INVALID ROLE - OUTPUT: ' || status);
END;
/


-----------------------------------------------------------------------------------------------------
--- ROLLBACKS
-----------------------------------------------------------------------------------------------------
--BEGIN
----- ROLLBACK ALLERGY
--    DELETE from ALLERGIES where allergy_name='Metal Allergy';
--    UPDATE ALLERGIES SET allergy_name='Wheat Allergy' where allergy_id=7;
--
--END;
/
--
--
--BEGIN
----- ROLLBACK APP_ROLE
--    DELETE from APP_ROLE where role_type='Pharmacy';
--    UPDATE APP_ROLE SET role_type='Pharmacist' where role_id=3;
--
--END;
/
--
--
--BEGIN
----- ROLLBACK COUNTRY
--    DELETE from COUNTRY where country_code>1;
--    UPDATE COUNTRY SET country_name='US' where country_code=1;
--
--END;
--/
--
--
--BEGIN
----- ROLLBACK DIET
--    DELETE from DIET where diet_id>11;
--    UPDATE DIET SET diet_type='Ovo-Lacto Vegetarian' where diet_id=9;
--END;
--/
--
--
--BEGIN
----- ROLLBACK DISEASES
--    DELETE from DISEASES where disease_name='Leukemia';
--    UPDATE DISEASES SET disease_name='Hemophilia',is_chronic='TRUE', is_hereditary='TRUE',is_terminal='TRUE' where disease_id=20;
--END;
--/
--
--
--BEGIN
----- ROLLBACK ETHNICITY
--    DELETE from ETHNICITY where ethnicity_name='Nordic';
--    UPDATE ETHNICITY SET ethnicity_name='Hawaian' where ethnicity_id=5;
--END;
--/
--
--
--BEGIN
----- ROLLBACK HABIT
--    DELETE from HABIT where habit_name='Not Eating';
--    UPDATE HABIT SET habit_name='JUUL' where habit_id=3;
--END;
--/
--
--
--BEGIN
----- ROLLBACK MEDICINE
--    DELETE from MEDICINES where medicine_name='Combiflam';
--    UPDATE MEDICINES SET medicine_name='zofram' where medicine_id=10;
--END;
--/
--
--
--BEGIN
----- ROLLBACK SYMPTOMS
--    DELETE from SYMPTOMS where symptom_name='Blackout';
--    UPDATE SYMPTOMS SET symptom_name='Thinning Hair' where symptom_id=35;
--END;
--/
--
--
--BEGIN
----- ROLLBACK VACCINE
--    DELETE from VACCINE where vaccine_name='PSLV4';
--    UPDATE VACCINE SET vaccine_name='PCV13',disease_id=15 where vaccine_id=1;
--END;
--/
--
--
--BEGIN
----- ROLLBACK LOCATION_STATISTICS
--    DELETE from LOCATION_STATISTICS where location_code>31836;
--    UPDATE LOCATION_STATISTICS SET zip_id=1,particulate_matter_reading=3,co_readings=4,no2_readings=0,air_polution_index=1,water_quality_parameter=1 where location_code=1;
--END;
--/
--
--BEGIN
----- ROLLBACK ZIPCODE
--    DELETE from ZIPCODE where zip_id>31836;
--    UPDATE ZIPCODE SET zip_code=1,county='Hampden',city='Agawam',state_name='Massachusetts',country_code=1 where zip_id=1;
--END;
--/
--
--
--BEGIN
----- ROLLBACK USER_DETAILS
--    DELETE from USER_DETAILS where last_name='Buttowski';
--    UPDATE USER_DETAILS SET first_name='Jani',last_name='Biddy',gender='Male',date_of_birth='11-DEC-69',weight=95,height=150,zip_id=3997,diet_id=2,ethnicity_id=3 where user_id=499;
--END;
--/
--
--BEGIN
----- ROLLBACK USER_DETAILS
--    UPDATE APP_USER SET role_id=1 where user_id=490;
--    UPDATE APP_USER SET role_id=1 where user_id=489;
--END;
--/
-----------------------------------------------------------------------------------------------------
--- ALLERGY
-----------------------------------------------------------------------------------------------------
set serveroutput on;

DECLARE

STATUS varchar2(400);

BEGIN

--- PART A
--- TEST UPDATE ALLERGY
    pk_app_admin.PR_INSERT_UPDATE_ALLERGY(7,'Cotton Allergy',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST UPDATE - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_ALLERGY(47,'Metal Allergy',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST INSERT - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_ALLERGY(4,'Some 123 Allergy',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NUMBER - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_ALLERGY(NULL,'New Allergy',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_ALLERGY(7,'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST TOO LONG - OUTPUT: '|| STATUS);

END;
/

BEGIN
--- ROLLBACK ALLERGY
    DELETE from ALLERGIES where allergy_id>30;
    UPDATE ALLERGIES SET allergy_name='Wheat Allergy' where allergy_id=7;

END;
/
-----------------------------------------------------------------------------------------------------
--- APP_ROLE
-----------------------------------------------------------------------------------------------------


DECLARE

STATUS varchar2(400);

BEGIN

--- PART B
--- TEST UPDATE APP_ROLE
    pk_app_admin.PR_INSERT_UPDATE_APP_ROLE(3,'Chemist',sysdate,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST UPDATE - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_APP_ROLE(9,'Pharmacy',sysdate,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST INSERT - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_APP_ROLE(3,'Some 123',sysdate,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NUMBER - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_APP_ROLE(NULL,'New Role',sysdate,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_APP_ROLE(3,'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',sysdate,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST TOO LONG - OUTPUT: '|| STATUS);    
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_APP_ROLE(3,'Pharmacist',sysdate+5,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST FUTURE DATE - OUTPUT: '|| STATUS);

END;
/

BEGIN
--- ROLLBACK APP_ROLE
    DELETE from APP_ROLE where role_id>4;
    UPDATE APP_ROLE SET role_type='Pharmacist' where role_id=3;

END;
/

-----------------------------------------------------------------------------------------------------
--- COUNTRY
-----------------------------------------------------------------------------------------------------


DECLARE

STATUS varchar2(400);

BEGIN

--- PART C
--- TEST UPDATE COUNTRY
    pk_app_admin.PR_INSERT_UPDATE_COUNTRY(1,'IN',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST UPDATE - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_COUNTRY(2,'UK',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST INSERT - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_COUNTRY(1,'Some 123',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NUMBER - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_COUNTRY(NULL,'New Country',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_COUNTRY(1,'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST TOO LONG - OUTPUT: '|| STATUS);    

END;
/

BEGIN
--- ROLLBACK COUNTRY
    DELETE from COUNTRY where country_code>1;
    UPDATE COUNTRY SET country_name='US' where country_code=1;

END;
/
-----------------------------------------------------------------------------------------------------
--- DIET
-----------------------------------------------------------------------------------------------------


DECLARE

STATUS varchar2(400);

BEGIN

--- PART D
--- TEST UPDATE DIET
    pk_app_admin.PR_INSERT_UPDATE_DIET(9,'OVO-Waterarian',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST UPDATE - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_DIET(17,'Non Eatarian',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST INSERT - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_DIET(9,'Some 123',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NUMBER - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_DIET(NULL,'New Diet',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_DIET(9,'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST TOO LONG - OUTPUT: '|| STATUS);    

END;
/

BEGIN
--- ROLLBACK DIET
    DELETE from DIET where diet_id>11;
    UPDATE DIET SET diet_type='Ovo-Lacto Vegetarian' where diet_id=9;
END;
/

-----------------------------------------------------------------------------------------------------
--- DISEASES
-----------------------------------------------------------------------------------------------------


DECLARE

STATUS varchar2(400);

BEGIN

--- PART E
--- TEST UPDATE DISEASES
    pk_app_admin.PR_INSERT_UPDATE_DISEASE(20,'Diarrhea','FALSE', 'FALSE','FALSE',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST UPDATE - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_DISEASE(73,'Leukemia','TRUE','TRUE','TRUE',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST INSERT - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_DISEASE(NULL,'New Disease','TRUE', 'FALSE','FALSE',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_MEDICINE(20,'Some 123$',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NUMBER - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_DISEASE(20,'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout','FALSE', 'TRUE','FALSE',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST TOO LONG - OUTPUT: '|| STATUS);    
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_DISEASE(20,'Hemophilia','TRUE', 'TRUE','NOTHING',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST TERMINAL WRONG- OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_DISEASE(20,'Hemophilia','TRUE', 'NOTHING','TRUE',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST HEREDITARY WRONG- OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_DISEASE(20,'Hemophilia','', 'TRUE','TRUE',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST CHRONIC WRONG- OUTPUT: '|| STATUS);

END;
/

BEGIN
--- ROLLBACK DISEASES
    DELETE from DISEASES where disease_id>21;
    UPDATE DISEASES SET disease_name='Hemophilia',is_chronic='TRUE', is_hereditary='TRUE',is_terminal='TRUE' where disease_id=20;
END;
/

-----------------------------------------------------------------------------------------------------
--- ETHNICITY
-----------------------------------------------------------------------------------------------------


DECLARE

STATUS varchar2(400);

BEGIN

--- PART F
--- TEST UPDATE ETHNICITY
    pk_app_admin.PR_INSERT_UPDATE_ETHNICITY(5,'Arab',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST UPDATE - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_ETHNICITY(9,'Nordic',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST INSERT - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_ETHNICITY(5,'Some 123',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NUMBER - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_ETHNICITY(NULL,'New Ethnicity',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_ETHNICITY(5,'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST TOO LONG - OUTPUT: '|| STATUS);    

END;
/

BEGIN
--- ROLLBACK ETHNICITY
    DELETE from ETHNICITY where ethnicity_id>11;
    UPDATE ETHNICITY SET ethnicity_name='Hawaian' where ethnicity_id=5;
END;
/

-----------------------------------------------------------------------------------------------------
--- HABIT
-----------------------------------------------------------------------------------------------------


DECLARE

STATUS varchar2(400);

BEGIN

--- PART G
--- TEST UPDATE HABIT
    pk_app_admin.PR_INSERT_UPDATE_HABIT(3,'Over Sleeping',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST UPDATE - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_HABIT(17,'Not Eating',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST INSERT - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_HABIT(3,'Some 123',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NUMBER - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_HABIT(NULL,'New Habit',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_HABIT(3,'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST TOO LONG - OUTPUT: '|| STATUS);    

END;
/

BEGIN
--- ROLLBACK HABIT
    DELETE from HABIT where habit_id>12;
    UPDATE HABIT SET habit_name='JUUL' where habit_id=3;
END;
/

-----------------------------------------------------------------------------------------------------
--- MEDICINE
-----------------------------------------------------------------------------------------------------


DECLARE

STATUS varchar2(400);

BEGIN

--- PART H
--- TEST UPDATE MEDICINE
    pk_app_admin.PR_INSERT_UPDATE_MEDICINE(10,'Disprin',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST UPDATE - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_MEDICINE(46,'Combiflam',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST INSERT - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_MEDICINE(10,'Some 123$',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NUMBER - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_MEDICINE(NULL,'New Medicine',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_MEDICINE(10,'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST TOO LONG - OUTPUT: '|| STATUS);    

END;
/

BEGIN
--- ROLLBACK MEDICINE
    DELETE from MEDICINES where medicine_id>20;
    UPDATE MEDICINES SET medicine_name='zofram' where medicine_id=10;
END;
/

-----------------------------------------------------------------------------------------------------
--- SYMPTOMS
-----------------------------------------------------------------------------------------------------


DECLARE

STATUS varchar2(400);

BEGIN

--- PART I
--- TEST UPDATE SYMPTOMS
    pk_app_admin.PR_INSERT_UPDATE_SYMPTOMS(35,'Loose Motion',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST UPDATE - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_SYMPTOMS(93,'Blackout',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST INSERT - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_SYMPTOMS(35,'Some 123',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NUMBER - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_SYMPTOMS(NULL,'New Symptom',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_SYMPTOMS(35,'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST TOO LONG - OUTPUT: '|| STATUS);    

END;
/

BEGIN
--- ROLLBACK SYMPTOMS
    DELETE from SYMPTOMS where symptom_id>40;
    UPDATE SYMPTOMS SET symptom_name='Thinning Hair' where symptom_id=35;
END;
/

-----------------------------------------------------------------------------------------------------
--- VACCINE
-----------------------------------------------------------------------------------------------------


DECLARE

STATUS varchar2(400);

BEGIN

--- PART J
--- TEST UPDATE VACCINE
    pk_app_admin.PR_INSERT_UPDATE_VACCINE(1,'PCS13',15,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST UPDATE - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_VACCINE(9,'PSLV4',13,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST INSERT - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_VACCINE(1,'Some 12^3',13,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST INVALID NAME - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_VACCINE(NULL,'New Vaccine',13,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_VACCINE(1,'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout',13,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST TOO LONG - OUTPUT: '|| STATUS);    

--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_VACCINE(1,'PSLV4',33,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST DISEASE NOT EXIST - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_VACCINE(1,'PSLV4',NULL,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST DISEASE NULL - OUTPUT: '|| STATUS);  

END;
/

BEGIN
--- ROLLBACK VACCINE
    DELETE from VACCINE where vaccine_id>6;
    UPDATE VACCINE SET vaccine_name='PCV13',disease_id=15 where vaccine_id=1;
END;
/

-----------------------------------------------------------------------------------------------------
--- LOCATION_STATISTICS
-----------------------------------------------------------------------------------------------------


DECLARE

STATUS varchar2(400);

BEGIN

--- PART K
--- TEST UPDATE LOCATION_STATISTICS
    pk_app_admin.PR_INSERT_UPDATE_LOCATION_STAT(1,1,140,140,140,140,70,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST UPDATE - OUTPUT: '|| STATUS);
    
--- TEST INSERT WITH DEFAULT
    pk_app_admin.PR_INSERT_UPDATE_LOCATION_STAT(32000,31000,'','','','','',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST INSERT - OUTPUT: '|| STATUS);
    
--- TEST INSERT
    pk_app_admin.PR_INSERT_UPDATE_LOCATION_STAT(34000,34000,100,100,100,100,100,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST INSERT - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_LOCATION_STAT(NULL,32000,100,100,100,100,100,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_LOCATION_STAT(33000,NULL,'','','','','',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);

END;
/

BEGIN
--- ROLLBACK LOCATION_STATISTICS
    DELETE from LOCATION_STATISTICS where location_code>31836;
    UPDATE LOCATION_STATISTICS SET zip_id=1,particulate_matter_reading=3,co_readings=4,no2_readings=0,air_polution_index=1,water_quality_parameter=1 where location_code=1;
END;
/

-----------------------------------------------------------------------------------------------------
--- ZIPCODE
-----------------------------------------------------------------------------------------------------


DECLARE

STATUS varchar2(400);

BEGIN

--- PART L
--- TEST UPDATE ZIPCODE
    pk_app_admin.PR_INSERT_UPDATE_ZIP_CODE(1,1,'Middlesex','Boston','Massachussetts',1,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST UPDATE - OUTPUT: '|| STATUS);
    
--- TEST INSERT WITH DEFAULT
    pk_app_admin.PR_INSERT_UPDATE_ZIP_CODE(32001,32001,'Middlesex','Boston','Massachussetts',1,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST INSERT - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_ZIP_CODE(NULL,32000,'Middlesex','Boston','Massachussetts',1,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_ZIP_CODE(33000,NULL,'Middlesex','Boston','Massachussetts',1,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_ZIP_CODE(1,1,'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident','Boston','Massachussetts',1,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
        
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_ZIP_CODE(1,1,'Middlesex','At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident','Massachussetts',1,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
        
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_ZIP_CODE(1,1,'Middlesex','Boston','At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident',1,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_ZIP_CODE(1,1,'Couny123','Boston','Massachussetts',1,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
        
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_ZIP_CODE(1,1,'Middlesex','City123','Massachussetts',1,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
        
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_ZIP_CODE(1,1,'Middlesex','Boston','State123',1,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_ZIP_CODE(1,1,'Middlesex','Boston','Massachussetts',10,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
   
END;
/

BEGIN
--- ROLLBACK ZIPCODE
    DELETE from ZIPCODE where zip_id>31836;
    UPDATE ZIPCODE SET zip_code=1,county='Hampden',city='Agawam',state_name='Massachusetts',country_code=1 where zip_id=1;
END;
/

-----------------------------------------------------------------------------------------------------
--- USER_DETAILS
-----------------------------------------------------------------------------------------------------


DECLARE

STATUS varchar2(400);

BEGIN

--- PART M
--- TEST UPDATE USER_DETAILS
    pk_app_admin.PR_insert_update_user_details(1,'James','Gunn','Male','12-FEB-89',86,174,2349,4,1,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST UPDATE - OUTPUT: '|| STATUS);
    
--- TEST INSERT WITH DEFAULT
    pk_app_admin.PR_insert_update_user_details(5000,'Chuck','Buttowski','Male','11-MAY-79',90,184,1001,5,3,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST INSERT - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_insert_update_user_details(1,'Chriss','Hemsworth','Male',sysdate+5,99,184,1001,5,3,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_insert_update_user_details(1,'Chriss','Hemsworth','Male','11-MAY-79',99,184,32000,80,3,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_insert_update_user_details(1,'Chriss','Hemsworth','Male','11-MAY-79',99,184,1001,5,40,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);
   
END;
/

BEGIN
--- ROLLBACK USER_DETAILS
    DELETE from USER_DETAILS where user_id>500;
    UPDATE USER_DETAILS SET first_name='James',last_name='Butt',gender='Male',date_of_birth='11-JUN-89',weight=96,height=174,zip_id=2349,diet_id=1,ethnicity_id=4 where user_id=1;
END;
/
-----------------------------------------------------------------------------------------------------
--- APP_USER
-----------------------------------------------------------------------------------------------------


DECLARE

STATUS varchar2(400);

BEGIN

--- PART N
--- TEST UPDATE APP_USER
    pk_app_admin.PR_INSERT_UPDATE_APP_USER(1,1,'Jim','Halpert',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST UPDATE - OUTPUT: '|| STATUS);
    
--- TEST INSERT WITH DEFAULT
    pk_app_admin.PR_INSERT_UPDATE_APP_USER(2,2,'Dwight','Schrute',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST INSERT - OUTPUT: '|| STATUS);
    
--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_APP_USER(1,3,NULL,NULL,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);

--- TEST UPDATE
    pk_app_admin.PR_INSERT_UPDATE_APP_USER(5,20,'Stan','Lee',STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST NULL - OUTPUT: '|| STATUS);   
END;
/
-----------------------------------------------------------------------------------------------------
--- DELETE APP_USER
-----------------------------------------------------------------------------------------------------


DECLARE

STATUS varchar2(400);
BEGIN
    pk_app_admin.PR_DELETE_APP_USER(2,2,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST DELETE - OUTPUT: '|| STATUS);
    
    pk_app_admin.PR_DELETE_APP_USER(20,1,STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST INVALID USER - OUTPUT: '|| STATUS);
    
    pk_app_admin.PR_DELETE_APP_USER(1,50, STATUS);
    DBMS_OUTPUT.PUT_LINE('TEST INVALID ROLE - OUTPUT: '|| STATUS);
END;
/

BEGIN
--- ROLLBACK USER_DETAILS
    DELETE from APP_USER;
    --where user_id>500;
    --UPDATE APP_USER SET role_id=1 where user_id=1;
END;
/
--------------------------------------------------------
--  File created - Saturday-December-18-2021   
--------------------------------------------------------
DROP PROCEDURE "PR_ADD_UPDATE_DISEASE_PATIENT";
DROP PROCEDURE "PR_DELETE_VISIT_HISTORY";
DROP PROCEDURE "PR_ADD_UPDATE_VISIT_HISTORY";
DROP PROCEDURE "PR_DELETE_APP_USER";
DROP PROCEDURE "PR_VIEW_PATIENT_ALLERGIES_DETAILS";
DROP PROCEDURE "PR_INSERT_UPDATE_APP_USER";
DROP PROCEDURE "PR_VIEW_PATIENT_FAMILY_HISTORY";
DROP PROCEDURE "PR_PATIENT_REPORT";
DROP PROCEDURE "PR_INSERT_UPDATE_VACCINE";
DROP PROCEDURE "PR_INSERT_UPDATE_ALLERGY";
DROP PROCEDURE "PR_VIEW_PATIENT_VACCINE_DETAILS";
DROP PROCEDURE "PR_INSERT_UPDATE_ETHNICITY";
DROP PROCEDURE "PR_INSERT_ALERGIES_PATIENT";
DROP PROCEDURE "PR_ADD_VACCINE_RECORD";
DROP PROCEDURE "VIEW_PATIENT_DETAILS";
DROP PROCEDURE "PR_DELETE_VACCINE_RECORD";
DROP PROCEDURE "PR_INSERT_UPDATE_LOCATION_STAT";
DROP PROCEDURE "PR_DELETE_PRESCRIPTION_RECORD";
DROP PROCEDURE "TEMP_SYMPTON_PATIENT_DISEASE";
DROP PROCEDURE "PR_ADD_UPDATE_PRESCRIPTION";
DROP PROCEDURE "PR_INSERT_UPDATE_SYMPTOMS";
DROP PROCEDURE "PR_INSERT_UPDATE_DIET";
DROP PROCEDURE "PR_VIEW_VISITOR_HISTORY";
DROP PROCEDURE "PR_INSERT_UPDATE_APP_ROLE";
DROP PROCEDURE "PR_INSERT_UPDATE_USER_DETAILS";
DROP PROCEDURE "PR_INSERT_UPDATE_COUNTRY";
DROP PROCEDURE "PR_INSERT_UPDATE_MEDICINE";
DROP PROCEDURE "PR_INSERT_SYMPTOM_PATIENT";
DROP PROCEDURE "PR_PATIENT_PRESCRIPTION";
DROP PROCEDURE "PR_INSERT_UPDATE_ZIP_CODE";
DROP PROCEDURE "PR_INSERT_UPDATE_HABIT";
DROP PROCEDURE "TEMP_INSERT_INTO_TABLE_USER_APP";
DROP PROCEDURE "PR_INSERT_UPDATE_DISEASE";
DROP PROCEDURE "PR_UPDATE_CURED_DISEASE_PATIENT";
DROP PROCEDURE "PR_VIEW_PATIENT_HABITS";
DROP PROCEDURE "PR_INSERT_FAMILY";
DROP PROCEDURE "TEMP_PATIENT_RELATION_DATA";
DROP PROCEDURE "PR_INSERT_HABIT_PATIENT";
--------------------------------------------------------
--  DDL for Procedure PR_ADD_UPDATE_DISEASE_PATIENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_ADD_UPDATE_DISEASE_PATIENT" (
    DP_ID_IN IN disease_patient.dp_id%TYPE,
    DOCTOR_ID_IN IN disease_patient.doctor_id%TYPE,
    DISEASE_ID_IN IN disease_patient.disease_id%TYPE,
    PATIENT_ID_IN IN disease_patient.patient_id%TYPE,
    STATUS OUT VARCHAR2,
    MESSAGE OUT VARCHAR2
)
IS
    DISEASE_NOT_FOUND EXCEPTION;
    PATIENT_NOT_FOUND EXCEPTION;
    DOCTOR_NOT_FOUND EXCEPTION;
    RECORD_NOT_FOUND EXCEPTION;
BEGIN
    IF(IS_DISEASE_EXIST(DISEASE_ID_IN) = 0) THEN
        RAISE DISEASE_NOT_FOUND; 
    END IF;

    IF(IS_USER_EXIST(PATIENT_ID_IN) = 0) THEN
        RAISE PATIENT_NOT_FOUND;
    END IF;

    IF(IS_USER_EXIST(DOCTOR_ID_IN) = 0) THEN
        RAISE DOCTOR_NOT_FOUND;
    END IF;

    IF(DP_ID_IN IS NULL) THEN
        INSERT INTO DISEASE_PATIENT DP (
            DOCTOR_ID,
            DISEASE_ID,
            PATIENT_ID,
            IS_ACTIVE,
            DATE_DIAGNOSED
        ) VALUES (
            DOCTOR_ID_IN,
            DISEASE_ID_IN,
            PATIENT_ID_IN,
            'Y',
            SYSDATE
        );

        MESSAGE := 'Disease record successfully inserted';

    ELSE
        UPDATE DISEASE_PATIENT DP
        SET DP.DISEASE_ID = NVL(DISEASE_ID_IN, DISEASE_ID),
        DP.PATIENT_ID = NVL(PATIENT_ID_IN, PATIENT_ID)
        WHERE DP.DP_ID = DP_ID_IN
        AND DP.DOCTOR_ID = DOCTOR_ID_IN;

        IF(SQL%ROWCOUNT = 0) THEN
            RAISE RECORD_NOT_FOUND;
        END IF;

        MESSAGE := 'Disease record successfully updated';
    END IF;

    COMMIT;

    STATUS := 'S';

EXCEPTION
     WHEN DOCTOR_NOT_FOUND THEN
        STATUS := 'F';
        MESSAGE := 'Doctor records not found in the database';
    WHEN PATIENT_NOT_FOUND THEN
        STATUS := 'F';
        MESSAGE := 'Patient records not found in the database';
    WHEN DISEASE_NOT_FOUND THEN
        STATUS := 'F';
        MESSAGE := 'Disease record not found in the database';
    WHEN OTHERS THEN
        STATUS := 'F';
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        MESSAGE := 'Something went wrong';          

END;

/
--------------------------------------------------------
--  DDL for Procedure PR_DELETE_VISIT_HISTORY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_DELETE_VISIT_HISTORY" (
    DOCTOR_ID_IN IN visit_history.doctor_id%TYPE,
    VISIT_ID_IN IN visit_history.visit_id%TYPE,
    STATUS OUT VARCHAR2,
    MESSAGE OUT VARCHAR2
)
IS
    RECORD_NOT_FOUND EXCEPTION;
BEGIN
    DELETE FROM visit_history VH
    WHERE VH.VISIT_ID = VISIT_ID_IN
    AND vh.doctor_id = DOCTOR_ID_IN;

    IF(SQL%ROWCOUNT = 0) THEN
        RAISE RECORD_NOT_FOUND;
    END IF;

    COMMIT;

    STATUS := 'S';
    MESSAGE := 'Visit history successfully deleted';

EXCEPTION
    WHEN RECORD_NOT_FOUND THEN
        STATUS := 'F';
        MESSAGE := 'Visit record not found for ID: ' || VISIT_ID_IN || ' administered by doctor ID: ' || DOCTOR_ID_IN;
    WHEN OTHERS THEN
        STATUS := 'F';
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        MESSAGE := 'Something went wrong';    
END;

/
--------------------------------------------------------
--  DDL for Procedure PR_ADD_UPDATE_VISIT_HISTORY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_ADD_UPDATE_VISIT_HISTORY" (
    VISIT_ID_IN IN visit_history.visit_id%TYPE,
    DP_ID_IN IN visit_history.dp_id%TYPE,
    DOCTOR_ID_IN IN visit_history.doctor_id%TYPE,
    VISIT_NOTES_IN IN visit_history.visit_notes%TYPE,
    STATUS OUT VARCHAR2,
    MESSAGE OUT VARCHAR2
)  
IS
    ILLNESS_RECORD_NOT_FOUND EXCEPTION;
    DOCTOR_NOT_FOUND EXCEPTION;
    RECORD_NOT_FOUND EXCEPTION;

BEGIN

    IF(FN_IS_VALID_ILLNESS_RECORD(DP_ID_IN) = 'N') THEN
        RAISE ILLNESS_RECORD_NOT_FOUND;
    END IF;

    IF(IS_USER_EXIST(DOCTOR_ID_IN) = 0) THEN
        RAISE DOCTOR_NOT_FOUND;
    END IF;


    IF(VISIT_ID_IN IS NULL OR LENGTH(TRIM(VISIT_ID_IN)) = 0) THEN
       INSERT INTO VISIT_HISTORY (
        VISIT_ID,
        DP_ID,
        DOCTOR_ID,
        VISIT_NOTES
       ) VALUES (
        VISIT_HISTORY_SEQ.NEXTVAL,
        DP_ID_IN,
        DOCTOR_ID_IN,
        VISIT_NOTES_IN
       );

       MESSAGE := 'Visit history successfully inserted';
    ELSE
        UPDATE VISIT_HISTORY
        SET DP_ID = NVL(DP_ID_IN, DP_ID),
            DOCTOR_ID = NVL(DOCTOR_ID_IN, DOCTOR_ID),
            VISIT_NOTES = NVL(VISIT_NOTES_IN, VISIT_NOTES)
        WHERE VISIT_ID =  VISIT_ID_IN;

        IF(SQL%ROWCOUNT = 0) THEN
            RAISE RECORD_NOT_FOUND;
        END IF; 

        MESSAGE := 'Visit history successfully updated';

    END IF;

    COMMIT;

    STATUS := 'S';


EXCEPTION
    WHEN ILLNESS_RECORD_NOT_FOUND THEN
        STATUS := 'F';
        MESSAGE := 'Illness record not found for DP_ID : ' || DP_ID_IN;

    WHEN DOCTOR_NOT_FOUND THEN
        STATUS := 'F';
        MESSAGE := 'Doctor with user ID: ' || DOCTOR_ID_IN || ' not found in system.';

    WHEN RECORD_NOT_FOUND THEN
        STATUS := 'F';
        MESSAGE := 'Visit history record with ID: ' || VISIT_ID_IN || ' not found in system.';    

    WHEN OTHERS THEN
        STATUS := 'F';
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        MESSAGE := 'Something went wrong';

END;

/
--------------------------------------------------------
--  DDL for Procedure PR_DELETE_APP_USER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_DELETE_APP_USER" 
(
  USER_ID_INPUT IN NUMBER 
, ROLE_ID_INPUT IN NUMBER 
, STATUS OUT VARCHAR2 
) IS
  is_user_found NUMBER;
  is_role_found NUMBER;
  is_invalid_user_id_ex EXCEPTION;
  is_invalid_role_id_ex EXCEPTION;
  is_invalid_role_user_ex EXCEPTION;
  is_invalid_role_mapping_ex EXCEPTION;
BEGIN
  IF USER_ID_INPUT IS NULL THEN
    RAISE is_invalid_user_id_ex;
  END IF;
  IF ROLE_ID_INPUT IS NULL THEN
    RAISE is_invalid_role_id_ex;
  END IF;
  is_user_found:=is_user_exist(USER_ID_INPUT);
  is_role_found:=is_app_role_exist(ROLE_ID_INPUT);
  
  IF is_user_found=1 AND is_role_found=1 THEN
    IF is_role_mapped_user(USER_ID_INPUT,ROLE_ID_INPUT)=1 THEN
        DELETE from APP_USER where USER_ID=USER_ID_INPUT AND ROLE_ID=ROLE_ID_INPUT;
        STATUS := 'SUCCESS: USER_ID - ' || USER_ID_INPUT ||' DELETED SUCCESSFULLY';
    ELSE
        RAISE is_invalid_role_mapping_ex;
    END IF;
  ELSE
    IF is_user_found<1 AND is_role_found=1 THEN
        RAISE is_invalid_user_id_ex;
    ELSIF is_user_found=1 AND is_role_found<1 THEN
        RAISE is_invalid_role_id_ex;
    ELSE
        RAISE is_invalid_role_user_ex;
    END IF;
  END IF;
  EXCEPTION
        WHEN is_invalid_user_id_ex THEN
        status := 'Invalid user_id used';
        WHEN is_invalid_role_id_ex THEN
        status := 'Invalid role_id used';
        WHEN is_invalid_role_user_ex THEN
        status := 'Invalid user_id and role_id used';
        WHEN is_invalid_role_mapping_ex THEN
        status := 'This user does not have enough permissions to delete';
END PR_DELETE_APP_USER;

/
--------------------------------------------------------
--  DDL for Procedure PR_VIEW_PATIENT_ALLERGIES_DETAILS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_VIEW_PATIENT_ALLERGIES_DETAILS" (
    v_patient_id IN user_details.user_id%TYPE
) IS
BEGIN
    dbms_output.put_line(' ========================= ALLERGIES ============================== ');
    FOR cur IN (
        select date_created, ALLERGY_NAME, notes  from allergies a, allergies_patient ap where a.allergy_id = ap.allergy_id and ap.patient_id = v_patient_id
    ) LOOP
        dbms_output.put_line('date_created'
                             || ' : '
                             || cur.date_created);
        dbms_output.put_line('ALLERGY_NAME'
                             || ' : '
                             || cur.ALLERGY_NAME);
        dbms_output.put_line('notes'
                             || ' : '
                             || cur.notes);
        dbms_output.put_line(' =========================================================================== ');
    END LOOP;
END;

/
--------------------------------------------------------
--  DDL for Procedure PR_INSERT_UPDATE_APP_USER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_INSERT_UPDATE_APP_USER" (
        user_id_input   IN NUMBER,
        role_id_input   IN NUMBER,
        user_name_input IN app_user.user_name%TYPE,
        password_input  IN VARCHAR2,
        status          OUT VARCHAR2
    ) IS

        is_user_found            NUMBER;
        is_role_found            NUMBER;
        is_invalid_role_id_ex EXCEPTION;
        is_invalid_user_id_ex EXCEPTION;
        user_name_exists_ex EXCEPTION;
        pre_exist_count          NUMBER;
        pre_exist_username_count NUMBER;
    BEGIN
        IF role_id_input IS NULL THEN
            RAISE is_invalid_role_id_ex;
        END IF;
        IF user_id_input IS NULL THEN
            RAISE is_invalid_user_id_ex;
        END IF;
        is_user_found := is_app_user_exist(user_id_input);
        is_role_found := is_app_role_exist(role_id_input);

        IF is_role_found = 0 THEN
            RAISE is_invalid_role_id_ex;
        END IF;

        SELECT
            COUNT(1)
        INTO pre_exist_username_count
        FROM
            app_user
        WHERE
            user_name = user_name_input;

        IF ( pre_exist_username_count > 0 ) THEN
            RAISE user_name_exists_ex;
        END IF;

        SELECT
            COUNT(1)
        INTO pre_exist_count
        FROM
            app_user
        WHERE
                role_id = role_id_input
            AND user_id = user_id_input;

        IF pre_exist_count > 0 THEN
            UPDATE app_user
            SET
                user_name = user_name_input,
                user_password = pk_authentication.encrypt_val(password_input)
            WHERE
                    user_id = user_id_input
                AND role_id = role_id_input;

            status := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
        ELSE
            INSERT INTO app_user (
                user_id,
                role_id,
                user_name,
                user_password
            ) VALUES (
                user_id_input,
                role_id_input,
                user_name_input,
                pk_authentication.encrypt_val(password_input)
            );

            status := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
        END IF;

        COMMIT;
    EXCEPTION
        WHEN is_invalid_role_id_ex THEN
            status := 'ERROR: Role Id can not be null';
        WHEN is_invalid_user_id_ex THEN
            status := 'ERROR: User with this Id does not exist';
        WHEN user_name_exists_ex THEN
            status := 'ERROR: Username already exists';
        WHEN OTHERS THEN
            status := 'Error : ' || sqlerrm;
    END pr_insert_update_app_user;

/
--------------------------------------------------------
--  DDL for Procedure PR_VIEW_PATIENT_FAMILY_HISTORY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_VIEW_PATIENT_FAMILY_HISTORY" (
    v_patient_id IN user_details.user_id%TYPE
) IS
BEGIN
    -- PATIENT FAMILY HISTORY
dbms_output.put_line(' ========================= FAMILY HISTORY ============================== ');
    FOR cur IN (
        SELECT
    t.relative_name, d.disease_name, d.is_hereditary
FROM
    (
        SELECT
            ( ud.first_name
              || ' '
              || ud.last_name ) AS relative_name,
            f.relative_id
        FROM
            family       f,
            user_details ud
        WHERE
                f.relative_id = ud.user_id
            AND f.patient_id = v_patient_id
    )               t
    LEFT JOIN disease_patient dp ON t.relative_id = dp.patient_id
    LEFT JOIN diseases        d ON d.disease_id = dp.disease_id
    ) LOOP
        dbms_output.put_line('relative_name'
                             || ' : '
                             || cur.relative_name);
        dbms_output.put_line('disease_name'
                             || ' : '
                             || cur.disease_name);
        dbms_output.put_line('is_hereditary'
                             || ' : '
                             || cur.is_hereditary);
        dbms_output.put_line(' =========================================================================== ');
    END LOOP;
END;

/
--------------------------------------------------------
--  DDL for Procedure PR_PATIENT_REPORT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_PATIENT_REPORT" (
    v_patient_id IN user_details.user_id%TYPE,
    status       OUT VARCHAR2
) IS
    patient_id_ex EXCEPTION;
    show_data SYS_REFCURSOR;
BEGIN
    IF ( is_user_exist(v_patient_id) < 1 ) THEN
        RAISE patient_id_ex;
    END IF;
    dbms_output.put_line('=====================================================================');
    dbms_output.put_line('======================== PATIENT REPORT ============================');
    dbms_output.put_line('=====================================================================');

--- BASIC DETAILS
    dbms_output.put_line(' ========================= PERSONAL DETAILS ============================== ');
    FOR cur IN (
        SELECT
            user_id,
            first_name,
            last_name,
            gender,
            floor(months_between(trunc(sysdate), date_of_birth) / 12) AS age,
            height,
            weight,
            z.city                                                    city,
            z.state_name                                              state
        FROM
            user_details ud,
            ethnicity    e,
            zipcode      z
        WHERE
                user_id = v_patient_id
            AND ud.ethnicity_id = e.ethnicity_id
            AND ud.zip_id = z.zip_id
    ) LOOP
        dbms_output.put_line('USER_ID'
                             || ' : '
                             || cur.user_id);
        dbms_output.put_line('first_name'
                             || ' : '
                             || cur.first_name);
        dbms_output.put_line('last_name'
                             || ' : '
                             || cur.last_name);
        dbms_output.put_line('gender'
                             || ' : '
                             || cur.gender);
        dbms_output.put_line('age'
                             || ' : '
                             || cur.age);
        dbms_output.put_line('height'
                             || ' : '
                             || cur.height);
        dbms_output.put_line('weight'
                             || ' : '
                             || cur.weight);
        dbms_output.put_line('city'
                             || ' : '
                             || cur.city);
        dbms_output.put_line('state'
                             || ' : '
                             || cur.state);
        dbms_output.put_line(' =========================================================================== ');
    END LOOP;

    -- PATIENT HABBITS
    PR_VIEW_PATIENT_HABITS(v_patient_id);

    PR_VIEW_PATIENT_VACCINE_DETAILS(v_patient_id);
    
    PR_VIEW_PATIENT_FAMILY_HISTORY(v_patient_id);

-- ALLERGIES

    PR_VIEW_PATIENT_ALLERGIES_DETAILS(v_patient_id);

EXCEPTION
    WHEN patient_id_ex THEN
        status := 'ERROR: Invalid Patient ID';
    WHEN OTHERS THEN
        status := 'ERROR: ' || sqlerrm;
END pr_patient_report;

/
--------------------------------------------------------
--  DDL for Procedure PR_INSERT_UPDATE_VACCINE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_INSERT_UPDATE_VACCINE" 
(
  VACCINE_ID_INPUT IN NUMBER 
, VACCINE_NAME_INPUT IN vaccine.vaccine_name%TYPE 
, DISEASE_ID_INPUT IN vaccine.disease_id%TYPE 
, STATUS OUT VARCHAR2
) IS
  is_vaccine_found NUMBER;
  is_disease_found NUMBER;
  is_invalid_vaccine_id_ex EXCEPTION;
  is_invalid_disease_id_ex EXCEPTION;
  is_not_alphanumeric_ex EXCEPTION;
  is_too_long_ex EXCEPTION;
BEGIN
  IF VACCINE_ID_INPUT IS NULL THEN
    RAISE is_invalid_vaccine_id_ex;
  END IF;
  
  IF VACCINE_NAME_INPUT IS NULL OR LENGTH(TRIM(TRANSLATE(VACCINE_NAME_INPUT, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+-.0123456789', ' ')))>0 THEN
    RAISE is_not_alphanumeric_ex;
  END IF;
  
  IF LENGTH(VACCINE_NAME_INPUT)>100 THEN
    RAISE is_too_long_ex;
  END IF;
  
  is_vaccine_found:=IS_VACCINE_EXIST(VACCINE_ID_INPUT);
  is_disease_found:=IS_DISEASE_EXIST(DISEASE_ID_INPUT);
  
  IF is_disease_found=0 THEN
    RAISE is_invalid_disease_id_ex;
  END IF;
  
  IF is_vaccine_found=1 THEN
    IF DISEASE_ID_INPUT IS NOT NULL AND VACCINE_NAME_INPUT IS NOT NULL THEN
        UPDATE VACCINE SET vaccine_name=VACCINE_NAME_INPUT, disease_id=DISEASE_ID_INPUT
        WHERE vaccine_id=VACCINE_ID_INPUT;
    ELSIF DISEASE_ID_INPUT IS NULL AND VACCINE_NAME_INPUT IS NOT NULL THEN
        UPDATE VACCINE SET vaccine_name=VACCINE_NAME_INPUT
        WHERE vaccine_id=VACCINE_ID_INPUT;
    ELSIF DISEASE_ID_INPUT IS NOT NULL AND VACCINE_NAME_INPUT IS NULL THEN
        UPDATE VACCINE SET disease_id=DISEASE_ID_INPUT
        WHERE vaccine_id=VACCINE_ID_INPUT;
    END IF;
    STATUS := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
  ELSE 
    IF DISEASE_ID_INPUT IS NOT NULL AND VACCINE_NAME_INPUT IS NOT NULL THEN
        INSERT INTO VACCINE(vaccine_name,disease_id)
        values(VACCINE_NAME_INPUT,DISEASE_ID_INPUT);
    ELSIF DISEASE_ID_INPUT IS NULL AND VACCINE_NAME_INPUT IS NOT NULL THEN
        RAISE is_invalid_disease_id_ex;
    ELSE
        RAISE is_not_alphanumeric_ex;
    END IF;
    STATUS := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
  END IF;
  COMMIT;
EXCEPTION
    WHEN is_invalid_vaccine_id_ex THEN
        status := 'Vaccine Id can not be null';
    WHEN is_invalid_disease_id_ex THEN
        status := 'Disease with this Id does not exist';
    WHEN is_not_alphanumeric_ex THEN
        status := 'Name should only contain alphanumerics';
    WHEN is_too_long_ex THEN
        status := 'Name is more than 100 characters';
    WHEN OTHERS THEN
        status := sqlerrm;
END PR_INSERT_UPDATE_VACCINE;

/
--------------------------------------------------------
--  DDL for Procedure PR_INSERT_UPDATE_ALLERGY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_INSERT_UPDATE_ALLERGY" 
(
  ALLERGY_ID_INPUT IN NUMBER 
, ALLERGY_NAME_INPUT IN allergies.allergy_name%TYPE 
, STATUS OUT VARCHAR2
) IS 
  is_found NUMBER;
  is_invalid_id_ex EXCEPTION;
  is_not_alphabetic_ex EXCEPTION;
  is_too_long_ex EXCEPTION;
BEGIN

  IF ALLERGY_ID_INPUT IS NULL THEN
    RAISE is_invalid_id_ex;
  END IF;
  
  IF ALLERGY_NAME_INPUT IS NULL OR LENGTH(TRIM(TRANSLATE(ALLERGY_NAME_INPUT, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' ')))>0 THEN
    RAISE is_not_alphabetic_ex;
  END IF;
  
  IF LENGTH(ALLERGY_NAME_INPUT)>100 THEN
    RAISE is_too_long_ex;
  END IF;
  
  is_found:=IS_ALLERGY_EXIST(ALLERGY_ID_INPUT);
  IF is_found=1 THEN
        UPDATE ALLERGIES SET allergy_name=ALLERGY_NAME_INPUT
        WHERE allergy_id=ALLERGY_ID_INPUT;
        STATUS := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
  ELSE 
        INSERT INTO ALLERGIES(allergy_name)
        values(ALLERGY_NAME_INPUT);
        STATUS := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
  END IF;
  COMMIT;
EXCEPTION
    WHEN is_invalid_id_ex THEN
        status := 'Id can not be null';
    WHEN is_not_alphabetic_ex THEN
        status := 'Name should only contain alphabets';
    WHEN is_too_long_ex THEN
        status := 'Name is more than 100 characters';
    WHEN OTHERS THEN
        status := sqlerrm;
END PR_INSERT_UPDATE_ALLERGY;

/
--------------------------------------------------------
--  DDL for Procedure PR_VIEW_PATIENT_VACCINE_DETAILS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_VIEW_PATIENT_VACCINE_DETAILS" (
    v_patient_id IN user_details.user_id%TYPE
) IS
BEGIN
         -- PATIENT VACCINE
    dbms_output.put_line(' ========================= VACCINE DETAILS ============================== ');
    FOR cur IN (
        SELECT
            date_taken,
            vaccine_name,
            disease_name,
            ( ud.first_name
              || ' '
              || ud.last_name ) doctor
        FROM
            (
                SELECT
                    date_taken,
                    vaccine_name,
                    doctor_id,
                    d.disease_name
                FROM
                    vaccine_patient vp,
                    vaccine         v,
                    diseases        d
                WHERE
                        v.vaccine_id = vp.vaccine_id
                    AND d.disease_id = v.disease_id
                    AND vp.patient_id = v_patient_id
            )            tab
            LEFT JOIN user_details ud ON ud.user_id = tab.doctor_id
        ORDER BY
            date_taken DESC
    ) LOOP
        dbms_output.put_line('date_taken'
                             || ' : '
                             || cur.date_taken);
        dbms_output.put_line('vaccine_name'
                             || ' : '
                             || cur.vaccine_name);
        dbms_output.put_line('disease_name'
                             || ' : '
                             || cur.disease_name);
        IF(cur.doctor != null ) then
                dbms_output.put_line('doctor'
                             || ' : '
                             || cur.doctor);
        end if;
        dbms_output.put_line(' =========================================================================== ');
    END LOOP;
END;

/
--------------------------------------------------------
--  DDL for Procedure PR_INSERT_UPDATE_ETHNICITY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_INSERT_UPDATE_ETHNICITY" 
(
  ETHNICITY_ID_INPUT IN NUMBER 
, ETHNICITY_TYPE_INPUT IN ethnicity.ethnicity_name%TYPE 
, STATUS OUT VARCHAR2
) IS 
  is_found NUMBER;
  is_invalid_id_ex EXCEPTION;
  is_not_alphabetic_ex EXCEPTION;
  is_too_long_ex EXCEPTION;
BEGIN

  IF ETHNICITY_ID_INPUT IS NULL THEN
    RAISE is_invalid_id_ex;
  END IF;
  
  IF ETHNICITY_TYPE_INPUT IS NULL OR LENGTH(TRIM(TRANSLATE(ETHNICITY_TYPE_INPUT, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' ')))>0 THEN
    RAISE is_not_alphabetic_ex;
  END IF;
  
  IF LENGTH(ETHNICITY_TYPE_INPUT)>100 THEN
    RAISE is_too_long_ex;
  END IF;
  
  is_found:=IS_ETHNICITY_EXIST(ETHNICITY_ID_INPUT);
  IF is_found=1 THEN
        UPDATE ETHNICITY SET ethnicity_name=ETHNICITY_TYPE_INPUT
        WHERE ethnicity_id=ETHNICITY_ID_INPUT;
        STATUS := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
  ELSE 
        INSERT INTO ETHNICITY(ethnicity_name)
        values(ETHNICITY_TYPE_INPUT);
        STATUS := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
  END IF;
  COMMIT;
EXCEPTION
    WHEN is_invalid_id_ex THEN
        status := 'Id can not be null';
    WHEN is_not_alphabetic_ex THEN
        status := 'Name should only contain alphabets';
    WHEN is_too_long_ex THEN
        status := 'Name is more than 100 characters';
    WHEN OTHERS THEN
        status := sqlerrm;
END PR_INSERT_UPDATE_ETHNICITY;

/
--------------------------------------------------------
--  DDL for Procedure PR_INSERT_ALERGIES_PATIENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_INSERT_ALERGIES_PATIENT" (
    v_allergy_id IN allergies_patient.allergy_id%TYPE,
    v_patient_id IN allergies_patient.patient_id%TYPE,
    doctor_id  IN allergies_patient.doctor_id%TYPE,
    notes      IN allergies_patient.notes%TYPE,
    status     OUT VARCHAR2
) IS
    allergy_id_ex EXCEPTION;
    patient_id_ex EXCEPTION;
    doctor_id_ex EXCEPTION;
    self_ex exception;
    already_exist_ex EXCEPTION;
    pre_exist_count NUMBER;
BEGIN
    IF ( is_allergy_exist(v_allergy_id) < 1 ) THEN
        RAISE allergy_id_ex;
    END IF;
    IF ( is_user_exist(v_patient_id) < 1 ) THEN
        RAISE patient_id_ex;
    END IF;
    IF ( is_user_exist(doctor_id) < 1 ) THEN
        RAISE doctor_id_ex;
    END IF;
    SELECT
        COUNT(1)
    INTO pre_exist_count
    FROM
        allergies_patient
    WHERE
            allergy_id = v_allergy_id
        AND patient_id = v_patient_id;
    DBMS_OUTPUT.put_line('pre_exist_count ' || pre_exist_count || 'allergy_id : '|| v_allergy_id || ' patient_id: ' || v_patient_id);
    IF ( pre_exist_count > 0 ) THEN
        RAISE already_exist_ex;
    END IF;

    IF ( v_patient_id = doctor_id ) then raise self_ex; end if;
    INSERT INTO allergies_patient (
        allergy_id,
        patient_id,
        doctor_id,
        notes
    ) VALUES (
        v_allergy_id,
        v_patient_id,
        doctor_id,
        notes
    );

    COMMIT;
EXCEPTION
    WHEN allergy_id_ex THEN
        status := 'ERROR: Invalid Allergy ID';
    WHEN patient_id_ex THEN
        status := 'ERROR: Invalid Patient ID';
    WHEN doctor_id_ex THEN
        status := 'ERROR: Invalid Doctor ID';
    WHEN already_exist_ex THEN
        status := 'ERROR: Patient already has a record of this allergy';
    WHEN self_ex THEN
        status := 'ERROR: Patient and Doctor cannot be same';
    WHEN OTHERS THEN
        status := 'ERROR: ' || sqlerrm;
END pr_insert_alergies_patient;

/
--------------------------------------------------------
--  DDL for Procedure PR_ADD_VACCINE_RECORD
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_ADD_VACCINE_RECORD" (
    VACCINE_ID_IN vaccine_patient.vaccine_id%TYPE,
    PATIENT_ID_IN vaccine_patient.patient_id%TYPE,
    DOCTOR_ID_IN  vaccine_patient.doctor_id%TYPE,
    STATUS OUT VARCHAR2,
    MESSAGE OUT VARCHAR2
)  
IS
    VACCINE_COUNT NUMBER;
    VACCINE_NOT_FOUND EXCEPTION;
    DOCTOR_NOT_FOUND EXCEPTION;
    PATIENT_NOT_FOUND EXCEPTION;
    VACCINE_ADMINISTERED EXCEPTION;

BEGIN

    IF(IS_VACCINE_EXIST(VACCINE_ID_IN) = 0) THEN
        RAISE VACCINE_NOT_FOUND;
    END IF;

    IF(IS_USER_EXIST(PATIENT_ID_IN) = 0) THEN
        RAISE PATIENT_NOT_FOUND;
    END IF;

    IF(IS_USER_EXIST(DOCTOR_ID_IN) = 0) THEN
        RAISE DOCTOR_NOT_FOUND;
    END IF;

    SELECT COUNT(*) INTO VACCINE_COUNT FROM VACCINE_PATIENT VP
    WHERE vp.patient_id = PATIENT_ID_IN AND vp.vaccine_id = VACCINE_ID_IN;

    IF(VACCINE_COUNT > 0) THEN
        RAISE VACCINE_ADMINISTERED;
    END IF;

    INSERT INTO VACCINE_PATIENT (
        DATE_TAKEN,
        VACCINE_ID,
        PATIENT_ID,
        DOCTOR_ID
    ) VALUES (
        SYSDATE,
        VACCINE_ID_IN,
        PATIENT_ID_IN,
        DOCTOR_ID_IN
    );
    COMMIT;

    STATUS := 'S';
    MESSAGE := 'Vaccine records successfully entered';

EXCEPTION

    WHEN PATIENT_NOT_FOUND THEN
        STATUS := 'F';
        MESSAGE := 'Patient with user ID: ' || DOCTOR_ID_IN || ' not found in system.';

    WHEN DOCTOR_NOT_FOUND THEN
        STATUS := 'F';
        MESSAGE := 'Doctor with user ID: ' || DOCTOR_ID_IN || ' not found in system.';

    WHEN VACCINE_NOT_FOUND THEN
        STATUS := 'F';
        MESSAGE := 'Vaccine with ID: ' || VACCINE_ID_IN || ' not found in system.'; 

    WHEN VACCINE_ADMINISTERED THEN
        STATUS := 'F';
        MESSAGE := 'Vaccine has already been administered to patient';

    WHEN OTHERS THEN
        STATUS := 'F';
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        MESSAGE := 'Something went wrong';

END;

/
--------------------------------------------------------
--  DDL for Procedure VIEW_PATIENT_DETAILS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "VIEW_PATIENT_DETAILS" (
    DOCTOR_ID_IN IN NUMBER,
    PATIENT_ID_IN IN NUMBER,
    STATUS OUT VARCHAR2,
    MESSAGE OUT VARCHAR2
)
IS
    DOCTOR_NOT_FOUND EXCEPTION;
    PATIENT_NOT_FOUND EXCEPTION; 

    R_USER_DETAIL USER_DETAILS%ROWTYPE;
    R_ZIP_DETAILS ZIPCODE%ROWTYPE;
    DIET_TYPE diet.diet_type%TYPE;
    ETHNICITY_DETAIL ethnicity.ethnicity_name%TYPE;

BEGIN

    IF(IS_USER_EXIST(PATIENT_ID_IN) = 0) THEN
        RAISE PATIENT_NOT_FOUND;
    END IF;

    IF(IS_USER_EXIST(DOCTOR_ID_IN) = 0) THEN
        RAISE DOCTOR_NOT_FOUND;
    END IF;


    -- FETCHING PATIENT DETAILS:
    SELECT * INTO r_user_detail FROM user_details UD
    WHERE ud.user_id = PATIENT_ID_IN;

    DBMS_OUTPUT.PUT_LINE('*************************** PATIENT VIEW ***************************');
    dbms_output.put_line(' ========================= PERSONAL DETAILS ============================== ');
    DBMS_OUTPUT.PUT_LINE('Name: ' || R_USER_DETAIL.FIRST_NAME || ' ' || R_USER_DETAIL.LAST_NAME);
    DBMS_OUTPUT.PUT_LINE('Gender: ' || R_USER_DETAIL.gender || ' | Weight: ' || R_USER_DETAIL.weight || ' | Height: ' || R_USER_DETAIL.height );
    DBMS_OUTPUT.PUT_LINE('Date of Birth: ' || R_USER_DETAIL.date_of_birth || ' | Age: ' || floor((sysdate - R_USER_DETAIL.date_of_birth)/365) || ' year/s.');

    SELECT * INTO R_ZIP_DETAILS FROM zipcode Z WHERE z.zip_id = r_user_detail.ZIP_ID;

    DBMS_OUTPUT.PUT_LINE('Zipcode: ' || R_ZIP_DETAILS.zip_code || ' | County: ' || R_ZIP_DETAILS.county || ' | State: ' || R_ZIP_DETAILS.state_name);

    SELECT d.diet_type INTO DIET_TYPE FROM DIET D WHERE d.diet_id = R_USER_DETAIL.DIET_ID;
    SELECT e.ethnicity_name INTO ETHNICITY_DETAIL FROM ETHNICITY E WHERE e.ethnicity_id = R_USER_DETAIL.ETHNICITY_ID;

    DBMS_OUTPUT.PUT_LINE('Diet: ' || diet_type || ' | Ethnicity: ' || ETHNICITY_DETAIL);

    PR_VIEW_PATIENT_HABITS(PATIENT_ID_IN);
    PR_VIEW_PATIENT_ALLERGIES_DETAILS(PATIENT_ID_IN);
    PR_VIEW_PATIENT_FAMILY_HISTORY(PATIENT_ID_IN);
    PR_VIEW_PATIENT_VACCINE_DETAILS(PATIENT_ID_IN);
    PR_VIEW_VISITOR_HISTORY(PATIENT_ID_IN);

EXCEPTION
    WHEN PATIENT_NOT_FOUND THEN
        STATUS := 'F';
        MESSAGE := 'Patient with user ID: ' || DOCTOR_ID_IN || ' not found in system.';

    WHEN DOCTOR_NOT_FOUND THEN
        STATUS := 'F';
        MESSAGE := 'Doctor with user ID: ' || DOCTOR_ID_IN || ' not found in system.';
END;

/
--------------------------------------------------------
--  DDL for Procedure PR_DELETE_VACCINE_RECORD
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_DELETE_VACCINE_RECORD" (
    VACCINE_ID_IN vaccine_patient.vaccine_id%TYPE,
    PATIENT_ID_IN vaccine_patient.patient_id%TYPE,
    DOCTOR_ID_IN  vaccine_patient.doctor_id%TYPE,
    STATUS OUT VARCHAR2,
    MESSAGE OUT VARCHAR2
)
IS
    RECORD_NOT_FOUND EXCEPTION;
BEGIN
    DELETE FROM VACCINE_PATIENT VP
    WHERE VP.vaccine_id = VACCINE_ID_IN
    AND VP.patient_id = PATIENT_ID_IN
    AND VP.doctor_id = DOCTOR_ID_IN;

    IF(SQL%ROWCOUNT = 0) THEN
        RAISE RECORD_NOT_FOUND;
    END IF;

    COMMIT;

    STATUS := 'S';
    MESSAGE := 'Vaccine history successfully deleted';

EXCEPTION
    WHEN RECORD_NOT_FOUND THEN
        STATUS := 'F';
        MESSAGE := 'Vaccine record not found for vaccine ID: ' || VACCINE_ID_IN || ' to patient ID: ' || PATIENT_ID_IN || ' administered by doctor ID: ' || doctor_id_in;
    WHEN OTHERS THEN
        STATUS := 'F';
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        MESSAGE := 'Something went wrong';    
END;

/
--------------------------------------------------------
--  DDL for Procedure PR_INSERT_UPDATE_LOCATION_STAT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_INSERT_UPDATE_LOCATION_STAT" 
(
  LOCATION_CODE_INPUT IN NUMBER 
, ZIP_ID_INPUT IN location_statistics.zip_id%TYPE
, PM_INPUT IN location_statistics.particulate_matter_reading%TYPE DEFAULT 0
, AQI_INPUT IN location_statistics.air_polution_index%TYPE DEFAULT 0
, CO_INPUT IN location_statistics.co_readings%TYPE DEFAULT 0
, NO_INPUT IN location_statistics.no2_readings%TYPE DEFAULT 0
, WQI_INPUT IN location_statistics.water_quality_parameter%TYPE DEFAULT 0
, STATUS OUT VARCHAR2 
)  IS
  is_zip_found NUMBER;
  is_location_found NUMBER;
  is_invalid_zip_id_ex EXCEPTION;
  is_invalid_location_code_ex EXCEPTION;
BEGIN
  IF ZIP_ID_INPUT IS NULL THEN
    RAISE is_invalid_zip_id_ex;
  END IF;
  
  IF LOCATION_CODE_INPUT IS NULL THEN
    RAISE is_invalid_location_code_ex;
  END IF;
  
  is_zip_found:=IS_ZIPCODE_EXIST(ZIP_ID_INPUT);
  is_location_found:=IS_LOCATION_STATISTICS_EXIST(LOCATION_CODE_INPUT);
  
  IF is_zip_found=0 THEN
    RAISE is_invalid_zip_id_ex;
  END IF;

  IF is_location_found=1 THEN
        UPDATE LOCATION_STATISTICS SET zip_id=ZIP_ID_INPUT,particulate_matter_reading=PM_INPUT, co_readings=CO_INPUT,no2_readings=NO_INPUT,air_polution_index=AQI_INPUT,water_quality_parameter=WQI_INPUT
        WHERE location_code=LOCATION_CODE_INPUT;
        STATUS := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
  ELSE 
        INSERT INTO LOCATION_STATISTICS(location_code,zip_id,particulate_matter_reading, co_readings,no2_readings,air_polution_index,water_quality_parameter)
        values(LOCATION_CODE_INPUT,ZIP_ID_INPUT,PM_INPUT,CO_INPUT,NO_INPUT,AQI_INPUT,WQI_INPUT);
        STATUS := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
  END IF;
  COMMIT;
EXCEPTION
    WHEN is_invalid_zip_id_ex THEN
        status := 'Zip id can not be null';
    WHEN is_invalid_location_code_ex THEN
        status := 'Location Code can not be null';
    WHEN OTHERS THEN
        status := sqlerrm;
END PR_INSERT_UPDATE_LOCATION_STAT;

/
--------------------------------------------------------
--  DDL for Procedure PR_DELETE_PRESCRIPTION_RECORD
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_DELETE_PRESCRIPTION_RECORD" (
    P_ID_IN prescription.p_id%TYPE,
    DOCTOR_ID_IN  PRESCRIPTION.doctor_id%TYPE,
    STATUS OUT VARCHAR2,
    MESSAGE OUT VARCHAR2
)
IS
    RECORD_NOT_FOUND EXCEPTION;
BEGIN
    DELETE FROM PRESCRIPTION P
    WHERE p.p_id = P_ID_IN
    AND P.doctor_id = DOCTOR_ID_IN;

    IF(SQL%ROWCOUNT = 0) THEN
        RAISE RECORD_NOT_FOUND;
    END IF;

    COMMIT;

    STATUS := 'S';
    MESSAGE := 'Prescription record successfully deleted';

EXCEPTION
    WHEN RECORD_NOT_FOUND THEN
        STATUS := 'F';
        MESSAGE := 'Prescription record with ID: ' || P_ID_IN || ' prescribed by doctor ID: ' || DOCTOR_ID_IN || ' not found';
    WHEN OTHERS THEN
        STATUS := 'F';
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        MESSAGE := 'Something went wrong';    
END;

/
--------------------------------------------------------
--  DDL for Procedure TEMP_SYMPTON_PATIENT_DISEASE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "TEMP_SYMPTON_PATIENT_DISEASE" 
IS
    DISEASE diseases.disease_id%TYPE;
    MAX_SYMPTOMS NUMBER;
    DISEASE_DATE DATE;
BEGIN

    FOR PATID IN 1..500
    LOOP

        DISEASE_DATE := to_date('2021-01-01', 'yyyy-mm-dd')+dbms_random.value(1, 342);

        SELECT TRUNC(DBMS_RANDOM.VALUE(1, 21))
        INTO DISEASE
        FROM DUAL;

        SELECT COUNT(*)
        INTO MAX_SYMPTOMS
        FROM SYMPTOM_DISEASE SD
        WHERE SD.DISEASE_ID = DISEASE;

        INSERT INTO SYMPTOM_PATIENT (SYMPTOM_ID, PATIENT_ID, DATE_NOTICED)
        SELECT SD.SYMPTOM_ID, PATID, DISEASE_DATE - dbms_random.value(1, 7)
        FROM SYMPTOM_DISEASE SD
        WHERE SD.DISEASE_ID = DISEASE AND
        ROWNUM < CEIL(dbms_random.value(3, MAX_SYMPTOMS))
        ORDER BY DBMS_RANDOM.RANDOM;

        INSERT INTO DISEASE_PATIENT
        VALUES (DISEASE, PATID, DISEASE_DATE);


    END LOOP;

    DELETE FROM DISEASE_PATIENT DP WHERE MOD(dp.patient_id, 7) = 0;
    DELETE FROM SYMPTOM_PATIENT SP WHERE MOD(sp.patient_id, 14) = 0;
    COMMIT;

END;

/
--------------------------------------------------------
--  DDL for Procedure PR_ADD_UPDATE_PRESCRIPTION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_ADD_UPDATE_PRESCRIPTION" (
    P_ID_IN IN PRESCRIPTION.P_ID%TYPE,
    VISIT_ID_IN IN prescription.visit_id%TYPE,
    DOCTOR_ID_IN IN PRESCRIPTION.DOCTOR_ID%TYPE,
    PATIENT_ID_IN IN PRESCRIPTION.PATIENT_ID%TYPE,
    MEDICINE_ID_IN IN prescription.medicine_id%TYPE,
    DOSAGE_IN IN prescription.dosage%TYPE,
    FREQUENCY_IN IN prescription.frequency%TYPE,
    END_DATE_IN IN PRESCRIPTION.DATE_ENDED%TYPE,
    NOTES_IN IN PRESCRIPTION.NOTES%TYPE,
    STATUS OUT VARCHAR2,
    MESSAGE OUT VARCHAR2
) IS
    DOCTOR_NOT_FOUND EXCEPTION;
    PATIENT_NOT_FOUND EXCEPTION;
    MEDICINE_NOT_FOUND EXCEPTION;
    FREQUENCY_NULL_EXCEPTION EXCEPTION;
    END_DATE_EXCEPTION EXCEPTION;
    INVALID_VISIT_ID EXCEPTION;

BEGIN

    IF(IS_USER_EXIST(DOCTOR_ID_IN) = 0) THEN
        RAISE DOCTOR_NOT_FOUND;
    END IF;

    IF(IS_USER_EXIST(PATIENT_ID_IN) = 0) THEN
        RAISE PATIENT_NOT_FOUND;
    END IF;

    IF(IS_MEDICINE_EXIST(MEDICINE_ID_IN) = 0) THEN
        RAISE MEDICINE_NOT_FOUND;
    END IF;

    IF(FREQUENCY_IN IS NULL) THEN
        RAISE FREQUENCY_NULL_EXCEPTION;
    END IF;

    IF(END_DATE_IN < SYSDATE) THEN
        RAISE END_DATE_EXCEPTION;
    END IF;    

    IF(FN_IS_VALID_VISIT_RECORD(VISIT_ID_IN) = 0) THEN
        RAISE INVALID_VISIT_ID;
    END IF;

    IF(P_ID_IN IS NULL) THEN
        INSERT INTO PRESCRIPTION (
            DOCTOR_ID,
            PATIENT_ID,
            MEDICINE_ID,
            DOSAGE,
            FREQUENCY,
            DATE_CREATED,
            DATE_ENDED,
            NOTES,
            VISIT_ID
        ) VALUES (
            DOCTOR_ID_IN,
            PATIENT_ID_IN,
            MEDICINE_ID_IN,
            DOSAGE_IN,
            FREQUENCY_IN,
            SYSDATE,
            END_DATE_IN,
            NOTES_IN,
            VISIT_ID_IN
        );
        MESSAGE := 'Prescription record inserted successfully';
    ELSE 
        UPDATE PRESCRIPTION
        SET DOCTOR_ID = NVL(DOCTOR_ID_IN, DOCTOR_ID),
            PATIENT_ID = NVL(PATIENT_ID_IN, PATIENT_ID),
            MEDICINE_ID = NVL(MEDICINE_ID_IN, MEDICINE_ID),
            DOSAGE = NVL(DOSAGE_IN, DOSAGE),
            FREQUENCY = NVL(FREQUENCY_IN, FREQUENCY),
            DATE_ENDED = NVL(END_DATE_IN, DATE_ENDED),
            NOTES = NVL(NOTES_IN, NOTES),
            VISIT_ID = NVL(VISIT_ID_IN, VISIT_ID)
        WHERE P_ID = P_ID_IN;    
        MESSAGE := 'Prescription record updated successfully'; 
    END IF;

    COMMIT;

    STATUS := 'S';

EXCEPTION

        WHEN DOCTOR_NOT_FOUND THEN
            STATUS := 'F';
            MESSAGE := 'Doctor records not found in the database';
        WHEN PATIENT_NOT_FOUND THEN
            STATUS := 'F';
            MESSAGE := 'Patient records not found in the database';
        WHEN MEDICINE_NOT_FOUND THEN
            STATUS := 'F';
            MESSAGE := 'Medicine not found in the database';
        WHEN FREQUENCY_NULL_EXCEPTION THEN
            STATUS := 'F';
            MESSAGE := 'Medicine frequency cannot be null';
        WHEN END_DATE_EXCEPTION THEN
            STATUS := 'F';
            MESSAGE := 'End date cannot be less than today date ';
        WHEN OTHERS THEN
            STATUS := 'F';
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
            MESSAGE := 'Something went wrong';   
END;

/
--------------------------------------------------------
--  DDL for Procedure PR_INSERT_UPDATE_SYMPTOMS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_INSERT_UPDATE_SYMPTOMS" 
(
  SYMPTOM_ID_INPUT IN NUMBER 
, SYMPTOM_NAME_INPUT IN symptoms.symptom_name%TYPE 
, STATUS OUT VARCHAR2
) IS 
  is_found NUMBER;
  is_invalid_id_ex EXCEPTION;
  is_not_alphabetic_ex EXCEPTION;
  is_too_long_ex EXCEPTION;
BEGIN

  IF SYMPTOM_ID_INPUT IS NULL THEN
    RAISE is_invalid_id_ex;
  END IF;
  
  IF SYMPTOM_NAME_INPUT IS NULL OR LENGTH(TRIM(TRANSLATE(SYMPTOM_NAME_INPUT, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' ')))>0 THEN
    RAISE is_not_alphabetic_ex;
  END IF;
  
  IF LENGTH(SYMPTOM_NAME_INPUT)>100 THEN
    RAISE is_too_long_ex;
  END IF;
  
  is_found:=IS_SYMPTOM_EXIST(SYMPTOM_ID_INPUT);
  IF is_found=1 THEN
        UPDATE symptoms SET symptom_name=SYMPTOM_NAME_INPUT
        WHERE symptom_id=SYMPTOM_ID_INPUT;
        STATUS := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
  ELSE 
        INSERT INTO SYMPTOMS(symptom_name)
        values(SYMPTOM_NAME_INPUT);
        STATUS := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
  END IF;
  COMMIT;
EXCEPTION
    WHEN is_invalid_id_ex THEN
        status := 'Id can not be null';
    WHEN is_not_alphabetic_ex THEN
        status := 'Name should only contain alphabets';
    WHEN is_too_long_ex THEN
        status := 'Name is more than 100 characters';
    WHEN OTHERS THEN
        status := sqlerrm;
END PR_INSERT_UPDATE_SYMPTOMS;

/
--------------------------------------------------------
--  DDL for Procedure PR_INSERT_UPDATE_DIET
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_INSERT_UPDATE_DIET" 
(
  DIET_ID_INPUT IN NUMBER 
, DIET_TYPE_INPUT IN diet.diet_type%TYPE 
, STATUS OUT VARCHAR2
) IS 
  is_found NUMBER;
  is_invalid_id_ex EXCEPTION;
  is_not_alphabetic_ex EXCEPTION;
  is_too_long_ex EXCEPTION;
BEGIN

  IF DIET_ID_INPUT IS NULL THEN
    RAISE is_invalid_id_ex;
  END IF;
  
  IF DIET_TYPE_INPUT IS NULL OR LENGTH(TRIM(TRANSLATE(DIET_TYPE_INPUT, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-', ' ')))>0 THEN
    RAISE is_not_alphabetic_ex;
  END IF;
  
  IF LENGTH(DIET_TYPE_INPUT)>100 THEN
    RAISE is_too_long_ex;
  END IF;
  
  is_found:=IS_DIET_EXIST(DIET_ID_INPUT);
  IF is_found=1 THEN
        UPDATE DIET SET DIET_TYPE=DIET_TYPE_INPUT
        WHERE DIET_ID=DIET_ID_INPUT;
        STATUS := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
  ELSE 
        INSERT INTO DIET(DIET_ID,DIET_TYPE)
        values(DIET_ID_INPUT,DIET_TYPE_INPUT);
        STATUS := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
  END IF;
  COMMIT;
EXCEPTION
    WHEN is_invalid_id_ex THEN
        status := 'Id can not be null';
    WHEN is_not_alphabetic_ex THEN
        status := 'Name should only contain alphabets';
    WHEN is_too_long_ex THEN
        status := 'Name is more than 100 characters';
    WHEN OTHERS THEN
        status := sqlerrm;
END PR_INSERT_UPDATE_DIET;

/
--------------------------------------------------------
--  DDL for Procedure PR_VIEW_VISITOR_HISTORY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_VIEW_VISITOR_HISTORY" (
    v_patient_id IN user_details.user_id%TYPE
) IS
BEGIN
        -- PATIENT'S VISIT HISTORY
    dbms_output.put_line(' ========================= DOCTOR VISIT HISTORY ============================== ');
    FOR cur IN (
        SELECT d.disease_name,
               dp.dp_id, 
               dp.date_diagnosed,
               DECODE(dp.is_active, 'Y', 'ACTIVE', 'INACTIVE') AS ACTIVE,
               ud.first_name || ' ' || ud.last_name AS REPORTED_BY 
        FROM DISEASE_PATIENT DP, DISEASES D, USER_DETAILS UD
        WHERE DP.DISEASE_ID = d.disease_id
        AND DP.PATIENT_ID = v_patient_id
        AND ud.user_id(+) = dp.doctor_id
    ) LOOP
        dbms_output.put_line('Disease'
                             || ' : '
                             || cur.disease_name);
        dbms_output.put_line('Date Diagnosed:'
                             || ' : '
                             || cur.date_diagnosed);
        dbms_output.put_line('Status'
                             || ' : '
                             || cur.ACTIVE);
        dbms_output.put_line('Reported By'
                             || ' : '
                             || cur.reported_by);                     
        dbms_output.put_line(' ------------------------------------------------------------------------- ');


        FOR CUR_VH IN (
            SELECT vh.visit_date,
                   VH.VISIT_ID,
                   vh.visit_notes,
                   ud.first_name || ' ' || ud.last_name ADMINISTERED_BY
            FROM visit_history VH, USER_DETAILS UD
            WHERE VH.DP_ID = cur.dp_id
            AND ud.user_id(+) = VH.DOCTOR_ID
            ORDER BY VH.VISIT_DATE, vh.visit_id
        ) LOOP
             dbms_output.put_line('Visit Date'
                             || ' : '
                             || CUR_VH.visit_date);
            dbms_output.put_line('Visit notes:'
                                 || ' : '
                                 || CUR_VH.visit_notes);
            dbms_output.put_line('Reported By:'
                                 || ' : '
                                 || CUR_VH.ADMINISTERED_BY); 

            dbms_output.put_line('*****MEDICINES PRESCRIBED*****');
            FOR CUR_PRES IN (
                select p.dosage,
                       p.frequency,
                       p.date_ended,
                       m.medicine_name,
                       p.notes
                from prescription p, medicines m 
                where p.visit_id = CUR_VH.VISIT_ID
                and p.medicine_id = m.medicine_id
            ) LOOP
                dbms_output.put_line('Medicine Name'
                             || ' : '
                             || CUR_PRES.medicine_name);
                dbms_output.put_line('Dosage'
                                     || ' : '
                                     || CUR_PRES.dosage);
                dbms_output.put_line('Frequency:'
                                     || ' : '
                                     || CUR_PRES.frequency); 
                dbms_output.put_line('End Date:'
                                     || ' : '
                                     || CUR_PRES.date_ended); 
                dbms_output.put_line('Notes:'
                                     || ' : '
                                     || CUR_PRES.notes); 


                dbms_output.put_line(' ****************************** ');                                         
            END LOOP;

            dbms_output.put_line(' ------------------------------------------------------------------------- ');

        END LOOP;




    END LOOP;
END;

/
--------------------------------------------------------
--  DDL for Procedure PR_INSERT_UPDATE_APP_ROLE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_INSERT_UPDATE_APP_ROLE" 
(
  ROLE_ID_INPUT IN NUMBER 
, ROLE_TYPE_INPUT IN app_role.role_type%TYPE 
, DATE_CREATE_INPUT IN app_role.date_created%TYPE  DEFAULT sysdate
, STATUS OUT VARCHAR2
) IS
  is_role_found NUMBER;
  is_invalid_role_id_ex EXCEPTION;
  is_invalid_user_id_ex EXCEPTION;
  is_not_alphabetic_ex EXCEPTION;
  is_too_long_ex EXCEPTION;
  dc_ex EXCEPTION;
BEGIN
  IF ROLE_ID_INPUT IS NULL THEN
    RAISE is_invalid_role_id_ex;
  END IF;
  
  IF ( DATE_CREATE_INPUT > sysdate ) THEN
    RAISE dc_ex;
  END IF;
  
  IF ROLE_TYPE_INPUT IS NULL OR LENGTH(TRIM(TRANSLATE(ROLE_TYPE_INPUT, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' ')))>0 THEN
    RAISE is_not_alphabetic_ex;
  END IF;
  
  IF LENGTH(ROLE_TYPE_INPUT)>100 THEN
    RAISE is_too_long_ex;
  END IF;
  
  is_role_found:=IS_DISEASE_EXIST(ROLE_ID_INPUT);
  
  IF is_role_found=1 THEN
    IF DATE_CREATE_INPUT IS NOT NULL THEN
        UPDATE APP_ROLE SET role_type=ROLE_TYPE_INPUT, date_created=DATE_CREATE_INPUT
        WHERE role_id=ROLE_ID_INPUT;
    ELSE
        UPDATE APP_ROLE SET role_type=ROLE_TYPE_INPUT
        WHERE role_id=ROLE_ID_INPUT;
    END IF;
    STATUS := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
  ELSE 
    IF DATE_CREATE_INPUT IS NOT NULL THEN
        INSERT INTO APP_ROLE(role_type,date_created)
        values(ROLE_TYPE_INPUT,DATE_CREATE_INPUT);
    ELSE
        INSERT INTO APP_ROLE(role_type,date_created)
        values(ROLE_TYPE_INPUT,sysdate); 
    END IF;
    STATUS := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
  END IF;
  COMMIT;
EXCEPTION
    WHEN is_invalid_role_id_ex THEN
        status := 'Role Id can not be null';
    WHEN is_not_alphabetic_ex THEN
        status := 'Name should only contain alphabets';
    WHEN is_too_long_ex THEN
        status := 'Name is more than 100 characters';
    WHEN dc_ex THEN
        status := 'date created can not be after current date';
    WHEN OTHERS THEN
        status := sqlerrm;
END PR_INSERT_UPDATE_APP_ROLE;

/
--------------------------------------------------------
--  DDL for Procedure PR_INSERT_UPDATE_USER_DETAILS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_INSERT_UPDATE_USER_DETAILS" (
    v_user_id       IN NUMBER,
    v_first_name    IN user_details.first_name%TYPE,
    v_last_name     IN user_details.last_name%TYPE,
    v_gender        IN user_details.gender%TYPE,
    v_date_of_birth IN user_details.date_of_birth%TYPE,
    v_weight        IN user_details.weight%TYPE,
    v_height        IN user_details.height%TYPE,
    v_zip_id        IN user_details.zip_id%TYPE,
    v_diet_id       IN user_details.diet_id%TYPE,
    v_ethnicity_id  IN user_details.ethnicity_id%TYPE,
    status        OUT VARCHAR2
) IS
    user_count NUMBER;
    dob_ex EXCEPTION;
    ZIP_ID_EX EXCEPTION;
    diet_id_EX EXCEPTION;
    ethnicity_id_EX EXCEPTION;

BEGIN

    IF ( v_date_of_birth > sysdate ) THEN
        RAISE dob_ex;
    END IF;

    IF ( is_zipcode_exist(v_ZIP_ID) < 1 ) THEN
        RAISE ZIP_ID_EX;
    END IF;

    IF ( is_ethnicity_exist(v_ETHNICITY_ID) < 1 ) THEN
        RAISE ethnicity_id_EX;
    END IF;

    IF ( is_diet_exist(v_diet_id) < 1 ) THEN
        RAISE diet_id_ex;
    END IF;

    IF (
        is_user_exist(v_user_id) > 0
    ) THEN
        UPDATE user_details
        SET
            first_name = v_first_name,
            last_name = v_last_name,
            gender = v_gender,
            date_of_birth = v_date_of_birth,
            weight = v_weight,
            height = v_height,
            zip_id = v_zip_id,
            diet_id = v_diet_id,
            ethnicity_id = v_ethnicity_id
        WHERE
            user_id = v_user_id;
        STATUS := 'SUCCESS: USER_ID - ' || v_user_id ||' UPDATED SUCCESSFULLY';
    ELSE
        INSERT INTO user_details (
            first_name,
            last_name,
            gender,
            date_of_birth,
            weight,
            height,
            zip_id,
            diet_id,
            ethnicity_id
        ) VALUES (
            v_first_name,
            v_last_name,
            v_gender,
            v_date_of_birth,
            v_weight,
            v_height,
            v_zip_id,
            v_diet_id,
            v_ethnicity_id
        );
    STATUS := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
    END IF;

COMMIT;

EXCEPTION
    WHEN dob_ex THEN
        status := 'ERROR: DATE OF BIRTH CANNOT BE IN FUTURE';
    WHEN ZIP_ID_EX THEN
        status := 'ERROR: Invalid Zip ID';
    WHEN diet_id_EX THEN
        status := 'ERROR: Invalid DIET ID';
    WHEN ethnicity_id_EX THEN
        status := 'ERROR: Invalid Ethnicity ID';
    WHEN OTHERS THEN
        status := 'ERROR: ' || sqlerrm;
END pr_insert_update_user_details;

/
--------------------------------------------------------
--  DDL for Procedure PR_INSERT_UPDATE_COUNTRY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_INSERT_UPDATE_COUNTRY" 
(
  COUNTRY_CODE_INPUT IN NUMBER 
, COUNTRY_NAME_INPUT IN country.country_name%TYPE 
, STATUS OUT VARCHAR2
) IS 
  is_found NUMBER;
  is_invalid_id_ex EXCEPTION;
  is_not_alphabetic_ex EXCEPTION;
  is_too_long_ex EXCEPTION;
BEGIN

  IF COUNTRY_CODE_INPUT IS NULL THEN
    RAISE is_invalid_id_ex;
  END IF;
  
  IF COUNTRY_NAME_INPUT IS NULL OR LENGTH(TRIM(TRANSLATE(COUNTRY_NAME_INPUT, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' ')))>0 THEN
    RAISE is_not_alphabetic_ex;
  END IF;
  
  IF LENGTH(COUNTRY_NAME_INPUT)>100 THEN
    RAISE is_too_long_ex;
  END IF;
  
  is_found:=IS_COUNTRY_EXIST(COUNTRY_CODE_INPUT);
  IF is_found=1 THEN
        UPDATE COUNTRY SET COUNTRY_NAME=COUNTRY_NAME_INPUT
        WHERE COUNTRY_CODE=COUNTRY_CODE_INPUT;
        STATUS := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
  ELSE 
        INSERT INTO COUNTRY(COUNTRY_CODE,COUNTRY_NAME)
        values(COUNTRY_CODE_INPUT,COUNTRY_NAME_INPUT);
        STATUS := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
  END IF;
  COMMIT;
EXCEPTION
    WHEN is_invalid_id_ex THEN
        status := 'Id can not be null';
    WHEN is_not_alphabetic_ex THEN
        status := 'Name should only contain alphabets';
    WHEN is_too_long_ex THEN
        status := 'Name is more than 100 characters';
    WHEN OTHERS THEN
        status := sqlerrm;
END PR_INSERT_UPDATE_COUNTRY;

/
--------------------------------------------------------
--  DDL for Procedure PR_INSERT_UPDATE_MEDICINE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_INSERT_UPDATE_MEDICINE" 
(
  MEDICINE_ID_INPUT IN NUMBER 
, MEDICINE_NAME_INPUT IN medicines.medicine_name%TYPE 
, STATUS OUT VARCHAR2
) IS 
  is_found NUMBER;
  is_invalid_id_ex EXCEPTION;
  is_not_alphanumeric_ex EXCEPTION;
  is_too_long_ex EXCEPTION;
BEGIN

  IF MEDICINE_ID_INPUT IS NULL THEN
    RAISE is_invalid_id_ex;
  END IF;
  
  IF MEDICINE_NAME_INPUT IS NULL OR LENGTH(TRIM(TRANSLATE(MEDICINE_NAME_INPUT, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+-.0123456789', ' ')))>0 THEN
    RAISE is_not_alphanumeric_ex;
  END IF;
  
  IF LENGTH(MEDICINE_NAME_INPUT)>100 THEN
    RAISE is_too_long_ex;
  END IF;
  
  is_found:=IS_MEDICINE_EXIST(MEDICINE_ID_INPUT);
  IF is_found=1 THEN
        UPDATE MEDICINES SET medicine_name=MEDICINE_NAME_INPUT
        WHERE medicine_id=MEDICINE_ID_INPUT;
        STATUS := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
  ELSE 
        INSERT INTO medicines(medicine_id,medicine_name)
        values(MEDICINE_ID_INPUT,MEDICINE_NAME_INPUT);
        STATUS := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
  END IF;
  COMMIT;
EXCEPTION
    WHEN is_invalid_id_ex THEN
        status := 'Id can not be null';
    WHEN is_not_alphanumeric_ex THEN
        status := 'Name should only contain alphanumeric';
    WHEN is_too_long_ex THEN
        status := 'Name is more than 100 characters';
    WHEN OTHERS THEN
        status := sqlerrm;
END PR_INSERT_UPDATE_MEDICINE;

/
--------------------------------------------------------
--  DDL for Procedure PR_INSERT_SYMPTOM_PATIENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_INSERT_SYMPTOM_PATIENT" (
    v_symptom_id IN symptom_patient.symptom_id%TYPE,
    v_patient_id IN symptom_patient.patient_id%TYPE,
    v_notes      IN symptom_patient.notes%TYPE,
    status     OUT VARCHAR2
) IS
    symptom_id_ex EXCEPTION;
    patient_id_ex EXCEPTION;
    pre_exist_count NUMBER;
BEGIN
    IF ( is_symptom_exist(v_symptom_id) < 1 ) THEN
        RAISE symptom_id_ex;
    END IF;
    IF ( is_user_exist(v_patient_id) < 1 ) THEN
        RAISE patient_id_ex;
    END IF;

    SELECT
        COUNT(1)
    INTO pre_exist_count
    FROM
        symptom_patient
    WHERE
            symptom_id = v_symptom_id
        AND patient_id = v_patient_id;
    IF ( pre_exist_count > 0 ) THEN
        UPDATE symptom_patient set is_active = 'Y', notes = V_notes where symptom_id = v_symptom_id
        AND patient_id = v_patient_id;
        status  := 'Success: Previously existing record updated';
    ELSE
    INSERT INTO symptom_patient (
        SYmptom_id,
        patient_id,
        notes
    ) VALUES (
        v_symptom_id,
        v_patient_id,
        V_notes
    );
    end if;

    COMMIT;
EXCEPTION
    WHEN symptom_id_ex THEN
        status := 'ERROR: Invalid Symptom ID';
    WHEN patient_id_ex THEN
        status := 'ERROR: Invalid Patient ID';
    WHEN OTHERS THEN
        status := 'ERROR: ' || sqlerrm;
END pr_insert_symptom_patient;

/
--------------------------------------------------------
--  DDL for Procedure PR_PATIENT_PRESCRIPTION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_PATIENT_PRESCRIPTION" (
    v_patient_id IN user_details.user_id%TYPE,
    status       OUT VARCHAR2
) IS
    patient_id_ex EXCEPTION;
    show_data SYS_REFCURSOR;
BEGIN
    IF ( is_user_exist(v_patient_id) < 1 ) THEN
        RAISE patient_id_ex;
    END IF;
    dbms_output.put_line('=====================================================================');
    dbms_output.put_line('======================== PATIENT PRESCRIPTION REPORT ================');
    dbms_output.put_line('=====================================================================');

--- BASIC DETAILS
    dbms_output.put_line(' ========================= PERSONAL DETAILS ============================== ');
    FOR cur IN (
        SELECT
            user_id,
            first_name,
            last_name,
            gender,
            floor(months_between(trunc(sysdate), date_of_birth) / 12) AS age,
            height,
            weight,
            z.city                                                    city,
            z.state_name                                              state
        FROM
            user_details ud,
            ethnicity    e,
            zipcode      z
        WHERE
                user_id = v_patient_id
            AND ud.ethnicity_id = e.ethnicity_id
            AND ud.zip_id = z.zip_id
    ) LOOP
        dbms_output.put_line('user_ID'
                             || ' : '
                             || cur.user_id);
        dbms_output.put_line('first_name'
                             || ' : '
                             || cur.first_name);
        dbms_output.put_line('last_name'
                             || ' : '
                             || cur.last_name);
        dbms_output.put_line('gender'
                             || ' : '
                             || cur.gender);
        dbms_output.put_line('age'
                             || ' : '
                             || cur.age);
        dbms_output.put_line('height'
                             || ' : '
                             || cur.height);
        dbms_output.put_line('weight'
                             || ' : '
                             || cur.weight);
        dbms_output.put_line('city'
                             || ' : '
                             || cur.city);
        dbms_output.put_line('state'
                             || ' : '
                             || cur.state);
        dbms_output.put_line(' =========================================================================== ');
    END LOOP;

        -- PRESCRIPTION
    dbms_output.put_line(' ========================= PRESCRIPTIONS ============================== ');
    FOR cur IN (
        select * from (select j.visit_id, j.disease_id, d.disease_name from (select vh.visit_id, dp.disease_id from disease_patient dp left join visit_history vh on dp.dp_id = vh.dp_id where dp.patient_id = v_patient_id ) j, diseases d where d.disease_id = j.disease_id ) t left join prescription p on p.visit_id = t.visit_id left join medicines m on m.medicine_id = p.medicine_id where p.visit_id is not null
    ) LOOP
        dbms_output.put_line('date_created'
                             || ' : '
                             || cur.date_created);
         dbms_output.put_line('disease'
                             || ' : '
                             || cur.disease_name);   
        dbms_output.put_line('medicine'
                             || ' : '
                             || cur.medicine_name);                    
        dbms_output.put_line('dosage'
                             || ' : '
                             || cur.dosage);
        dbms_output.put_line('frequency'
                             || ' : '
                             || cur.frequency);
        dbms_output.put_line('notes'
                             || ' : '
                             || cur.notes);
        
        dbms_output.put_line(' =========================================================================== ');
    END LOOP;


    
EXCEPTION
    WHEN patient_id_ex THEN
        status := 'ERROR: Invalid Patient ID';
    WHEN OTHERS THEN
        status := 'ERROR: ' || sqlerrm;
END pr_patient_prescription;

/
--------------------------------------------------------
--  DDL for Procedure PR_INSERT_UPDATE_ZIP_CODE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_INSERT_UPDATE_ZIP_CODE" 
(
  ZIP_ID_INPUT IN NUMBER 
, ZIP_CODE_INPUT IN zipcode.zip_code%TYPE 
, COUNTY_INPUT IN zipcode.county%TYPE 
, CITY_INPUT IN zipcode.city%TYPE 
, STATE_INPUT IN zipcode.state_name%TYPE 
, COUNTRY_INPUT IN zipcode.country_code%TYPE 
, STATUS OUT VARCHAR2 
)  IS
  is_zip_found NUMBER;
  is_country_found NUMBER;
  is_invalid_zip_id_ex EXCEPTION;
  is_invalid_zip_code_ex EXCEPTION;
  is_too_long_county_ex EXCEPTION;
  is_too_long_city_ex EXCEPTION;
  is_too_long_state_ex EXCEPTION;
  is_not_alphabetic_county_ex EXCEPTION;
  is_not_alphabetic_city_ex EXCEPTION;
  is_not_alphabetic_state_ex EXCEPTION;
  is_invalid_country_ex EXCEPTION;
BEGIN
  IF ZIP_ID_INPUT IS NULL THEN
    RAISE is_invalid_zip_id_ex;
  END IF;
  
  IF ZIP_CODE_INPUT IS NULL THEN
    RAISE is_invalid_zip_code_ex;
  END IF;

  IF COUNTRY_INPUT IS NULL THEN
    RAISE is_invalid_country_ex;
  END IF;
  
  IF COUNTY_INPUT IS NULL OR LENGTH(TRIM(TRANSLATE(COUNTY_INPUT, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' ')))>0 THEN
    RAISE is_not_alphabetic_county_ex;
  END IF;
  
  IF CITY_INPUT IS NULL OR LENGTH(TRIM(TRANSLATE(CITY_INPUT, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' ')))>0 THEN
    RAISE is_not_alphabetic_city_ex;
  END IF;
  
  IF STATE_INPUT IS NULL OR LENGTH(TRIM(TRANSLATE(STATE_INPUT, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' ')))>0 THEN
    RAISE is_not_alphabetic_state_ex;
  END IF;
     
  IF LENGTH(COUNTY_INPUT)>200 THEN
    RAISE is_too_long_county_ex;
  END IF;
     
  IF LENGTH(CITY_INPUT)>200 THEN
    RAISE is_too_long_city_ex;
  END IF;
       
  IF LENGTH(STATE_INPUT)>200 THEN
    RAISE is_too_long_state_ex;
  END IF;
    
  is_zip_found:=IS_ZIPCODE_EXIST(ZIP_ID_INPUT);
  is_country_found:=IS_COUNTRY_EXIST(COUNTRY_INPUT);
  
  IF is_country_found=0 THEN
    RAISE is_invalid_country_ex;
  END IF;

  IF is_zip_found=1 THEN
        UPDATE zipcode SET zip_code=ZIP_CODE_INPUT,county=COUNTY_INPUT, city=CITY_INPUT,state_name=STATE_INPUT,country_code=COUNTRY_INPUT
        WHERE zip_id=ZIP_ID_INPUT;
        STATUS := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
  ELSE 
        INSERT INTO ZIPCODE(zip_code,county, city,state_name,country_code)
        values(ZIP_CODE_INPUT,COUNTY_INPUT,CITY_INPUT,STATE_INPUT,COUNTRY_INPUT);
        STATUS := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
  END IF;
  COMMIT;
EXCEPTION
    WHEN is_invalid_zip_id_ex THEN
        status := 'Zip id can not be null';
    WHEN is_invalid_zip_code_ex THEN
        status := 'Zip code can not be null';
    WHEN is_invalid_country_ex THEN
        status := 'Country does not exist with this id';
    WHEN is_not_alphabetic_county_ex THEN
        status := 'County should only contain alphabets';
    WHEN is_not_alphabetic_city_ex THEN
        status := 'City should only contain alphabets';
    WHEN is_not_alphabetic_state_ex THEN
        status := 'State should only contain alphabets';
    WHEN is_too_long_county_ex THEN
        status := 'County is more than 200 characters';
    WHEN is_too_long_city_ex THEN
        status := 'City is more than 200 characters';
    WHEN is_too_long_state_ex THEN
        status := 'State is more than 200 characters';
    WHEN OTHERS THEN
        status := sqlerrm;
END PR_INSERT_UPDATE_ZIP_CODE;

/
--------------------------------------------------------
--  DDL for Procedure PR_INSERT_UPDATE_HABIT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_INSERT_UPDATE_HABIT" 
(
  HABIT_ID_INPUT IN NUMBER 
, HABIT_NAME_INPUT IN habit.habit_name%TYPE 
, STATUS OUT VARCHAR2
) IS 
  is_found NUMBER;
  is_invalid_id_ex EXCEPTION;
  is_not_alphabetic_ex EXCEPTION;
  is_too_long_ex EXCEPTION;
BEGIN

  IF HABIT_ID_INPUT IS NULL THEN
    RAISE is_invalid_id_ex;
  END IF;
  
  IF HABIT_NAME_INPUT IS NULL OR LENGTH(TRIM(TRANSLATE(HABIT_NAME_INPUT, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' ')))>0 THEN
    RAISE is_not_alphabetic_ex;
  END IF;
  
  IF LENGTH(HABIT_NAME_INPUT)>100 THEN
    RAISE is_too_long_ex;
  END IF;
  
  is_found:=IS_HABIT_EXIST(HABIT_ID_INPUT);
  IF is_found=1 THEN
        UPDATE HABIT SET habit_name=HABIT_NAME_INPUT
        WHERE habit_id=HABIT_ID_INPUT;
        STATUS := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
  ELSE 
        INSERT INTO habit(habit_name)
        values(HABIT_NAME_INPUT);
        STATUS := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
  END IF;
  COMMIT;
EXCEPTION
    WHEN is_invalid_id_ex THEN
        status := 'Id can not be null';
    WHEN is_not_alphabetic_ex THEN
        status := 'Name should only contain alphabets';
    WHEN is_too_long_ex THEN
        status := 'Name is more than 100 characters';
    WHEN OTHERS THEN
        status := sqlerrm;
END PR_INSERT_UPDATE_HABIT;

/
--------------------------------------------------------
--  DDL for Procedure TEMP_INSERT_INTO_TABLE_USER_APP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "TEMP_INSERT_INTO_TABLE_USER_APP" IS
status varchar2(2000);
BEGIN
 FOR cur IN (select user_id, 'P_'||user_id as USER_NAME  from user_details) LOOP
        pk_app_admin.pr_insert_update_app_user(cur.user_id, 1, cur.user_name, cur.user_name, status);
        DBMS_OUTPUT.PUT_LINE(status);
    END LOOP;
END;

/
--------------------------------------------------------
--  DDL for Procedure PR_INSERT_UPDATE_DISEASE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_INSERT_UPDATE_DISEASE" 
(
  DISEASE_ID_INPUT IN NUMBER 
, DISEASE_NAME_INPUT IN diseases.disease_name%TYPE 
, IS_CHRONIC_INPUT IN diseases.is_chronic%TYPE DEFAULT 'FALSE'
, IS_HEREDITARY_INPUT IN diseases.is_hereditary%TYPE DEFAULT 'FALSE'
, IS_TERMINAL_INPUT IN diseases.is_terminal%TYPE DEFAULT 'FALSE'
, STATUS OUT VARCHAR2 
)  IS
  is_disease_found NUMBER;
  is_invalid_disease_id_ex EXCEPTION;
  is_not_alphanumeric_ex EXCEPTION;
  is_too_long_ex EXCEPTION;
  is_invalid_chronic_ex EXCEPTION;
  is_invalid_hereditary_ex EXCEPTION;
  is_invalid_terminal_ex EXCEPTION;
BEGIN
  IF DISEASE_ID_INPUT IS NULL THEN
    RAISE is_invalid_disease_id_ex;
  END IF;
  
  IF DISEASE_NAME_INPUT IS NULL OR LENGTH(TRIM(TRANSLATE(DISEASE_NAME_INPUT, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+-.0123456789', ' ')))>0 THEN
    RAISE is_not_alphanumeric_ex;
  END IF;
  
  IF LENGTH(DISEASE_NAME_INPUT)>100 THEN
    RAISE is_too_long_ex;
  END IF;
  
  IF IS_CHRONIC_INPUT NOT IN ('TRUE','FALSE') THEN
    RAISE is_invalid_chronic_ex;
  END IF;
  
  IF IS_HEREDITARY_INPUT NOT IN ('TRUE','FALSE') THEN
    RAISE is_invalid_hereditary_ex;
  END IF;

  IF IS_TERMINAL_INPUT NOT IN ('TRUE','FALSE') THEN
    RAISE is_invalid_terminal_ex;
  END IF;
  
  is_disease_found:=IS_DISEASE_EXIST(DISEASE_ID_INPUT);

  IF is_disease_found=1 THEN
    IF IS_CHRONIC_INPUT IS NOT NULL AND IS_HEREDITARY_INPUT IS NOT NULL AND IS_TERMINAL_INPUT IS NOT NULL THEN
        UPDATE DISEASES SET disease_name=UPPER(DISEASE_NAME_INPUT),is_chronic=UPPER(IS_CHRONIC_INPUT), is_hereditary=UPPER(IS_HEREDITARY_INPUT),is_terminal=UPPER(IS_TERMINAL_INPUT)
        WHERE disease_id=DISEASE_ID_INPUT;
    ELSIF IS_CHRONIC_INPUT IS NULL AND IS_HEREDITARY_INPUT IS NOT NULL AND IS_TERMINAL_INPUT IS NOT NULL THEN
        UPDATE DISEASES SET disease_name=UPPER(DISEASE_NAME_INPUT),is_hereditary=UPPER(IS_HEREDITARY_INPUT),is_terminal=UPPER(IS_TERMINAL_INPUT)
        WHERE disease_id=DISEASE_ID_INPUT;
    ELSIF IS_CHRONIC_INPUT IS NOT NULL AND IS_HEREDITARY_INPUT IS NULL AND IS_TERMINAL_INPUT IS NOT NULL THEN
        UPDATE DISEASES SET disease_name=UPPER(DISEASE_NAME_INPUT),is_chronic=UPPER(IS_CHRONIC_INPUT),is_terminal=UPPER(IS_TERMINAL_INPUT)
        WHERE disease_id=DISEASE_ID_INPUT;
    ELSIF IS_CHRONIC_INPUT IS NOT NULL AND IS_HEREDITARY_INPUT IS NOT NULL AND IS_TERMINAL_INPUT IS NULL THEN
        UPDATE DISEASES SET disease_name=UPPER(DISEASE_NAME_INPUT),is_chronic=UPPER(IS_CHRONIC_INPUT), is_hereditary=UPPER(IS_HEREDITARY_INPUT)
        WHERE disease_id=DISEASE_ID_INPUT;
    ELSIF IS_CHRONIC_INPUT IS NULL AND IS_HEREDITARY_INPUT IS NULL AND IS_TERMINAL_INPUT IS NOT NULL THEN
        UPDATE DISEASES SET disease_name=UPPER(DISEASE_NAME_INPUT),is_terminal=UPPER(IS_TERMINAL_INPUT)
        WHERE disease_id=DISEASE_ID_INPUT;
    ELSIF IS_CHRONIC_INPUT IS NOT NULL AND IS_HEREDITARY_INPUT IS NULL AND IS_TERMINAL_INPUT IS  NULL THEN
        UPDATE DISEASES SET disease_name=UPPER(DISEASE_NAME_INPUT),is_chronic=UPPER(IS_CHRONIC_INPUT)
        WHERE disease_id=DISEASE_ID_INPUT;
    ELSIF IS_CHRONIC_INPUT IS NULL AND IS_HEREDITARY_INPUT IS NOT NULL AND IS_TERMINAL_INPUT IS NULL THEN
        UPDATE DISEASES SET disease_name=UPPER(DISEASE_NAME_INPUT),is_hereditary=UPPER(IS_HEREDITARY_INPUT)
        WHERE disease_id=DISEASE_ID_INPUT;
    ELSE
        UPDATE DISEASES SET disease_name=UPPER(DISEASE_NAME_INPUT)
        WHERE disease_id=DISEASE_ID_INPUT;
    END IF;
    STATUS := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
  ELSE 
    IF IS_CHRONIC_INPUT IS NOT NULL AND IS_HEREDITARY_INPUT IS NOT NULL AND IS_TERMINAL_INPUT IS NOT NULL THEN
        INSERT INTO DISEASES(disease_name,is_chronic, is_hereditary, is_terminal)
        values(DISEASE_NAME_INPUT,UPPER(IS_CHRONIC_INPUT),UPPER(IS_HEREDITARY_INPUT),UPPER(IS_TERMINAL_INPUT));
    ELSIF IS_CHRONIC_INPUT IS NULL AND IS_HEREDITARY_INPUT IS NOT NULL AND IS_TERMINAL_INPUT IS NOT NULL THEN
        INSERT INTO DISEASES(disease_name,is_chronic, is_hereditary, is_terminal)
        values(DISEASE_NAME_INPUT,'FALSE',UPPER(IS_HEREDITARY_INPUT),UPPER(IS_TERMINAL_INPUT));
    ELSIF IS_CHRONIC_INPUT IS NOT NULL AND IS_HEREDITARY_INPUT IS NULL AND IS_TERMINAL_INPUT IS NOT NULL THEN
        INSERT INTO DISEASES(disease_name,is_chronic, is_hereditary, is_terminal)
        values(DISEASE_NAME_INPUT,UPPER(IS_CHRONIC_INPUT),'FALSE',UPPER(IS_TERMINAL_INPUT));
    ELSIF IS_CHRONIC_INPUT IS NOT NULL AND IS_HEREDITARY_INPUT IS NOT NULL AND IS_TERMINAL_INPUT IS NULL THEN
        INSERT INTO DISEASES(disease_name,is_chronic, is_hereditary, is_terminal)
        values(DISEASE_NAME_INPUT,UPPER(IS_CHRONIC_INPUT),UPPER(IS_HEREDITARY_INPUT),'FALSE');
    ELSIF IS_CHRONIC_INPUT IS NULL AND IS_HEREDITARY_INPUT IS NULL AND IS_TERMINAL_INPUT IS NOT NULL THEN
        INSERT INTO DISEASES(disease_name,is_chronic, is_hereditary, is_terminal)
        values(DISEASE_NAME_INPUT,'FALSE','FALSE',UPPER(IS_TERMINAL_INPUT));
    ELSIF IS_CHRONIC_INPUT IS NOT NULL AND IS_HEREDITARY_INPUT IS NULL AND IS_TERMINAL_INPUT IS  NULL THEN
        INSERT INTO DISEASES(disease_name,is_chronic, is_hereditary, is_terminal)
        values(DISEASE_NAME_INPUT,UPPER(IS_CHRONIC_INPUT),'FALSE','FALSE');
    ELSIF IS_CHRONIC_INPUT IS NULL AND IS_HEREDITARY_INPUT IS NOT NULL AND IS_TERMINAL_INPUT IS NULL THEN
        INSERT INTO DISEASES(disease_name,is_chronic, is_hereditary, is_terminal)
        values(DISEASE_NAME_INPUT,'FALSE',UPPER(IS_HEREDITARY_INPUT),'FALSE');
    ELSE
        INSERT INTO DISEASES(disease_name,is_chronic, is_hereditary, is_terminal)
        values(DISEASE_NAME_INPUT,'FALSE','FALSE','FALSE');
    END IF;
    STATUS := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
  END IF;
  COMMIT;
EXCEPTION
    WHEN is_invalid_disease_id_ex THEN
        status := 'Disease with this Id does not exist';
    WHEN is_not_alphanumeric_ex THEN
        status := 'Name should only contain alphabets';
    WHEN is_too_long_ex THEN
        status := 'Name is more than 100 characters';
    WHEN is_invalid_chronic_ex THEN
        status := 'Chronic can only be TRUE or FALSE';
    WHEN is_invalid_hereditary_ex THEN
        status := 'Hereditary can only be TRUE or FALSE';
    WHEN is_invalid_terminal_ex THEN
        status := 'Terminal can only be TRUE or FALSE';
    WHEN OTHERS THEN
        status := sqlerrm;
END PR_INSERT_UPDATE_DISEASE;

/
--------------------------------------------------------
--  DDL for Procedure PR_UPDATE_CURED_DISEASE_PATIENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_UPDATE_CURED_DISEASE_PATIENT" (
    DP_ID_IN IN disease_patient.dp_id%TYPE,
    DOCTOR_ID_IN IN disease_patient.doctor_id%TYPE,
    PATIENT_ID_IN IN disease_patient.patient_id%TYPE,
    STATUS OUT VARCHAR2,
    MESSAGE OUT VARCHAR2
)
IS
    PATIENT_NOT_FOUND EXCEPTION;
    DOCTOR_NOT_FOUND EXCEPTION;
    RECORD_NOT_FOUND EXCEPTION;
    DP_ID_NULL_EXCEPTION EXCEPTION;
BEGIN

    IF(IS_USER_EXIST(PATIENT_ID_IN) = 0) THEN
        RAISE PATIENT_NOT_FOUND;
    END IF;

    IF(IS_USER_EXIST(DOCTOR_ID_IN) = 0) THEN
        RAISE DOCTOR_NOT_FOUND;
    END IF;

    IF(DP_ID_IN IS NULL) THEN
        RAISE DP_ID_NULL_EXCEPTION;
    ELSE
        UPDATE DISEASE_PATIENT DP
        SET dp.is_active = 'N'
        WHERE DP.DP_ID = DP_ID_IN
        AND DP.DOCTOR_ID = DOCTOR_ID_IN
        AND dp.patient_id = PATIENT_ID_IN;

        IF(SQL%ROWCOUNT = 0) THEN
            RAISE RECORD_NOT_FOUND;
        END IF;

        MESSAGE := 'Disease record successfully updated';
    END IF;

    COMMIT;

    STATUS := 'S';

EXCEPTION
     WHEN DOCTOR_NOT_FOUND THEN
        STATUS := 'F';
        MESSAGE := 'Doctor records not found in the database';
    WHEN PATIENT_NOT_FOUND THEN
        STATUS := 'F';
        MESSAGE := 'Patient records not found in the database';
    WHEN DP_ID_NULL_EXCEPTION THEN
        STATUS := 'F';
        MESSAGE := 'DP ID cannot be null';
    WHEN OTHERS THEN
        STATUS := 'F';
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        MESSAGE := 'Something went wrong';          

END;

/
--------------------------------------------------------
--  DDL for Procedure PR_VIEW_PATIENT_HABITS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_VIEW_PATIENT_HABITS" (
    v_patient_id IN user_details.user_id%TYPE
) IS
BEGIN
        -- PATIENT HABBITS
    dbms_output.put_line(' ========================= Habbits ============================== ');
    FOR cur IN (
        SELECT
            h.habit_name,
            hp.frequency_per_week,
            hp.notes
        FROM
            user_details   ud,
            habits_patient hp,
            habit          h
        WHERE
                ud.user_id = hp.patient_id
            AND hp.habit_id = h.habit_id
            AND hp.is_active = 'Y'
            AND ud.user_id = v_patient_id
    ) LOOP
        dbms_output.put_line('habit_name'
                             || ' : '
                             || cur.habit_name);
        dbms_output.put_line('frequency_per_week'
                             || ' : '
                             || cur.frequency_per_week);
        dbms_output.put_line('notes'
                             || ' : '
                             || cur.notes);
        dbms_output.put_line(' =========================================================================== ');
    END LOOP;
END;

/
--------------------------------------------------------
--  DDL for Procedure PR_INSERT_FAMILY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_INSERT_FAMILY" (
    v_patient_id IN family.patient_id%TYPE,
    v_relative_id IN family.relative_id%TYPE,
    status     OUT VARCHAR2
) IS
    relative_id_ex EXCEPTION;
    patient_id_ex EXCEPTION;
    self_ex exception;
    pre_exist_count NUMBER;
BEGIN
    IF ( is_user_exist(v_relative_id) < 1 ) THEN
        RAISE relative_id_ex;
    END IF;
    IF ( is_user_exist(v_patient_id) < 1 ) THEN
        RAISE patient_id_ex;
    END IF;

    IF(v_patient_id = v_relative_id) then
            RAISE self_ex;
end if;

    SELECT
        COUNT(1)
    INTO pre_exist_count
    FROM
        family
    WHERE
            (relative_id = v_relative_id
        AND patient_id = v_patient_id) OR (relative_id = v_patient_id
        AND patient_id = v_relative_id);
    IF ( pre_exist_count > 0 ) THEN
        status  := 'Error: Relation already exists';
    ELSE
    INSERT INTO family (
        patient_id,
        relative_id
    ) VALUES (
        v_patient_id,
        v_relative_id
    );
    end if;

    COMMIT;
EXCEPTION
    WHEN relative_id_ex THEN
        status := 'ERROR: Invalid Relative ID';
    WHEN patient_id_ex THEN
        status := 'ERROR: Invalid Patient ID';
    when self_ex then status := 'ERROR: Patient id and relative id cannot be same';
    WHEN OTHERS THEN
        status := 'ERROR: ' || sqlerrm;
END pr_insert_family;

/
--------------------------------------------------------
--  DDL for Procedure TEMP_PATIENT_RELATION_DATA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "TEMP_PATIENT_RELATION_DATA" 
 IS
    CURSOR C_PATIENT_DISEASES IS
    SELECT * FROM disease_patient DP WHERE dp.disease_id IN
        (SELECT d.disease_id FROM diseases D WHERE d.is_hereditary = 'TRUE');

    R_DISEASE_PATIENT DISEASE_PATIENT%ROWTYPE;
    RELATIVE_ID user_details.user_id%TYPE;
    R_COUNT NUMBER;

BEGIN
    OPEN C_PATIENT_DISEASES;
    LOOP
    FETCH C_PATIENT_DISEASES INTO R_DISEASE_PATIENT;
        EXIT WHEN C_PATIENT_DISEASES%NOTFOUND;

        BEGIN
            SELECT COUNT(*) INTO R_COUNT FROM
            (SELECT PATIENT_ID FROM FAMILY F1 WHERE F1.PATIENT_ID = R_DISEASE_PATIENT.PATIENT_ID
                UNION ALL
            SELECT RELATIVE_ID FROM FAMILY F2 WHERE F2.RELATIVE_ID = r_disease_patient.patient_id);

            IF(R_COUNT = 0) THEN
                BEGIN
                SELECT PATIENT_ID INTO RELATIVE_ID FROM
                (SELECT dp.patient_id AS PATIENT_ID FROM disease_patient DP WHERE dp.disease_id = R_DISEASE_PATIENT.DISEASE_ID
                MINUS (
                    SELECT PATIENT_ID FROM FAMILY
                    UNION ALL
                    SELECT RELATIVE_ID FROM FAMILY
                    UNION ALL
                    SELECT R_DISEASE_PATIENT.PATIENT_ID FROM DUAL
                ))
                WHERE ROWNUM = 1;

                INSERT INTO FAMILY VALUES (R_DISEASE_PATIENT.PATIENT_ID, RELATIVE_ID);

                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        DBMS_OUTPUT.PUT_LINE('NO DATA FOUND IN QUERY');
                END;

            END IF;                
        END;

    END LOOP;

    COMMIT;

    CLOSE C_PATIENT_DISEASES;
END;

/
--------------------------------------------------------
--  DDL for Procedure PR_INSERT_HABIT_PATIENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PR_INSERT_HABIT_PATIENT" (
    v_habit_id IN habits_patient.habit_id%TYPE,
    v_patient_id IN habits_patient.patient_id%TYPE,
    V_frequency_per_week  IN habits_patient.frequency_per_week%TYPE,
    V_notes      IN habits_patient.notes%TYPE,
    status     OUT VARCHAR2
) IS
    habit_id_ex EXCEPTION;
    patient_id_ex EXCEPTION;
    Frequency_Less_than_one_ex EXCEPTION;
    pre_exist_count NUMBER;
BEGIN
    IF ( is_habit_exist(v_habit_id) < 1 ) THEN
        RAISE habit_id_ex;
    END IF;
    IF ( is_user_exist(v_patient_id) < 1 ) THEN
        RAISE patient_id_ex;
    END IF;
    IF ( V_frequency_per_week < 1 ) THEN
        RAISE Frequency_Less_than_one_ex;
    END IF;
    SELECT
        COUNT(1)
    INTO pre_exist_count
    FROM
        habits_patient
    WHERE
            habit_id = v_habit_id
        AND patient_id = v_patient_id;

    IF ( pre_exist_count > 0 ) THEN
        UPDATE habits_patient set frequency_per_week = V_frequency_per_week, is_active = 'Y', notes = V_notes where habit_id = v_habit_id
        AND patient_id = v_patient_id;
        status  := 'Success: Previously existing record updated';
    ELSE
    INSERT INTO habits_patient (
        habit_id,
        patient_id,
        frequency_per_week,
        notes
    ) VALUES (
        v_habit_id,
        v_patient_id,
        V_frequency_per_week,
        V_notes
    );
    status  := 'Success: New record inserted';
 END IF;
    COMMIT;
EXCEPTION
    WHEN habit_id_ex THEN
        status := 'ERROR: Invalid Habit ID';
    WHEN patient_id_ex THEN
        status := 'ERROR: Invalid Patient ID';
    WHEN Frequency_Less_than_one_ex THEN
        status := 'ERROR: Frequency cannot be less than 1';
    WHEN OTHERS THEN
        status := 'ERROR: ' || sqlerrm;
END pr_insert_habit_patient;

/

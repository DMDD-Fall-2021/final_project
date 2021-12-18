--------------------------------------------------------
--  File created - Saturday-December-18-2021   
--------------------------------------------------------
DROP PACKAGE "PK_DOCTOR";
DROP PACKAGE "PK_APP_ADMIN";
DROP PACKAGE "PK_AUTHENTICATION";
DROP PACKAGE "PK_PATIENT";
DROP PACKAGE BODY "PK_APP_ADMIN";
DROP PACKAGE BODY "PK_AUTHENTICATION";
DROP PACKAGE BODY "PK_DOCTOR";
DROP PACKAGE BODY "PK_PATIENT";
--------------------------------------------------------
--  DDL for Package PK_DOCTOR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_DOCTOR" AS

    PROCEDURE PR_ADD_UPDATE_VISIT_HISTORY  (
        VISIT_ID_IN IN visit_history.visit_id%TYPE,
        DP_ID_IN IN visit_history.dp_id%TYPE,
        DOCTOR_ID_IN IN visit_history.doctor_id%TYPE,
        VISIT_NOTES_IN IN visit_history.visit_notes%TYPE,
        PASSWORD_IN IN varchar2,
        STATUS OUT VARCHAR2,
        MESSAGE OUT VARCHAR2
    );

    PROCEDURE PR_DELETE_VISIT_HISTORY (
        DOCTOR_ID_IN IN visit_history.doctor_id%TYPE,
        VISIT_ID_IN IN visit_history.visit_id%TYPE,
        PASSWORD_IN IN varchar2,
        STATUS OUT VARCHAR2,
        MESSAGE OUT VARCHAR2
    );

    PROCEDURE PR_ADD_VACCINE_RECORD  (
        VACCINE_ID_IN vaccine_patient.vaccine_id%TYPE,
        PATIENT_ID_IN vaccine_patient.patient_id%TYPE,
        DOCTOR_ID_IN  vaccine_patient.doctor_id%TYPE,
        PASSWORD_IN IN varchar2,
        STATUS OUT VARCHAR2,
        MESSAGE OUT VARCHAR2
    );

    PROCEDURE PR_DELETE_VACCINE_RECORD (
        VACCINE_ID_IN vaccine_patient.vaccine_id%TYPE,
        PATIENT_ID_IN vaccine_patient.patient_id%TYPE,
        DOCTOR_ID_IN  vaccine_patient.doctor_id%TYPE,
        PASSWORD_IN IN varchar2,
        STATUS OUT VARCHAR2,
        MESSAGE OUT VARCHAR2
    );

    PROCEDURE PR_ADD_UPDATE_PRESCRIPTION (
        P_ID_IN IN PRESCRIPTION.P_ID%TYPE,
        VISIT_ID_IN IN prescription.visit_id%TYPE,
        DOCTOR_ID_IN IN PRESCRIPTION.DOCTOR_ID%TYPE,
        PATIENT_ID_IN IN PRESCRIPTION.PATIENT_ID%TYPE,
        MEDICINE_ID_IN IN prescription.medicine_id%TYPE,
        DOSAGE_IN IN prescription.dosage%TYPE,
        FREQUENCY_IN IN prescription.frequency%TYPE,
        END_DATE_IN IN PRESCRIPTION.DATE_ENDED%TYPE,
        NOTES_IN IN PRESCRIPTION.NOTES%TYPE,
        PASSWORD_IN IN varchar2,
        STATUS OUT VARCHAR2,
        MESSAGE OUT VARCHAR2
    );

    PROCEDURE PR_DELETE_PRESCRIPTION_RECORD (
        P_ID_IN prescription.p_id%TYPE,
        DOCTOR_ID_IN  PRESCRIPTION.doctor_id%TYPE,
        PASSWORD_IN IN varchar2,
        STATUS OUT VARCHAR2,
        MESSAGE OUT VARCHAR2
    );

    PROCEDURE PR_ADD_UPDATE_DISEASE_PATIENT (
        DP_ID_IN IN disease_patient.dp_id%TYPE,
        DOCTOR_ID_IN IN disease_patient.doctor_id%TYPE,
        DISEASE_ID_IN IN disease_patient.disease_id%TYPE,
        PATIENT_ID_IN IN disease_patient.patient_id%TYPE,
        PASSWORD_IN IN varchar2,
        STATUS OUT VARCHAR2,
        MESSAGE OUT VARCHAR2
    );

    PROCEDURE PR_UPDATE_CURED_DISEASE_PATIENT (
        DP_ID_IN IN disease_patient.dp_id%TYPE,
        DOCTOR_ID_IN IN disease_patient.doctor_id%TYPE,
        PATIENT_ID_IN IN disease_patient.patient_id%TYPE,
        PASSWORD_IN IN varchar2,
        STATUS OUT VARCHAR2,
        MESSAGE OUT VARCHAR2
    );

    PROCEDURE VIEW_PATIENT_DETAILS (
        DOCTOR_ID_IN IN NUMBER,
        PATIENT_ID_IN IN NUMBER,
        PASSWORD_IN IN varchar2,
        STATUS OUT VARCHAR2,
        MESSAGE OUT VARCHAR2
    );

END PK_DOCTOR;

/
--------------------------------------------------------
--  DDL for Package PK_APP_ADMIN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_APP_ADMIN" AS
    PROCEDURE pr_insert_update_allergy (
        u_name_in          IN VARCHAR2,
        allergy_id_input   IN NUMBER,
        allergy_name_input IN allergies.allergy_name%TYPE,
        password_in        IN VARCHAR2,
        status             OUT VARCHAR2
    );

    PROCEDURE pr_insert_update_app_role (
        u_name_in         IN VARCHAR2,
        role_id_input     IN NUMBER,
        role_type_input   IN app_role.role_type%TYPE,
        date_create_input IN app_role.date_created%TYPE DEFAULT sysdate,
        password_in       IN VARCHAR2,
        status            OUT VARCHAR2
    );

    PROCEDURE pr_insert_update_app_user (
        u_name_in       IN VARCHAR2,
        user_id_input   IN NUMBER,
        role_id_input   IN NUMBER,
        user_name_input IN app_user.user_name%TYPE,
        password_input  IN VARCHAR2,
        password_in    IN VARCHAR2,
        status          OUT VARCHAR2
    );

    PROCEDURE pr_insert_update_country (
        u_name_in          IN VARCHAR2,
        country_code_input IN NUMBER,
        country_name_input IN country.country_name%TYPE,
        password_in        IN VARCHAR2,
        status             OUT VARCHAR2
    );

    PROCEDURE pr_insert_update_diet (
        u_name_in       IN VARCHAR2,
        diet_id_input   IN NUMBER,
        diet_type_input IN diet.diet_type%TYPE,
        password_in     IN VARCHAR2,
        status          OUT VARCHAR2
    );

    PROCEDURE pr_insert_update_disease (
        u_name_in           IN VARCHAR2,
        disease_id_input    IN NUMBER,
        disease_name_input  IN diseases.disease_name%TYPE,
        is_chronic_input    IN diseases.is_chronic%TYPE DEFAULT 'FALSE',
        is_hereditary_input IN diseases.is_hereditary%TYPE DEFAULT 'FALSE',
        is_terminal_input   IN diseases.is_terminal%TYPE DEFAULT 'FALSE',
        password_in         IN VARCHAR2,
        status              OUT VARCHAR2
    );

    PROCEDURE pr_insert_update_ethnicity (
        u_name_in            IN VARCHAR2,
        ethnicity_id_input   IN NUMBER,
        ethnicity_type_input IN ethnicity.ethnicity_name%TYPE,
        password_in          IN VARCHAR2,
        status               OUT VARCHAR2
    );

    PROCEDURE pr_insert_update_habit (
        u_name_in        IN VARCHAR2,
        habit_id_input   IN NUMBER,
        habit_name_input IN habit.habit_name%TYPE,
        password_in      IN VARCHAR2,
        status           OUT VARCHAR2
    );

    PROCEDURE pr_insert_update_location_stat (
        u_name_in           IN VARCHAR2,
        location_code_input IN NUMBER,
        zip_id_input        IN location_statistics.zip_id%TYPE,
        pm_input            IN location_statistics.particulate_matter_reading%TYPE DEFAULT 0,
        aqi_input           IN location_statistics.air_polution_index%TYPE DEFAULT 0,
        co_input            IN location_statistics.co_readings%TYPE DEFAULT 0,
        no_input            IN location_statistics.no2_readings%TYPE DEFAULT 0,
        wqi_input           IN location_statistics.water_quality_parameter%TYPE DEFAULT 0,
        password_in         IN VARCHAR2,
        status              OUT VARCHAR2
    );

    PROCEDURE pr_insert_update_medicine (
        u_name_in           IN VARCHAR2,
        medicine_id_input   IN NUMBER,
        medicine_name_input IN medicines.medicine_name%TYPE,
        password_in         IN VARCHAR2,
        status              OUT VARCHAR2
    );

    PROCEDURE pr_insert_update_symptoms (
        u_name_in          IN VARCHAR2,
        symptom_id_input   IN NUMBER,
        symptom_name_input IN symptoms.symptom_name%TYPE,
        password_in        IN VARCHAR2,
        status             OUT VARCHAR2
    );

    PROCEDURE pr_insert_update_user_details (
        u_name_in       IN VARCHAR2,
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
        password_in     IN VARCHAR2,
        status          OUT VARCHAR2
    );

    PROCEDURE pr_insert_update_vaccine (
        u_name_in          IN VARCHAR2,
        vaccine_id_input   IN NUMBER,
        vaccine_name_input IN vaccine.vaccine_name%TYPE,
        disease_id_input   IN vaccine.disease_id%TYPE,
        password_in        IN VARCHAR2,
        status             OUT VARCHAR2
    );

    PROCEDURE pr_insert_update_zip_code (
        u_name_in      IN VARCHAR2,
        zip_id_input   IN NUMBER,
        zip_code_input IN zipcode.zip_code%TYPE,
        county_input   IN zipcode.county%TYPE,
        city_input     IN zipcode.city%TYPE,
        state_input    IN zipcode.state_name%TYPE,
        country_input  IN zipcode.country_code%TYPE,
        password_in    IN VARCHAR2,
        status         OUT VARCHAR2
    );

    PROCEDURE pr_delete_app_user (
        u_name_in     IN VARCHAR2,
        user_id_input IN NUMBER,
        role_id_input IN NUMBER,
        password_in   IN VARCHAR2,
        status        OUT VARCHAR2
    );

END pk_app_admin;

/
--------------------------------------------------------
--  DDL for Package PK_AUTHENTICATION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_AUTHENTICATION" as
 G_CHARACTER_SET VARCHAR2(10) := 'AL32UTF8';
  G_STRING VARCHAR2(32) := '12345678901234567890123456789012';
  G_KEY RAW(250) := utl_i18n.string_to_raw
                      ( data => G_STRING,
                        dst_charset => G_CHARACTER_SET );
  G_ENCRYPTION_TYPE PLS_INTEGER := dbms_crypto.encrypt_aes256 
                                    + dbms_crypto.chain_cbc 
                                    + dbms_crypto.pad_pkcs5;
FUNCTION encrypt_val( p_val IN VARCHAR2 ) RETURN RAW;
 FUNCTION decrypt_val( p_val IN RAW ) RETURN VARCHAR2 ;
 
FUNCTION authenticate (
    V_ROLE_ID app_user.role_id%TYPE,
    v_user_name     app_user.user_name%TYPE,
    v_user_password VARCHAR2
) RETURN NUMBER;

FUNCTION authenticate_PATIENT (
    v_user_name     app_user.user_name%TYPE,
    v_user_password VARCHAR2
) RETURN NUMBER;

FUNCTION authenticate_by_user (
    V_ROLE_ID app_user.role_id%TYPE,
    v_user_id user_details.user_id%TYPE,
    v_user_password VARCHAR2
) RETURN NUMBER;

end PK_AUTHENTICATION;

/
--------------------------------------------------------
--  DDL for Package PK_PATIENT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "PK_PATIENT" AS
    PROCEDURE pr_insert_alergies_patient (
        a_user_name     IN VARCHAR2,
        a_user_password IN VARCHAR2,
        v_allergy_id    IN allergies_patient.allergy_id%TYPE,
        v_notes         IN allergies_patient.notes%TYPE,
        status          OUT VARCHAR2
    );

    PROCEDURE pr_insert_habit_patient (
        a_user_name          IN VARCHAR2,
        a_user_password      IN VARCHAR2,
        v_habit_id           IN habits_patient.habit_id%TYPE,
        v_frequency_per_week IN habits_patient.frequency_per_week%TYPE,
        v_notes              IN habits_patient.notes%TYPE,
        status               OUT VARCHAR2
    );

    PROCEDURE pr_insert_symptom_patient (
        a_user_name     IN VARCHAR2,
        a_user_password IN VARCHAR2,
        v_symptom_id    IN symptom_patient.symptom_id%TYPE,
        v_notes         IN symptom_patient.notes%TYPE,
        status          OUT VARCHAR2
    );

    PROCEDURE pr_insert_family (
        a_user_name     IN VARCHAR2,
        a_user_password IN VARCHAR2,
        v_relative_id   IN family.relative_id%TYPE,
        status          OUT VARCHAR2
    );

    PROCEDURE pr_patient_report (
        v_patient_id IN user_details.user_id%TYPE,
        status       OUT VARCHAR2
    );

END pk_patient;

/
--------------------------------------------------------
--  DDL for Package Body PK_APP_ADMIN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PK_APP_ADMIN" AS

    PROCEDURE pr_insert_update_allergy (
        u_name_in          IN VARCHAR2,
        allergy_id_input   IN NUMBER,
        allergy_name_input IN allergies.allergy_name%TYPE,
        password_in        IN VARCHAR2,
        status             OUT VARCHAR2
    ) IS
        is_found NUMBER;
        is_invalid_id_ex EXCEPTION;
        is_not_alphabetic_ex EXCEPTION;
        is_too_long_ex EXCEPTION;
        is_unauthorized_ex EXCEPTION;
    BEGIN
        IF authenticate(4, u_name_in, password_in) < 1 THEN
            RAISE is_unauthorized_ex;
        END IF;
        IF allergy_id_input IS NULL THEN
            RAISE is_invalid_id_ex;
        END IF;
        IF allergy_name_input IS NULL OR length(trim(translate(allergy_name_input, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',
        ' '))) > 0 THEN
            RAISE is_not_alphabetic_ex;
        END IF;

        IF length(allergy_name_input) > 100 THEN
            RAISE is_too_long_ex;
        END IF;
        is_found := is_allergy_exist(allergy_id_input);
        IF is_found = 1 THEN
            UPDATE allergies
            SET
                allergy_name = allergy_name_input
            WHERE
                allergy_id = allergy_id_input;

            status := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
        ELSE
            INSERT INTO allergies ( allergy_name ) VALUES ( allergy_name_input );

            status := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
        END IF;

        COMMIT;
    EXCEPTION
        WHEN is_invalid_id_ex THEN
            status := 'Id can not be null';
        WHEN is_not_alphabetic_ex THEN
            status := 'Name should only contain alphabets';
        WHEN is_too_long_ex THEN
            status := 'Name is more than 100 characters';
        WHEN is_unauthorized_ex THEN
            status := 'User unauthorized to perform this action';
        WHEN OTHERS THEN
            status := sqlerrm;
    END pr_insert_update_allergy;

    PROCEDURE pr_insert_update_app_role (
        u_name_in         IN VARCHAR2,
        role_id_input     IN NUMBER,
        role_type_input   IN app_role.role_type%TYPE,
        date_create_input IN app_role.date_created%TYPE DEFAULT sysdate,
        password_in       IN VARCHAR2,
        status            OUT VARCHAR2
    ) IS

        is_role_found NUMBER;
        is_invalid_role_id_ex EXCEPTION;
        is_invalid_user_id_ex EXCEPTION;
        is_not_alphabetic_ex EXCEPTION;
        is_too_long_ex EXCEPTION;
        dc_ex EXCEPTION;
        is_unauthorized_ex EXCEPTION;
    BEGIN
        IF authenticate(4, u_name_in, password_in) < 1 THEN
            RAISE is_unauthorized_ex;
        END IF;
        IF role_id_input IS NULL THEN
            RAISE is_invalid_role_id_ex;
        END IF;
        IF ( date_create_input > sysdate ) THEN
            RAISE dc_ex;
        END IF;
        IF role_type_input IS NULL OR length(trim(translate(role_type_input, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' '))) >
        0 THEN
            RAISE is_not_alphabetic_ex;
        END IF;

        IF length(role_type_input) > 100 THEN
            RAISE is_too_long_ex;
        END IF;
        is_role_found := is_disease_exist(role_id_input);
        IF is_role_found = 1 THEN
            IF date_create_input IS NOT NULL THEN
                UPDATE app_role
                SET
                    role_type = role_type_input,
                    date_created = date_create_input
                WHERE
                    role_id = role_id_input;

            ELSE
                UPDATE app_role
                SET
                    role_type = role_type_input
                WHERE
                    role_id = role_id_input;

            END IF;

            status := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
        ELSE
            IF date_create_input IS NOT NULL THEN
                INSERT INTO app_role (
                    role_type,
                    date_created
                ) VALUES (
                    role_type_input,
                    date_create_input
                );

            ELSE
                INSERT INTO app_role (
                    role_type,
                    date_created
                ) VALUES (
                    role_type_input,
                    sysdate
                );

            END IF;

            status := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
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
        WHEN is_unauthorized_ex THEN
            status := 'User unauthorized to perform this action';
        WHEN OTHERS THEN
            status := sqlerrm;
    END pr_insert_update_app_role;

    PROCEDURE pr_insert_update_country (
        u_name_in          IN VARCHAR2,
        country_code_input IN NUMBER,
        country_name_input IN country.country_name%TYPE,
        password_in        IN VARCHAR2,
        status             OUT VARCHAR2
    ) IS
        is_found NUMBER;
        is_invalid_id_ex EXCEPTION;
        is_not_alphabetic_ex EXCEPTION;
        is_too_long_ex EXCEPTION;
        is_unauthorized_ex EXCEPTION;
    BEGIN
        IF authenticate(4, u_name_in, password_in) < 1 THEN
            RAISE is_unauthorized_ex;
        END IF;
        IF country_code_input IS NULL THEN
            RAISE is_invalid_id_ex;
        END IF;
        IF country_name_input IS NULL OR length(trim(translate(country_name_input, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',
        ' '))) > 0 THEN
            RAISE is_not_alphabetic_ex;
        END IF;

        IF length(country_name_input) > 100 THEN
            RAISE is_too_long_ex;
        END IF;
        is_found := is_country_exist(country_code_input);
        IF is_found = 1 THEN
            UPDATE country
            SET
                country_name = country_name_input
            WHERE
                country_code = country_code_input;

            status := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
        ELSE
            INSERT INTO country (
                country_code,
                country_name
            ) VALUES (
                country_code_input,
                country_name_input
            );

            status := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
        END IF;

        COMMIT;
    EXCEPTION
        WHEN is_invalid_id_ex THEN
            status := 'Id can not be null';
        WHEN is_not_alphabetic_ex THEN
            status := 'Name should only contain alphabets';
        WHEN is_too_long_ex THEN
            status := 'Name is more than 100 characters';
        WHEN is_unauthorized_ex THEN
            status := 'User unauthorized to perform this action';
        WHEN OTHERS THEN
            status := sqlerrm;
    END pr_insert_update_country;

    PROCEDURE pr_insert_update_diet (
        u_name_in       IN VARCHAR2,
        diet_id_input   IN NUMBER,
        diet_type_input IN diet.diet_type%TYPE,
        password_in     IN VARCHAR2,
        status          OUT VARCHAR2
    ) IS
        is_found NUMBER;
        is_invalid_id_ex EXCEPTION;
        is_not_alphabetic_ex EXCEPTION;
        is_too_long_ex EXCEPTION;
        is_unauthorized_ex EXCEPTION;
    BEGIN
        IF authenticate(4, u_name_in, password_in) < 1 THEN
            RAISE is_unauthorized_ex;
        END IF;
        IF diet_id_input IS NULL THEN
            RAISE is_invalid_id_ex;
        END IF;
        IF diet_type_input IS NULL OR length(trim(translate(diet_type_input, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-',
        ' '))) > 0 THEN
            RAISE is_not_alphabetic_ex;
        END IF;

        IF length(diet_type_input) > 100 THEN
            RAISE is_too_long_ex;
        END IF;
        is_found := is_diet_exist(diet_id_input);
        IF is_found = 1 THEN
            UPDATE diet
            SET
                diet_type = diet_type_input
            WHERE
                diet_id = diet_id_input;

            status := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
        ELSE
            INSERT INTO diet (
                diet_id,
                diet_type
            ) VALUES (
                diet_id_input,
                diet_type_input
            );

            status := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
        END IF;

        COMMIT;
    EXCEPTION
        WHEN is_invalid_id_ex THEN
            status := 'Id can not be null';
        WHEN is_not_alphabetic_ex THEN
            status := 'Name should only contain alphabets';
        WHEN is_too_long_ex THEN
            status := 'Name is more than 100 characters';
        WHEN is_unauthorized_ex THEN
            status := 'User unauthorized to perform this action';
        WHEN OTHERS THEN
            status := sqlerrm;
    END pr_insert_update_diet;

    PROCEDURE pr_insert_update_disease (
        u_name_in           IN VARCHAR2,
        disease_id_input    IN NUMBER,
        disease_name_input  IN diseases.disease_name%TYPE,
        is_chronic_input    IN diseases.is_chronic%TYPE DEFAULT 'FALSE',
        is_hereditary_input IN diseases.is_hereditary%TYPE DEFAULT 'FALSE',
        is_terminal_input   IN diseases.is_terminal%TYPE DEFAULT 'FALSE',
        password_in         IN VARCHAR2,
        status              OUT VARCHAR2
    ) IS

        is_disease_found NUMBER;
        is_invalid_disease_id_ex EXCEPTION;
        is_not_alphanumeric_ex EXCEPTION;
        is_too_long_ex EXCEPTION;
        is_invalid_chronic_ex EXCEPTION;
        is_invalid_hereditary_ex EXCEPTION;
        is_invalid_terminal_ex EXCEPTION;
        is_unauthorized_ex EXCEPTION;
    BEGIN
        IF authenticate(4, u_name_in, password_in) < 1 THEN
            RAISE is_unauthorized_ex;
        END IF;
        IF disease_id_input IS NULL THEN
            RAISE is_invalid_disease_id_ex;
        END IF;
        IF disease_name_input IS NULL OR length(trim(translate(disease_name_input, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+-.0123456789',
        ' '))) > 0 THEN
            RAISE is_not_alphanumeric_ex;
        END IF;

        IF length(disease_name_input) > 100 THEN
            RAISE is_too_long_ex;
        END IF;
        IF is_chronic_input NOT IN ( 'TRUE', 'FALSE' ) THEN
            RAISE is_invalid_chronic_ex;
        END IF;
        IF is_hereditary_input NOT IN ( 'TRUE', 'FALSE' ) THEN
            RAISE is_invalid_hereditary_ex;
        END IF;
        IF is_terminal_input NOT IN ( 'TRUE', 'FALSE' ) THEN
            RAISE is_invalid_terminal_ex;
        END IF;
        is_disease_found := is_disease_exist(disease_id_input);
        IF is_disease_found = 1 THEN
            IF
                is_chronic_input IS NOT NULL
                AND is_hereditary_input IS NOT NULL
                AND is_terminal_input IS NOT NULL
            THEN
                UPDATE diseases
                SET
                    disease_name = upper(disease_name_input),
                    is_chronic = upper(is_chronic_input),
                    is_hereditary = upper(is_hereditary_input),
                    is_terminal = upper(is_terminal_input)
                WHERE
                    disease_id = disease_id_input;

            ELSIF
                is_chronic_input IS NULL
                AND is_hereditary_input IS NOT NULL
                AND is_terminal_input IS NOT NULL
            THEN
                UPDATE diseases
                SET
                    disease_name = upper(disease_name_input),
                    is_hereditary = upper(is_hereditary_input),
                    is_terminal = upper(is_terminal_input)
                WHERE
                    disease_id = disease_id_input;

            ELSIF
                is_chronic_input IS NOT NULL
                AND is_hereditary_input IS NULL
                AND is_terminal_input IS NOT NULL
            THEN
                UPDATE diseases
                SET
                    disease_name = upper(disease_name_input),
                    is_chronic = upper(is_chronic_input),
                    is_terminal = upper(is_terminal_input)
                WHERE
                    disease_id = disease_id_input;

            ELSIF
                is_chronic_input IS NOT NULL
                AND is_hereditary_input IS NOT NULL
                AND is_terminal_input IS NULL
            THEN
                UPDATE diseases
                SET
                    disease_name = upper(disease_name_input),
                    is_chronic = upper(is_chronic_input),
                    is_hereditary = upper(is_hereditary_input)
                WHERE
                    disease_id = disease_id_input;

            ELSIF
                is_chronic_input IS NULL
                AND is_hereditary_input IS NULL
                AND is_terminal_input IS NOT NULL
            THEN
                UPDATE diseases
                SET
                    disease_name = upper(disease_name_input),
                    is_terminal = upper(is_terminal_input)
                WHERE
                    disease_id = disease_id_input;

            ELSIF
                is_chronic_input IS NOT NULL
                AND is_hereditary_input IS NULL
                AND is_terminal_input IS NULL
            THEN
                UPDATE diseases
                SET
                    disease_name = upper(disease_name_input),
                    is_chronic = upper(is_chronic_input)
                WHERE
                    disease_id = disease_id_input;

            ELSIF
                is_chronic_input IS NULL
                AND is_hereditary_input IS NOT NULL
                AND is_terminal_input IS NULL
            THEN
                UPDATE diseases
                SET
                    disease_name = upper(disease_name_input),
                    is_hereditary = upper(is_hereditary_input)
                WHERE
                    disease_id = disease_id_input;

            ELSE
                UPDATE diseases
                SET
                    disease_name = upper(disease_name_input)
                WHERE
                    disease_id = disease_id_input;

            END IF;

            status := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
        ELSE
            IF
                is_chronic_input IS NOT NULL
                AND is_hereditary_input IS NOT NULL
                AND is_terminal_input IS NOT NULL
            THEN
                INSERT INTO diseases (
                    disease_name,
                    is_chronic,
                    is_hereditary,
                    is_terminal
                ) VALUES (
                    disease_name_input,
                    upper(is_chronic_input),
                    upper(is_hereditary_input),
                    upper(is_terminal_input)
                );

            ELSIF
                is_chronic_input IS NULL
                AND is_hereditary_input IS NOT NULL
                AND is_terminal_input IS NOT NULL
            THEN
                INSERT INTO diseases (
                    disease_name,
                    is_chronic,
                    is_hereditary,
                    is_terminal
                ) VALUES (
                    disease_name_input,
                    'FALSE',
                    upper(is_hereditary_input),
                    upper(is_terminal_input)
                );

            ELSIF
                is_chronic_input IS NOT NULL
                AND is_hereditary_input IS NULL
                AND is_terminal_input IS NOT NULL
            THEN
                INSERT INTO diseases (
                    disease_name,
                    is_chronic,
                    is_hereditary,
                    is_terminal
                ) VALUES (
                    disease_name_input,
                    upper(is_chronic_input),
                    'FALSE',
                    upper(is_terminal_input)
                );

            ELSIF
                is_chronic_input IS NOT NULL
                AND is_hereditary_input IS NOT NULL
                AND is_terminal_input IS NULL
            THEN
                INSERT INTO diseases (
                    disease_name,
                    is_chronic,
                    is_hereditary,
                    is_terminal
                ) VALUES (
                    disease_name_input,
                    upper(is_chronic_input),
                    upper(is_hereditary_input),
                    'FALSE'
                );

            ELSIF
                is_chronic_input IS NULL
                AND is_hereditary_input IS NULL
                AND is_terminal_input IS NOT NULL
            THEN
                INSERT INTO diseases (
                    disease_name,
                    is_chronic,
                    is_hereditary,
                    is_terminal
                ) VALUES (
                    disease_name_input,
                    'FALSE',
                    'FALSE',
                    upper(is_terminal_input)
                );

            ELSIF
                is_chronic_input IS NOT NULL
                AND is_hereditary_input IS NULL
                AND is_terminal_input IS NULL
            THEN
                INSERT INTO diseases (
                    disease_name,
                    is_chronic,
                    is_hereditary,
                    is_terminal
                ) VALUES (
                    disease_name_input,
                    upper(is_chronic_input),
                    'FALSE',
                    'FALSE'
                );

            ELSIF
                is_chronic_input IS NULL
                AND is_hereditary_input IS NOT NULL
                AND is_terminal_input IS NULL
            THEN
                INSERT INTO diseases (
                    disease_name,
                    is_chronic,
                    is_hereditary,
                    is_terminal
                ) VALUES (
                    disease_name_input,
                    'FALSE',
                    upper(is_hereditary_input),
                    'FALSE'
                );

            ELSE
                INSERT INTO diseases (
                    disease_name,
                    is_chronic,
                    is_hereditary,
                    is_terminal
                ) VALUES (
                    disease_name_input,
                    'FALSE',
                    'FALSE',
                    'FALSE'
                );

            END IF;

            status := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
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
        WHEN is_unauthorized_ex THEN
            status := 'User unauthorized to perform this action';
        WHEN OTHERS THEN
            status := sqlerrm;
    END pr_insert_update_disease;

    PROCEDURE pr_insert_update_ethnicity (
        u_name_in            IN VARCHAR2,
        ethnicity_id_input   IN NUMBER,
        ethnicity_type_input IN ethnicity.ethnicity_name%TYPE,
        password_in          IN VARCHAR2,
        status               OUT VARCHAR2
    ) IS
        is_found NUMBER;
        is_invalid_id_ex EXCEPTION;
        is_not_alphabetic_ex EXCEPTION;
        is_too_long_ex EXCEPTION;
        is_unauthorized_ex EXCEPTION;
    BEGIN
        IF authenticate(4, u_name_in, password_in) < 1 THEN
            RAISE is_unauthorized_ex;
        END IF;
        IF ethnicity_id_input IS NULL THEN
            RAISE is_invalid_id_ex;
        END IF;
        IF ethnicity_type_input IS NULL OR length(trim(translate(ethnicity_type_input, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',
        ' '))) > 0 THEN
            RAISE is_not_alphabetic_ex;
        END IF;

        IF length(ethnicity_type_input) > 100 THEN
            RAISE is_too_long_ex;
        END IF;
        is_found := is_ethnicity_exist(ethnicity_id_input);
        IF is_found = 1 THEN
            UPDATE ethnicity
            SET
                ethnicity_name = ethnicity_type_input
            WHERE
                ethnicity_id = ethnicity_id_input;

            status := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
        ELSE
            INSERT INTO ethnicity ( ethnicity_name ) VALUES ( ethnicity_type_input );

            status := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
        END IF;

        COMMIT;
    EXCEPTION
        WHEN is_invalid_id_ex THEN
            status := 'Id can not be null';
        WHEN is_not_alphabetic_ex THEN
            status := 'Name should only contain alphabets';
        WHEN is_too_long_ex THEN
            status := 'Name is more than 100 characters';
        WHEN is_unauthorized_ex THEN
            status := 'User unauthorized to perform this action';
        WHEN OTHERS THEN
            status := sqlerrm;
    END pr_insert_update_ethnicity;

    PROCEDURE pr_insert_update_habit (
        u_name_in        IN VARCHAR2,
        habit_id_input   IN NUMBER,
        habit_name_input IN habit.habit_name%TYPE,
        password_in      IN VARCHAR2,
        status           OUT VARCHAR2
    ) IS
        is_found NUMBER;
        is_invalid_id_ex EXCEPTION;
        is_not_alphabetic_ex EXCEPTION;
        is_too_long_ex EXCEPTION;
        is_unauthorized_ex EXCEPTION;
    BEGIN
        IF authenticate(4, u_name_in, password_in) < 1 THEN
            RAISE is_unauthorized_ex;
        END IF;
        IF habit_id_input IS NULL THEN
            RAISE is_invalid_id_ex;
        END IF;
        IF habit_name_input IS NULL OR length(trim(translate(habit_name_input, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',
        ' '))) > 0 THEN
            RAISE is_not_alphabetic_ex;
        END IF;

        IF length(habit_name_input) > 100 THEN
            RAISE is_too_long_ex;
        END IF;
        is_found := is_habit_exist(habit_id_input);
        IF is_found = 1 THEN
            UPDATE habit
            SET
                habit_name = habit_name_input
            WHERE
                habit_id = habit_id_input;

            status := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
        ELSE
            INSERT INTO habit ( habit_name ) VALUES ( habit_name_input );

            status := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
        END IF;

        COMMIT;
    EXCEPTION
        WHEN is_invalid_id_ex THEN
            status := 'Id can not be null';
        WHEN is_not_alphabetic_ex THEN
            status := 'Name should only contain alphabets';
        WHEN is_too_long_ex THEN
            status := 'Name is more than 100 characters';
        WHEN is_unauthorized_ex THEN
            status := 'User unauthorized to perform this action';
        WHEN OTHERS THEN
            status := sqlerrm;
    END pr_insert_update_habit;

    PROCEDURE pr_insert_update_location_stat (
        u_name_in           IN VARCHAR2,
        location_code_input IN NUMBER,
        zip_id_input        IN location_statistics.zip_id%TYPE,
        pm_input            IN location_statistics.particulate_matter_reading%TYPE DEFAULT 0,
        aqi_input           IN location_statistics.air_polution_index%TYPE DEFAULT 0,
        co_input            IN location_statistics.co_readings%TYPE DEFAULT 0,
        no_input            IN location_statistics.no2_readings%TYPE DEFAULT 0,
        wqi_input           IN location_statistics.water_quality_parameter%TYPE DEFAULT 0,
        password_in         IN VARCHAR2,
        status              OUT VARCHAR2
    ) IS
        is_zip_found      NUMBER;
        is_location_found NUMBER;
        is_invalid_zip_id_ex EXCEPTION;
        is_invalid_location_code_ex EXCEPTION;
        is_unauthorized_ex EXCEPTION;
    BEGIN
        IF authenticate(4, u_name_in, password_in) < 1 THEN
            RAISE is_unauthorized_ex;
        END IF;
        IF zip_id_input IS NULL THEN
            RAISE is_invalid_zip_id_ex;
        END IF;
        IF location_code_input IS NULL THEN
            RAISE is_invalid_location_code_ex;
        END IF;
        is_zip_found := is_zipcode_exist(zip_id_input);
        is_location_found := is_location_statistics_exist(location_code_input);
        IF is_zip_found = 0 THEN
            RAISE is_invalid_zip_id_ex;
        END IF;
        IF is_location_found = 1 THEN
            UPDATE location_statistics
            SET
                zip_id = zip_id_input,
                particulate_matter_reading = pm_input,
                co_readings = co_input,
                no2_readings = no_input,
                air_polution_index = aqi_input,
                water_quality_parameter = wqi_input
            WHERE
                location_code = location_code_input;

            status := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
        ELSE
            INSERT INTO location_statistics (
                location_code,
                zip_id,
                particulate_matter_reading,
                co_readings,
                no2_readings,
                air_polution_index,
                water_quality_parameter
            ) VALUES (
                location_code_input,
                zip_id_input,
                pm_input,
                co_input,
                no_input,
                aqi_input,
                wqi_input
            );

            status := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
        END IF;

        COMMIT;
    EXCEPTION
        WHEN is_invalid_zip_id_ex THEN
            status := 'Zip id can not be null';
        WHEN is_invalid_location_code_ex THEN
            status := 'Location Code can not be null';
        WHEN is_unauthorized_ex THEN
            status := 'User unauthorized to perform this action';
        WHEN OTHERS THEN
            status := sqlerrm;
    END pr_insert_update_location_stat;

    PROCEDURE pr_insert_update_medicine (
        u_name_in           IN VARCHAR2,
        medicine_id_input   IN NUMBER,
        medicine_name_input IN medicines.medicine_name%TYPE,
        password_in         IN VARCHAR2,
        status              OUT VARCHAR2
    ) IS
        is_found NUMBER;
        is_invalid_id_ex EXCEPTION;
        is_not_alphanumeric_ex EXCEPTION;
        is_too_long_ex EXCEPTION;
        is_unauthorized_ex EXCEPTION;
    BEGIN
        IF authenticate(4, u_name_in, password_in) < 1 THEN
            RAISE is_unauthorized_ex;
        END IF;
        IF medicine_id_input IS NULL THEN
            RAISE is_invalid_id_ex;
        END IF;
        IF medicine_name_input IS NULL OR length(trim(translate(medicine_name_input, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+-.0123456789',
        ' '))) > 0 THEN
            RAISE is_not_alphanumeric_ex;
        END IF;

        IF length(medicine_name_input) > 100 THEN
            RAISE is_too_long_ex;
        END IF;
        is_found := is_medicine_exist(medicine_id_input);
        IF is_found = 1 THEN
            UPDATE medicines
            SET
                medicine_name = medicine_name_input
            WHERE
                medicine_id = medicine_id_input;

            status := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
        ELSE
            INSERT INTO medicines (
                medicine_id,
                medicine_name
            ) VALUES (
                medicine_id_input,
                medicine_name_input
            );

            status := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
        END IF;

        COMMIT;
    EXCEPTION
        WHEN is_invalid_id_ex THEN
            status := 'Id can not be null';
        WHEN is_not_alphanumeric_ex THEN
            status := 'Name should only contain alphanumeric';
        WHEN is_too_long_ex THEN
            status := 'Name is more than 100 characters';
        WHEN is_unauthorized_ex THEN
            status := 'User unauthorized to perform this action';
        WHEN OTHERS THEN
            status := sqlerrm;
    END pr_insert_update_medicine;

    PROCEDURE pr_insert_update_symptoms (
        u_name_in          IN VARCHAR2,
        symptom_id_input   IN NUMBER,
        symptom_name_input IN symptoms.symptom_name%TYPE,
        password_in        IN VARCHAR2,
        status             OUT VARCHAR2
    ) IS
        is_found NUMBER;
        is_invalid_id_ex EXCEPTION;
        is_not_alphabetic_ex EXCEPTION;
        is_too_long_ex EXCEPTION;
        is_unauthorized_ex EXCEPTION;
    BEGIN
        IF authenticate(4, u_name_in, password_in) < 1 THEN
            RAISE is_unauthorized_ex;
        END IF;
        IF symptom_id_input IS NULL THEN
            RAISE is_invalid_id_ex;
        END IF;
        IF symptom_name_input IS NULL OR length(trim(translate(symptom_name_input, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',
        ' '))) > 0 THEN
            RAISE is_not_alphabetic_ex;
        END IF;

        IF length(symptom_name_input) > 100 THEN
            RAISE is_too_long_ex;
        END IF;
        is_found := is_symptom_exist(symptom_id_input);
        IF is_found = 1 THEN
            UPDATE symptoms
            SET
                symptom_name = symptom_name_input
            WHERE
                symptom_id = symptom_id_input;

            status := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
        ELSE
            INSERT INTO symptoms ( symptom_name ) VALUES ( symptom_name_input );

            status := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
        END IF;

        COMMIT;
    EXCEPTION
        WHEN is_invalid_id_ex THEN
            status := 'Id can not be null';
        WHEN is_not_alphabetic_ex THEN
            status := 'Name should only contain alphabets';
        WHEN is_too_long_ex THEN
            status := 'Name is more than 100 characters';
        WHEN is_unauthorized_ex THEN
            status := 'User unauthorized to perform this action';
        WHEN OTHERS THEN
            status := sqlerrm;
    END pr_insert_update_symptoms;

    PROCEDURE pr_insert_update_user_details (
        u_name_in       IN VARCHAR2,
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
        password_in     IN VARCHAR2,
        status          OUT VARCHAR2
    ) IS

        user_count  NUMBER;
        dob_ex EXCEPTION;
        zip_id_ex EXCEPTION;
        diet_id_ex EXCEPTION;
        ethnicity_id_ex EXCEPTION;
        is_unauthorized_ex EXCEPTION;
        seq_user_id NUMBER;
    BEGIN
        IF authenticate(4, u_name_in, password_in) < 1 THEN
            RAISE is_unauthorized_ex;
        END IF;
        IF ( v_date_of_birth > sysdate ) THEN
            RAISE dob_ex;
        END IF;
        IF ( is_zipcode_exist(v_zip_id) < 1 ) THEN
            RAISE zip_id_ex;
        END IF;
        IF ( is_ethnicity_exist(v_ethnicity_id) < 1 ) THEN
            RAISE ethnicity_id_ex;
        END IF;
        IF ( is_diet_exist(v_diet_id) < 1 ) THEN
            RAISE diet_id_ex;
        END IF;
        IF ( is_user_exist(v_user_id) > 0 ) THEN
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

            status := 'SUCCESS: USER_ID - '
                      || v_user_id
                      || ' UPDATED SUCCESSFULLY';
        ELSE
            SELECT
                user_id_seq.NEXTVAL
            INTO seq_user_id
            FROM
                dual;

            INSERT INTO user_details (
                user_id,
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
                seq_user_id,
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

            COMMIT;
            pr_insert_update_app_user('A_280', seq_user_id, 1, 'P_' || seq_user_id, 'P_' || seq_user_id,
                                     'A_280', status);

            status := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
        END IF;

        COMMIT;
    EXCEPTION
        WHEN dob_ex THEN
            status := 'ERROR: DATE OF BIRTH CANNOT BE IN FUTURE';
        WHEN zip_id_ex THEN
            status := 'ERROR: Invalid Zip ID';
        WHEN diet_id_ex THEN
            status := 'ERROR: Invalid DIET ID';
        WHEN ethnicity_id_ex THEN
            status := 'ERROR: Invalid Ethnicity ID';
        WHEN is_unauthorized_ex THEN
            status := 'User unauthorized to perform this action';
        WHEN OTHERS THEN
            status := 'ERROR: ' || sqlerrm;
    END pr_insert_update_user_details;

    PROCEDURE pr_insert_update_vaccine (
        u_name_in          IN VARCHAR2,
        vaccine_id_input   IN NUMBER,
        vaccine_name_input IN vaccine.vaccine_name%TYPE,
        disease_id_input   IN vaccine.disease_id%TYPE,
        password_in        IN VARCHAR2,
        status             OUT VARCHAR2
    ) IS

        is_vaccine_found NUMBER;
        is_disease_found NUMBER;
        is_invalid_vaccine_id_ex EXCEPTION;
        is_invalid_disease_id_ex EXCEPTION;
        is_not_alphanumeric_ex EXCEPTION;
        is_too_long_ex EXCEPTION;
        is_unauthorized_ex EXCEPTION;
    BEGIN
        IF authenticate(4, u_name_in, password_in) < 1 THEN
            RAISE is_unauthorized_ex;
        END IF;
        IF vaccine_id_input IS NULL THEN
            RAISE is_invalid_vaccine_id_ex;
        END IF;
        IF vaccine_name_input IS NULL OR length(trim(translate(vaccine_name_input, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+-.0123456789',
        ' '))) > 0 THEN
            RAISE is_not_alphanumeric_ex;
        END IF;

        IF length(vaccine_name_input) > 100 THEN
            RAISE is_too_long_ex;
        END IF;
        is_vaccine_found := is_vaccine_exist(vaccine_id_input);
        is_disease_found := is_disease_exist(disease_id_input);
        IF is_disease_found = 0 THEN
            RAISE is_invalid_disease_id_ex;
        END IF;
        IF is_vaccine_found = 1 THEN
            IF
                disease_id_input IS NOT NULL
                AND vaccine_name_input IS NOT NULL
            THEN
                UPDATE vaccine
                SET
                    vaccine_name = vaccine_name_input,
                    disease_id = disease_id_input
                WHERE
                    vaccine_id = vaccine_id_input;

            ELSIF
                disease_id_input IS NULL
                AND vaccine_name_input IS NOT NULL
            THEN
                UPDATE vaccine
                SET
                    vaccine_name = vaccine_name_input
                WHERE
                    vaccine_id = vaccine_id_input;

            ELSIF
                disease_id_input IS NOT NULL
                AND vaccine_name_input IS NULL
            THEN
                UPDATE vaccine
                SET
                    disease_id = disease_id_input
                WHERE
                    vaccine_id = vaccine_id_input;

            END IF;

            status := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
        ELSE
            IF
                disease_id_input IS NOT NULL
                AND vaccine_name_input IS NOT NULL
            THEN
                INSERT INTO vaccine (
                    vaccine_name,
                    disease_id
                ) VALUES (
                    vaccine_name_input,
                    disease_id_input
                );

            ELSIF
                disease_id_input IS NULL
                AND vaccine_name_input IS NOT NULL
            THEN
                RAISE is_invalid_disease_id_ex;
            ELSE
                RAISE is_not_alphanumeric_ex;
            END IF;

            status := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
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
        WHEN is_unauthorized_ex THEN
            status := 'User unauthorized to perform this action';
        WHEN OTHERS THEN
            status := sqlerrm;
    END pr_insert_update_vaccine;

    PROCEDURE pr_insert_update_zip_code (
        u_name_in      IN VARCHAR2,
        zip_id_input   IN NUMBER,
        zip_code_input IN zipcode.zip_code%TYPE,
        county_input   IN zipcode.county%TYPE,
        city_input     IN zipcode.city%TYPE,
        state_input    IN zipcode.state_name%TYPE,
        country_input  IN zipcode.country_code%TYPE,
        password_in    IN VARCHAR2,
        status         OUT VARCHAR2
    ) IS

        is_zip_found     NUMBER;
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
        is_unauthorized_ex EXCEPTION;
    BEGIN
        IF authenticate(4, u_name_in, password_in) < 1 THEN
            RAISE is_unauthorized_ex;
        END IF;
        IF zip_id_input IS NULL THEN
            RAISE is_invalid_zip_id_ex;
        END IF;
        IF zip_code_input IS NULL THEN
            RAISE is_invalid_zip_code_ex;
        END IF;
        IF country_input IS NULL THEN
            RAISE is_invalid_country_ex;
        END IF;
        IF county_input IS NULL OR length(trim(translate(county_input, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' '))) >
        0 THEN
            RAISE is_not_alphabetic_county_ex;
        END IF;

        IF city_input IS NULL OR length(trim(translate(city_input, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' '))) > 0
        THEN
            RAISE is_not_alphabetic_city_ex;
        END IF;

        IF state_input IS NULL OR length(trim(translate(state_input, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' '))) >
        0 THEN
            RAISE is_not_alphabetic_state_ex;
        END IF;

        IF length(county_input) > 200 THEN
            RAISE is_too_long_county_ex;
        END IF;
        IF length(city_input) > 200 THEN
            RAISE is_too_long_city_ex;
        END IF;
        IF length(state_input) > 200 THEN
            RAISE is_too_long_state_ex;
        END IF;
        is_zip_found := is_zipcode_exist(zip_id_input);
        is_country_found := is_country_exist(country_input);
        IF is_country_found = 0 THEN
            RAISE is_invalid_country_ex;
        END IF;
        IF is_zip_found = 1 THEN
            UPDATE zipcode
            SET
                zip_code = zip_code_input,
                county = county_input,
                city = city_input,
                state_name = state_input,
                country_code = country_input
            WHERE
                zip_id = zip_id_input;

            status := 'SUCCESS: DATA UPDATED SUCCESSFULLY';
        ELSE
            INSERT INTO zipcode (
                zip_code,
                county,
                city,
                state_name,
                country_code
            ) VALUES (
                zip_code_input,
                county_input,
                city_input,
                state_input,
                country_input
            );

            status := 'SUCCESS: DATA INSERTED SUCCESSFULLY';
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
        WHEN is_unauthorized_ex THEN
            status := 'User unauthorized to perform this action';
        WHEN OTHERS THEN
            status := sqlerrm;
    END pr_insert_update_zip_code;

    PROCEDURE pr_insert_update_app_user (
        u_name_in       IN VARCHAR2,
        user_id_input   IN NUMBER,
        role_id_input   IN NUMBER,
        user_name_input IN app_user.user_name%TYPE,
        password_input  IN VARCHAR2,
        password_in     IN VARCHAR2,
        status          OUT VARCHAR2
    ) IS

        is_user_found            NUMBER;
        is_role_found            NUMBER;
        is_invalid_role_id_ex EXCEPTION;
        is_invalid_user_id_ex EXCEPTION;
        user_name_exists_ex EXCEPTION;
        pre_exist_count          NUMBER;
        pre_exist_username_count NUMBER;
        is_unauthorized_ex EXCEPTION;
    BEGIN
        IF pk_authentication.authenticate(4, u_name_in, password_in) < 1 THEN
            RAISE is_unauthorized_ex;
        END IF;

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
        WHEN is_unauthorized_ex THEN
            status := 'User unauthorized to perform this action';
        WHEN OTHERS THEN
            status := 'Error : ' || sqlerrm;
    END pr_insert_update_app_user;

    PROCEDURE pr_delete_app_user (
        u_name_in     IN VARCHAR2,
        user_id_input IN NUMBER,
        role_id_input IN NUMBER,
        password_in   IN VARCHAR2,
        status        OUT VARCHAR2
    ) IS

        is_user_found NUMBER;
        is_role_found NUMBER;
        is_invalid_user_id_ex EXCEPTION;
        is_invalid_role_id_ex EXCEPTION;
        is_invalid_role_user_ex EXCEPTION;
        is_invalid_role_mapping_ex EXCEPTION;
        is_unauthorized_ex EXCEPTION;
    BEGIN
        IF authenticate(4, u_name_in, password_in) < 1 THEN
            RAISE is_unauthorized_ex;
        END IF;
        IF user_id_input IS NULL THEN
            RAISE is_invalid_user_id_ex;
        END IF;
        IF role_id_input IS NULL THEN
            RAISE is_invalid_role_id_ex;
        END IF;
        is_user_found := is_user_exist(user_id_input);
        is_role_found := is_app_role_exist(role_id_input);
        IF
            is_user_found = 1
            AND is_role_found = 1
        THEN
            IF is_role_mapped_user(user_id_input, role_id_input) = 1 THEN
                DELETE FROM app_user
                WHERE
                        user_id = user_id_input
                    AND role_id = role_id_input;

                status := 'SUCCESS: USER_ID - '
                          || user_id_input
                          || ' DELETED SUCCESSFULLY';
            ELSE
                RAISE is_invalid_role_mapping_ex;
            END IF;
        ELSE
            IF
                is_user_found < 1
                AND is_role_found = 1
            THEN
                RAISE is_invalid_user_id_ex;
            ELSIF
                is_user_found = 1
                AND is_role_found < 1
            THEN
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
        WHEN is_unauthorized_ex THEN
            status := 'User unauthorized to perform this action';
    END pr_delete_app_user;

END pk_app_admin;

/
--------------------------------------------------------
--  DDL for Package Body PK_AUTHENTICATION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PK_AUTHENTICATION" AS

  ------------------------------------------------------------------------
  --Encrypt a password 
  --Salt the password
  ------------------------------------------------------------------------
    FUNCTION encrypt_val (
        p_val IN VARCHAR2
    ) RETURN RAW IS

        l_val       RAW(32) := utl_i18n.string_to_raw(p_val, g_character_set);
        l_encrypted RAW(32);
    BEGIN
        l_val := utl_i18n.string_to_raw(data => p_val, dst_charset => g_character_set);
        l_encrypted := dbms_crypto.encrypt(src => l_val, typ => g_encryption_type, key => g_key);

        RETURN l_encrypted;
    END encrypt_val;

    FUNCTION decrypt_val (
        p_val IN RAW
    ) RETURN VARCHAR2 IS
        l_decrypted        RAW(32);
        l_decrypted_string VARCHAR2(32);
        l_user             VARCHAR2(32);
    BEGIN
        SELECT
            user
        INTO l_user
        FROM
            dual;

        IF l_user = 'ADMIN' -- you can restrict usage of decrypt to certain db users only.

         THEN
            l_decrypted := dbms_crypto.decrypt(src => p_val, typ => g_encryption_type, key => g_key);

            l_decrypted_string := utl_i18n.raw_to_char(data => l_decrypted, src_charset => g_character_set);
            RETURN l_decrypted_string;
        ELSE
            raise_application_error(-20101, 'You are not authorized to use this function - decrypt_val()');
        END IF;

        RETURN 'Unknown';
    END decrypt_val;

    FUNCTION authenticate (
        v_role_id       app_user.role_id%TYPE,
        v_user_name     app_user.user_name%TYPE,
        v_user_password VARCHAR2
    ) RETURN NUMBER IS
        exist_count NUMBER;
    BEGIN
        SELECT
            COUNT(1)
        INTO exist_count
        FROM
            app_user
        WHERE
                user_name = v_user_name
            AND user_password = pk_authentication.encrypt_val(v_user_password)
            AND role_id = v_role_id;

        IF ( exist_count > 0 ) THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END;

    FUNCTION authenticate_PATIENT (
    v_user_name     app_user.user_name%TYPE,
    v_user_password VARCHAR2
) RETURN NUMBER IS
        exist_count    NUMBER;
        n_user_id      NUMBER;
        encrypted_pass VARCHAR2(100);
    BEGIN
        encrypted_pass := pk_authentication.encrypt_val(v_user_password);
        SELECT
            COUNT(1)
        INTO exist_count
        FROM
            app_user
        WHERE
                user_name = v_user_name
            AND user_password = encrypted_pass
            AND role_id = 1;

        IF ( exist_count < 1 ) THEN
            RETURN 0;
        ELSE
            SELECT
                user_id
            INTO n_user_id
            FROM
                app_user
            WHERE
                    user_name = v_user_name
                AND user_password = encrypted_pass
                AND role_id = 1;

            RETURN n_user_id;
        END IF;

    END;

    FUNCTION authenticate_by_user (
        v_role_id       app_user.role_id%TYPE,
        v_user_id       user_details.user_id%TYPE,
        v_user_password VARCHAR2
    ) RETURN NUMBER IS
        exist_count NUMBER;
    BEGIN
        SELECT
            COUNT(1)
        INTO exist_count
        FROM
            app_user     au,
            user_details u
        WHERE
                u.user_id = v_user_id
            AND u.user_id = au.user_id
            AND user_password = pk_authentication.encrypt_val(v_user_password)
            AND role_id = v_role_id;

        IF ( exist_count > 0 ) THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END;

END pk_authentication;

/
--------------------------------------------------------
--  DDL for Package Body PK_DOCTOR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PK_DOCTOR" AS

    PROCEDURE PR_ADD_UPDATE_VISIT_HISTORY  (
        VISIT_ID_IN IN visit_history.visit_id%TYPE,
        DP_ID_IN IN visit_history.dp_id%TYPE,
        DOCTOR_ID_IN IN visit_history.doctor_id%TYPE,
        VISIT_NOTES_IN IN visit_history.visit_notes%TYPE,
        PASSWORD_IN IN varchar2,
        STATUS OUT VARCHAR2,
        MESSAGE OUT VARCHAR2
    )  
    IS
        ILLNESS_RECORD_NOT_FOUND EXCEPTION;
        DOCTOR_NOT_FOUND EXCEPTION;
        RECORD_NOT_FOUND EXCEPTION;
        UNAUTHORIZE_ACCESS EXCEPTION;

    BEGIN

        IF(FN_IS_VALID_ILLNESS_RECORD(DP_ID_IN) = 'N') THEN
            RAISE ILLNESS_RECORD_NOT_FOUND;
        END IF;

        IF(IS_USER_EXIST(DOCTOR_ID_IN) = 0) THEN
            RAISE DOCTOR_NOT_FOUND;
        END IF;

        IF(PK_AUTHENTICATION.authenticate_by_user(2, DOCTOR_ID_IN, PASSWORD_IN) = 0) THEN
            RAISE UNAUTHORIZE_ACCESS;
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

        WHEN UNAUTHORIZE_ACCESS THEN
            STATUS := 'F';
            MESSAGE := 'Failed to authorize user.';

        WHEN OTHERS THEN
            STATUS := 'F';
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
            MESSAGE := 'Something went wrong';

    END PR_ADD_UPDATE_VISIT_HISTORY;

    PROCEDURE PR_DELETE_VISIT_HISTORY (
        DOCTOR_ID_IN IN visit_history.doctor_id%TYPE,
        VISIT_ID_IN IN visit_history.visit_id%TYPE,
        PASSWORD_IN IN varchar2,
        STATUS OUT VARCHAR2,
        MESSAGE OUT VARCHAR2
    )
    IS
        RECORD_NOT_FOUND EXCEPTION;
        UNAUTHORIZE_ACCESS EXCEPTION;
    BEGIN

        IF(PK_AUTHENTICATION.authenticate_by_user(2, DOCTOR_ID_IN, PASSWORD_IN) = 0) THEN
            RAISE UNAUTHORIZE_ACCESS;
        END IF;

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
            ROLLBACK;

        WHEN UNAUTHORIZE_ACCESS THEN
            STATUS := 'F';
            MESSAGE := 'Failed to authorize user.';

        WHEN OTHERS THEN
            STATUS := 'F';
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
            MESSAGE := 'Something went wrong';    
    END PR_DELETE_VISIT_HISTORY;

    PROCEDURE PR_ADD_VACCINE_RECORD  (
        VACCINE_ID_IN vaccine_patient.vaccine_id%TYPE,
        PATIENT_ID_IN vaccine_patient.patient_id%TYPE,
        DOCTOR_ID_IN  vaccine_patient.doctor_id%TYPE,
        PASSWORD_IN IN varchar2,
        STATUS OUT VARCHAR2,
        MESSAGE OUT VARCHAR2
    )  
    IS
        VACCINE_COUNT NUMBER;
        VACCINE_NOT_FOUND EXCEPTION;
        DOCTOR_NOT_FOUND EXCEPTION;
        PATIENT_NOT_FOUND EXCEPTION;
        VACCINE_ADMINISTERED EXCEPTION;
        UNAUTHORIZE_ACCESS EXCEPTION;
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

        IF(PK_AUTHENTICATION.authenticate_by_user(2, DOCTOR_ID_IN, PASSWORD_IN) = 0) THEN
            RAISE UNAUTHORIZE_ACCESS;
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
            MESSAGE := 'Patient with user ID: ' || PATIENT_ID_IN || ' not found in system.';

        WHEN DOCTOR_NOT_FOUND THEN
            STATUS := 'F';
            MESSAGE := 'Doctor with user ID: ' || DOCTOR_ID_IN || ' not found in system.';

        WHEN VACCINE_NOT_FOUND THEN
            STATUS := 'F';
            MESSAGE := 'Vaccine with ID: ' || VACCINE_ID_IN || ' not found in system.'; 

        WHEN VACCINE_ADMINISTERED THEN
            STATUS := 'F';
            MESSAGE := 'Vaccine has already been administered to patient';

        WHEN UNAUTHORIZE_ACCESS THEN
            STATUS := 'F';
            MESSAGE := 'Failed to authorize user.';    

        WHEN OTHERS THEN
            STATUS := 'F';
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
            MESSAGE := 'Something went wrong';

    END PR_ADD_VACCINE_RECORD;

    PROCEDURE PR_DELETE_VACCINE_RECORD (
        VACCINE_ID_IN vaccine_patient.vaccine_id%TYPE,
        PATIENT_ID_IN vaccine_patient.patient_id%TYPE,
        DOCTOR_ID_IN  vaccine_patient.doctor_id%TYPE,
        PASSWORD_IN IN varchar2,
        STATUS OUT VARCHAR2,
        MESSAGE OUT VARCHAR2
    )
    IS
        RECORD_NOT_FOUND EXCEPTION;
        UNAUTHORIZE_ACCESS EXCEPTION;
    BEGIN

        IF(PK_AUTHENTICATION.authenticate_by_user(2, DOCTOR_ID_IN, PASSWORD_IN) = 0) THEN
            RAISE UNAUTHORIZE_ACCESS;
        END IF;

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
            ROLLBACK;

       WHEN UNAUTHORIZE_ACCESS THEN
            STATUS := 'F';
            MESSAGE := 'Failed to authorize user.'; 

        WHEN OTHERS THEN
            STATUS := 'F';
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
            MESSAGE := 'Something went wrong';    
    END PR_DELETE_VACCINE_RECORD;

    PROCEDURE PR_ADD_UPDATE_PRESCRIPTION (
        P_ID_IN IN PRESCRIPTION.P_ID%TYPE,
        VISIT_ID_IN IN prescription.visit_id%TYPE,
        DOCTOR_ID_IN IN PRESCRIPTION.DOCTOR_ID%TYPE,
        PATIENT_ID_IN IN PRESCRIPTION.PATIENT_ID%TYPE,
        MEDICINE_ID_IN IN prescription.medicine_id%TYPE,
        DOSAGE_IN IN prescription.dosage%TYPE,
        FREQUENCY_IN IN prescription.frequency%TYPE,
        END_DATE_IN IN PRESCRIPTION.DATE_ENDED%TYPE,
        NOTES_IN IN PRESCRIPTION.NOTES%TYPE,
        PASSWORD_IN IN varchar2,
        STATUS OUT VARCHAR2,
        MESSAGE OUT VARCHAR2
    ) IS
        DOCTOR_NOT_FOUND EXCEPTION;
        PATIENT_NOT_FOUND EXCEPTION;
        MEDICINE_NOT_FOUND EXCEPTION;
        FREQUENCY_NULL_EXCEPTION EXCEPTION;
        END_DATE_EXCEPTION EXCEPTION;
        INVALID_VISIT_ID EXCEPTION;
        UNAUTHORIZE_ACCESS EXCEPTION;
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

        IF(PK_AUTHENTICATION.authenticate_by_user(2, DOCTOR_ID_IN, PASSWORD_IN) = 0) THEN
            RAISE UNAUTHORIZE_ACCESS;
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
            WHEN UNAUTHORIZE_ACCESS THEN
                STATUS := 'F';
                MESSAGE := 'Failed to authorize user.';    
            WHEN OTHERS THEN
                STATUS := 'F';
                DBMS_OUTPUT.PUT_LINE(SQLERRM);
                MESSAGE := 'Something went wrong';   
    END PR_ADD_UPDATE_PRESCRIPTION;

    PROCEDURE PR_DELETE_PRESCRIPTION_RECORD (
        P_ID_IN prescription.p_id%TYPE,
        DOCTOR_ID_IN  PRESCRIPTION.doctor_id%TYPE,
        PASSWORD_IN IN varchar2,
        STATUS OUT VARCHAR2,
        MESSAGE OUT VARCHAR2
    )
    IS
        RECORD_NOT_FOUND EXCEPTION;
        UNAUTHORIZE_ACCESS EXCEPTION;
    BEGIN

        IF(PK_AUTHENTICATION.authenticate_by_user(2, DOCTOR_ID_IN, PASSWORD_IN) = 0) THEN
            RAISE UNAUTHORIZE_ACCESS;
        END IF;

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
            ROLLBACK;

        WHEN UNAUTHORIZE_ACCESS THEN
            STATUS := 'F';
            MESSAGE := 'Failed to authorize user.';

        WHEN OTHERS THEN
            STATUS := 'F';
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
            MESSAGE := 'Something went wrong';    
    END PR_DELETE_PRESCRIPTION_RECORD;

    PROCEDURE PR_ADD_UPDATE_DISEASE_PATIENT (
        DP_ID_IN IN disease_patient.dp_id%TYPE,
        DOCTOR_ID_IN IN disease_patient.doctor_id%TYPE,
        DISEASE_ID_IN IN disease_patient.disease_id%TYPE,
        PATIENT_ID_IN IN disease_patient.patient_id%TYPE,
        PASSWORD_IN IN varchar2,
        STATUS OUT VARCHAR2,
        MESSAGE OUT VARCHAR2
    )
    IS
        DISEASE_NOT_FOUND EXCEPTION;
        PATIENT_NOT_FOUND EXCEPTION;
        DOCTOR_NOT_FOUND EXCEPTION;
        RECORD_NOT_FOUND EXCEPTION;
        UNAUTHORIZE_ACCESS EXCEPTION;
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

        IF(PK_AUTHENTICATION.authenticate_by_user(2, DOCTOR_ID_IN, PASSWORD_IN) = 0) THEN
            RAISE UNAUTHORIZE_ACCESS;
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
        WHEN UNAUTHORIZE_ACCESS THEN
            STATUS := 'F';
            MESSAGE := 'Failed to authorize user.';    
        WHEN OTHERS THEN
            STATUS := 'F';
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
            MESSAGE := 'Something went wrong';          

    END PR_ADD_UPDATE_DISEASE_PATIENT;

    PROCEDURE PR_UPDATE_CURED_DISEASE_PATIENT (
        DP_ID_IN IN disease_patient.dp_id%TYPE,
        DOCTOR_ID_IN IN disease_patient.doctor_id%TYPE,
        PATIENT_ID_IN IN disease_patient.patient_id%TYPE,
        PASSWORD_IN IN varchar2,
        STATUS OUT VARCHAR2,
        MESSAGE OUT VARCHAR2
    )
    IS
        PATIENT_NOT_FOUND EXCEPTION;
        DOCTOR_NOT_FOUND EXCEPTION;
        RECORD_NOT_FOUND EXCEPTION;
        DP_ID_NULL_EXCEPTION EXCEPTION;
        UNAUTHORIZE_ACCESS EXCEPTION;
    BEGIN

        IF(IS_USER_EXIST(PATIENT_ID_IN) = 0) THEN
            RAISE PATIENT_NOT_FOUND;
        END IF;

        IF(IS_USER_EXIST(DOCTOR_ID_IN) = 0) THEN
            RAISE DOCTOR_NOT_FOUND;
        END IF;

        IF(PK_AUTHENTICATION.authenticate_by_user(2, DOCTOR_ID_IN, PASSWORD_IN) = 0) THEN
            RAISE UNAUTHORIZE_ACCESS;
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
        WHEN UNAUTHORIZE_ACCESS THEN
            STATUS := 'F';
            MESSAGE := 'Failed to authorize user.';
        WHEN OTHERS THEN
            STATUS := 'F';
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
            MESSAGE := 'Something went wrong';          

    END PR_UPDATE_CURED_DISEASE_PATIENT;

    PROCEDURE VIEW_PATIENT_DETAILS (
        DOCTOR_ID_IN IN NUMBER,
        PATIENT_ID_IN IN NUMBER,
        PASSWORD_IN IN varchar2,
        STATUS OUT VARCHAR2,
        MESSAGE OUT VARCHAR2
    )
    IS
        DOCTOR_NOT_FOUND EXCEPTION;
        PATIENT_NOT_FOUND EXCEPTION;
        UNAUTHORIZE_ACCESS EXCEPTION;

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

        IF(PK_AUTHENTICATION.authenticate_by_user(2, DOCTOR_ID_IN, PASSWORD_IN) = 0) THEN
            RAISE UNAUTHORIZE_ACCESS;
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
        WHEN UNAUTHORIZE_ACCESS THEN
            STATUS := 'F';
            MESSAGE := 'Failed to authorize user.';    
        WHEN OTHERS THEN
            STATUS := 'F';
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
            MESSAGE := 'Something went wrong';      
    END VIEW_PATIENT_DETAILS;

END PK_DOCTOR;

/
--------------------------------------------------------
--  DDL for Package Body PK_PATIENT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "PK_PATIENT" AS

    PROCEDURE pr_insert_alergies_patient (
        a_user_name     IN VARCHAR2,
        a_user_password IN VARCHAR2,
        v_allergy_id    IN allergies_patient.allergy_id%TYPE,
        v_notes         IN allergies_patient.notes%TYPE,
        status          OUT VARCHAR2
    ) IS

        v_patient_id    NUMBER;
        unauthorized_ex EXCEPTION;
        allergy_id_ex EXCEPTION;
        patient_id_ex EXCEPTION;
        doctor_id_ex EXCEPTION;
        self_ex EXCEPTION;
        already_exist_ex EXCEPTION;
        pre_exist_count NUMBER;
    BEGIN
        v_patient_id := pk_authentication.authenticate_patient(a_user_name, a_user_password);
        IF ( v_patient_id < 1 ) THEN
            RAISE unauthorized_ex;
        END IF;
        IF ( is_allergy_exist(v_allergy_id) < 1 ) THEN
            RAISE allergy_id_ex;
        END IF;
        IF ( is_user_exist(v_patient_id) < 1 ) THEN
            RAISE patient_id_ex;
        END IF;
        SELECT
            COUNT(1)
        INTO pre_exist_count
        FROM
            allergies_patient
        WHERE
                allergy_id = v_allergy_id
            AND patient_id = v_patient_id;

        IF ( pre_exist_count > 0 ) THEN
            RAISE already_exist_ex;
        END IF;
        INSERT INTO allergies_patient (
            allergy_id,
            patient_id,
            notes
        ) VALUES (
            v_allergy_id,
            v_patient_id,
            v_notes
        );

        COMMIT;
    EXCEPTION
        WHEN allergy_id_ex THEN
            status := 'ERROR: Invalid Allergy ID';
        WHEN patient_id_ex THEN
            status := 'ERROR: Invalid Patient ID';
        WHEN already_exist_ex THEN
            status := 'ERROR: Patient already has a record of this allergy';
        WHEN unauthorized_ex THEN
            status := 'ERROR: User Unauthorized';
        WHEN OTHERS THEN
            status := 'ERROR: ' || sqlerrm;
    END pr_insert_alergies_patient;

    PROCEDURE pr_insert_habit_patient (
        a_user_name          IN VARCHAR2,
        a_user_password      IN VARCHAR2,
        v_habit_id           IN habits_patient.habit_id%TYPE,
        v_frequency_per_week IN habits_patient.frequency_per_week%TYPE,
        v_notes              IN habits_patient.notes%TYPE,
        status               OUT VARCHAR2
    ) IS
        v_patient_id    NUMBER;
        unauthorized_ex EXCEPTION;
        habit_id_ex EXCEPTION;
        patient_id_ex EXCEPTION;
        frequency_less_than_one_ex EXCEPTION;
        pre_exist_count NUMBER;
    BEGIN
        v_patient_id := pk_authentication.authenticate_patient(a_user_name, a_user_password);
        IF ( v_patient_id < 1 ) THEN
            RAISE unauthorized_ex;
        END IF;
        IF ( is_habit_exist(v_habit_id) < 1 ) THEN
            RAISE habit_id_ex;
        END IF;
        IF ( is_user_exist(v_patient_id) < 1 ) THEN
            RAISE patient_id_ex;
        END IF;
        IF ( v_frequency_per_week < 1 ) THEN
            RAISE frequency_less_than_one_ex;
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
            UPDATE habits_patient
            SET
                frequency_per_week = v_frequency_per_week,
                is_active = 'Y',
                notes = v_notes
            WHERE
                    habit_id = v_habit_id
                AND patient_id = v_patient_id;

            status := 'Success: Previously existing record updated';
        ELSE
            INSERT INTO habits_patient (
                habit_id,
                patient_id,
                frequency_per_week,
                notes
            ) VALUES (
                v_habit_id,
                v_patient_id,
                v_frequency_per_week,
                v_notes
            );

            status := 'Success: New record inserted';
        END IF;

        COMMIT;
    EXCEPTION
        WHEN habit_id_ex THEN
            status := 'ERROR: Invalid Habit ID';
        WHEN patient_id_ex THEN
            status := 'ERROR: Invalid Patient ID';
        WHEN frequency_less_than_one_ex THEN
            status := 'ERROR: Frequency cannot be less than 1';
        WHEN unauthorized_ex THEN
            status := 'ERROR: User Unauthorized';
        WHEN OTHERS THEN
            status := 'ERROR: ' || sqlerrm;
    END pr_insert_habit_patient;

    PROCEDURE pr_insert_symptom_patient (
        a_user_name     IN VARCHAR2,
        a_user_password IN VARCHAR2,
        v_symptom_id    IN symptom_patient.symptom_id%TYPE,
        v_notes         IN symptom_patient.notes%TYPE,
        status          OUT VARCHAR2
    ) IS
        v_patient_id    NUMBER;
        unauthorized_ex EXCEPTION;
        symptom_id_ex EXCEPTION;
        patient_id_ex EXCEPTION;
        pre_exist_count NUMBER;
    BEGIN
        v_patient_id := pk_authentication.authenticate_patient(a_user_name, a_user_password);
        IF ( v_patient_id < 1 ) THEN
            RAISE unauthorized_ex;
        END IF;
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
            UPDATE symptom_patient
            SET
                is_active = 'Y',
                notes = v_notes
            WHERE
                    symptom_id = v_symptom_id
                AND patient_id = v_patient_id;

            status := 'Success: Previously existing record updated';
        ELSE
            INSERT INTO symptom_patient (
                symptom_id,
                patient_id,
                notes
            ) VALUES (
                v_symptom_id,
                v_patient_id,
                v_notes
            );

        END IF;

        COMMIT;
    EXCEPTION
        WHEN symptom_id_ex THEN
            status := 'ERROR: Invalid Symptom ID';
        WHEN patient_id_ex THEN
            status := 'ERROR: Invalid Patient ID';
        WHEN unauthorized_ex THEN
            status := 'ERROR: User Unauthorized';
        WHEN OTHERS THEN
            status := 'ERROR: ' || sqlerrm;
    END pr_insert_symptom_patient;

    PROCEDURE pr_insert_family (
        a_user_name     IN VARCHAR2,
        a_user_password IN VARCHAR2,
        v_relative_id   IN family.relative_id%TYPE,
        status          OUT VARCHAR2
    ) IS
        v_patient_id    NUMBER;
        unauthorized_ex EXCEPTION;
        relative_id_ex EXCEPTION;
        patient_id_ex EXCEPTION;
        self_ex EXCEPTION;
        pre_exist_count NUMBER;
    BEGIN
        v_patient_id := pk_authentication.authenticate_patient(a_user_name, a_user_password);
        IF ( v_patient_id < 1 ) THEN
            RAISE unauthorized_ex;
        END IF;
        IF ( is_user_exist(v_relative_id) < 1 ) THEN
            RAISE relative_id_ex;
        END IF;
        IF ( is_user_exist(v_patient_id) < 1 ) THEN
            RAISE patient_id_ex;
        END IF;
        IF ( v_patient_id = v_relative_id ) THEN
            RAISE self_ex;
        END IF;
        SELECT
            COUNT(1)
        INTO pre_exist_count
        FROM
            family
        WHERE
            ( relative_id = v_relative_id
              AND patient_id = v_patient_id )
            OR ( relative_id = v_patient_id
                 AND patient_id = v_relative_id );

        IF ( pre_exist_count > 0 ) THEN
            status := 'Error: Relation already exists';
        ELSE
            INSERT INTO family (
                patient_id,
                relative_id
            ) VALUES (
                v_patient_id,
                v_relative_id
            );

        END IF;

        COMMIT;
    EXCEPTION
        WHEN relative_id_ex THEN
            status := 'ERROR: Invalid Relative ID';
        WHEN patient_id_ex THEN
            status := 'ERROR: Invalid Patient ID';
        WHEN self_ex THEN
            status := 'ERROR: Patient id and relative id cannot be same';
        WHEN unauthorized_ex THEN
            status := 'ERROR: User Unauthorized';
        WHEN OTHERS THEN
            status := 'ERROR: ' || sqlerrm;
    END pr_insert_family;

    PROCEDURE pr_patient_report (
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
        pr_view_patient_habits(v_patient_id);
        pr_view_patient_vaccine_details(v_patient_id);
        pr_view_patient_family_history(v_patient_id);

-- ALLERGIES

        pr_view_patient_allergies_details(v_patient_id);
    EXCEPTION
        WHEN patient_id_ex THEN
            status := 'ERROR: Invalid Patient ID';
        WHEN OTHERS THEN
            status := 'ERROR: ' || sqlerrm;
    END pr_patient_report;

END pk_patient;

/

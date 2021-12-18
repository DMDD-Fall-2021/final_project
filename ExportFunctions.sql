--------------------------------------------------------
--  File created - Saturday-December-18-2021   
--------------------------------------------------------
DROP FUNCTION "AUTHENTICATE";
DROP FUNCTION "IS_DISEASE_EXIST";
DROP FUNCTION "IS_SYMPTOM_EXIST";
DROP FUNCTION "IS_COUNTRY_EXIST";
DROP FUNCTION "IS_VACCINE_EXIST";
DROP FUNCTION "IS_ROLE_MAPPED_USER";
DROP FUNCTION "FN_IS_VALID_VISIT_RECORD";
DROP FUNCTION "IS_ETHNICITY_EXIST";
DROP FUNCTION "IS_HABIT_EXIST";
DROP FUNCTION "IS_MEDICINE_EXIST";
DROP FUNCTION "IS_DIET_EXIST";
DROP FUNCTION "IS_APP_ROLE_EXIST";
DROP FUNCTION "FN_IS_VALID_ILLNESS_RECORD";
DROP FUNCTION "FN_GET_USER_NAME";
DROP FUNCTION "IS_LOCATION_STATISTICS_EXIST";
DROP FUNCTION "IS_ZIPCODE_EXIST";
DROP FUNCTION "IS_USER_EXIST";
DROP FUNCTION "IS_APP_USER_EXIST";
DROP FUNCTION "IS_ALLERGY_EXIST";
--------------------------------------------------------
--  DDL for Function AUTHENTICATE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "AUTHENTICATE" (
    V_ROLE_ID app_user.role_id%TYPE,
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
        AND user_password = pk_authentication.encrypt_val( v_user_password)
        and role_id = V_ROLE_ID;

    IF ( exist_count > 0 ) THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END;

/
--------------------------------------------------------
--  DDL for Function IS_DISEASE_EXIST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "IS_DISEASE_EXIST" 
(
  DISEASE_ID_INPUT IN NUMBER 
) RETURN NUMBER IS
  DISEASE_COUNT NUMBER;
BEGIN
  SELECT
    COUNT(1) "DISEASE_COUNT"
  INTO DISEASE_COUNT
  FROM
    DISEASES d
  WHERE
    d.disease_id=DISEASE_ID_INPUT;
  RETURN DISEASE_COUNT;
END IS_DISEASE_EXIST;

/
--------------------------------------------------------
--  DDL for Function IS_SYMPTOM_EXIST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "IS_SYMPTOM_EXIST" 
(
  SYMPTOM_ID_INPUT IN NUMBER 
) RETURN NUMBER IS
  SYMPTOM_COUNT NUMBER;
BEGIN
    SELECT
    COUNT(1) "SYMPTOM_COUNT"
  INTO SYMPTOM_COUNT
  FROM
    SYMPTOMS s
  WHERE
    s.symptom_id=SYMPTOM_ID_INPUT;
  RETURN SYMPTOM_COUNT;
END IS_SYMPTOM_EXIST;

/
--------------------------------------------------------
--  DDL for Function IS_COUNTRY_EXIST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "IS_COUNTRY_EXIST" 
(
  COUNTRY_ID_INPUT IN NUMBER 
) RETURN NUMBER IS
  COUNTRY_COUNT NUMBER;
BEGIN
  SELECT
    COUNT(1) "COUNTRY_COUNT"
  INTO COUNTRY_COUNT
  FROM
    COUNTRY c
  WHERE
    c.country_code=COUNTRY_ID_INPUT;
  RETURN COUNTRY_COUNT;
END IS_COUNTRY_EXIST;

/
--------------------------------------------------------
--  DDL for Function IS_VACCINE_EXIST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "IS_VACCINE_EXIST" 
(
  VACCINE_ID_INPUT IN VARCHAR2 
) RETURN NUMBER IS
  VACCINE_COUNT NUMBER;
BEGIN
  SELECT
    COUNT(1) "VACCINE_COUNT"
  INTO VACCINE_COUNT
  FROM
    vaccine v
  WHERE
    v.vaccine_id=VACCINE_ID_INPUT;
  RETURN VACCINE_COUNT;
END IS_VACCINE_EXIST;

/
--------------------------------------------------------
--  DDL for Function IS_ROLE_MAPPED_USER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "IS_ROLE_MAPPED_USER" 
(
  USER_ID_INPUT IN NUMBER 
, ROLE_ID_INPUT IN NUMBER 
) RETURN NUMBER IS
  APP_USER_COUNT NUMBER;
BEGIN
  SELECT
    COUNT(1) "APP_USER_COUNT"
  INTO APP_USER_COUNT
  FROM
    APP_USER au
  WHERE
    au.user_id=USER_ID_INPUT and ROLE_ID_INPUT in (SELECT role_id from APP_USER where user_id=USER_ID_INPUT);
  RETURN APP_USER_COUNT;
END IS_ROLE_MAPPED_USER;

/
--------------------------------------------------------
--  DDL for Function FN_IS_VALID_VISIT_RECORD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "FN_IS_VALID_VISIT_RECORD" (
    VISIT_ID_IN IN visit_history.visit_id%TYPE
) RETURN NUMBER
IS

    R_COUNT NUMBER := 0;

BEGIN
    SELECT COUNT(*) INTO R_COUNT 
    FROM VISIT_HISTORY VH
    WHERE vh.visit_id = VISIT_ID_IN;

    RETURN R_COUNT;
END;

/
--------------------------------------------------------
--  DDL for Function IS_ETHNICITY_EXIST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "IS_ETHNICITY_EXIST" 
(
  ETHNICITY_ID_INPUT IN VARCHAR2 
) RETURN NUMBER IS
  ETHNICITY_COUNT NUMBER;
BEGIN
  SELECT
    COUNT(1) "ETHNICITY_COUNT"
  INTO ETHNICITY_COUNT
  FROM
    ETHNICITY e
  WHERE
    e.ethnicity_id=ETHNICITY_ID_INPUT;
  RETURN ETHNICITY_COUNT;
END IS_ETHNICITY_EXIST;

/
--------------------------------------------------------
--  DDL for Function IS_HABIT_EXIST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "IS_HABIT_EXIST" 
(
  HABIT_ID_EXIST IN VARCHAR2 
) RETURN NUMBER IS
  HABIT_COUNT NUMBER;
BEGIN
    SELECT
    COUNT(1) "HABIT_COUNT"
  INTO HABIT_COUNT
  FROM
    HABIT h
  WHERE
    h.habit_id=HABIT_ID_EXIST;
  RETURN HABIT_COUNT;
END IS_HABIT_EXIST;

/
--------------------------------------------------------
--  DDL for Function IS_MEDICINE_EXIST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "IS_MEDICINE_EXIST" 
(
  MEDICINE_ID_INPUT IN NUMBER 
) RETURN NUMBER IS
  MEDICINE_COUNT NUMBER;
BEGIN
    SELECT
    COUNT(1) "MEDICINE_COUNT"
  INTO MEDICINE_COUNT
  FROM
    MEDICINES m
  WHERE
    m.medicine_id=MEDICINE_ID_INPUT;
  RETURN MEDICINE_COUNT;
END IS_MEDICINE_EXIST;

/
--------------------------------------------------------
--  DDL for Function IS_DIET_EXIST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "IS_DIET_EXIST" 
(
  DIET_ID_INPUT IN NUMBER 
) RETURN NUMBER IS
  DIET_COUNT NUMBER; 
BEGIN
  SELECT
    COUNT(1) "DIET_COUNT"
  INTO DIET_COUNT
  FROM
    DIET d
  WHERE
    d.diet_id=DIET_ID_INPUT;
  RETURN DIET_COUNT;
END IS_DIET_EXIST;

/
--------------------------------------------------------
--  DDL for Function IS_APP_ROLE_EXIST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "IS_APP_ROLE_EXIST" 
(
  ROLE_ID_INPUT IN NUMBER 
) RETURN NUMBER IS
  ROLE_COUNT NUMBER;
BEGIN
  SELECT
    COUNT(1) "ROLE_COUNT"
  INTO ROLE_COUNT
  FROM
    APP_ROLE ar
  WHERE
    ar.role_id=ROLE_ID_INPUT;
  RETURN ROLE_COUNT;
END IS_APP_ROLE_EXIST;

/
--------------------------------------------------------
--  DDL for Function FN_IS_VALID_ILLNESS_RECORD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "FN_IS_VALID_ILLNESS_RECORD" (
    DP_ID_IN IN visit_history.dp_id%TYPE
) RETURN VARCHAR2
IS

    R_COUNT NUMBER := 0;

BEGIN
    SELECT COUNT(*) INTO R_COUNT 
    FROM DISEASE_PATIENT DP
    WHERE dp.dp_id = DP_ID_IN;

    IF(R_COUNT = 0) THEN
        RETURN 'N';
    ELSE
        RETURN 'Y';
    END IF;        
END;

/
--------------------------------------------------------
--  DDL for Function FN_GET_USER_NAME
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "FN_GET_USER_NAME" (
  USER_ID_INPUT IN NUMBER,
  ROLE_ID_INPUT in number
) RETURN VARCHAR2 IS
  USER_NAME_OUT NUMBER;
BEGIN
  SELECT
    USER_NAME as "USER_NAME_OUT"
  INTO USER_NAME_OUT
  FROM
    APP_USER au
  WHERE
    au.user_id=USER_ID_INPUT and
    au.role_id = ROLE_ID_INPUT;
    
  DBMS_OUTPUT.put_line(USER_NAME_OUT);
  RETURN USER_NAME_OUT;
END FN_GET_USER_NAME;

/
--------------------------------------------------------
--  DDL for Function IS_LOCATION_STATISTICS_EXIST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "IS_LOCATION_STATISTICS_EXIST" 
(
  STATISTICS_ID_INPUT IN NUMBER 
) RETURN NUMBER IS
    LOCATION_STATISTICS_COUNT NUMBER;
BEGIN
  SELECT
    COUNT(1) "LOCATION_STATISTICS_COUNT"
  INTO LOCATION_STATISTICS_COUNT
  FROM
    location_statistics l
  WHERE
    l.location_code=STATISTICS_ID_INPUT;
  RETURN LOCATION_STATISTICS_COUNT;
END IS_LOCATION_STATISTICS_EXIST;

/
--------------------------------------------------------
--  DDL for Function IS_ZIPCODE_EXIST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "IS_ZIPCODE_EXIST" 
(
  ZIP_ID_INPUT IN NUMBER 
) RETURN NUMBER IS
    ZIP_COUNT NUMBER;
BEGIN
  SELECT
    COUNT(1) "ZIP_COUNT"
  INTO ZIP_COUNT
  FROM
    ZIPCODE z
  WHERE
    z.zip_id=ZIP_ID_INPUT;
  RETURN ZIP_COUNT;
END IS_ZIPCODE_EXIST;

/
--------------------------------------------------------
--  DDL for Function IS_USER_EXIST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "IS_USER_EXIST" 
(
  USER_ID_INPUT IN NUMBER 
) RETURN NUMBER IS
  USER_COUNT NUMBER;
BEGIN
  SELECT
    COUNT(1) "USER_COUNT"
  INTO USER_COUNT
  FROM
    USER_DETAILS u
  WHERE
    u.user_id=USER_ID_INPUT;
  RETURN USER_COUNT;
END IS_USER_EXIST;

/
--------------------------------------------------------
--  DDL for Function IS_APP_USER_EXIST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "IS_APP_USER_EXIST" 
(
  APP_USER_ID_INPUT IN NUMBER 
) RETURN NUMBER IS
  APP_USER_COUNT NUMBER;
BEGIN
  SELECT
    COUNT(1) "APP_USER_COUNT"
  INTO APP_USER_COUNT
  FROM
    APP_USER au
  WHERE
    au.user_id=APP_USER_ID_INPUT;
  RETURN APP_USER_COUNT;
END IS_APP_USER_EXIST;

/
--------------------------------------------------------
--  DDL for Function IS_ALLERGY_EXIST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "IS_ALLERGY_EXIST" 
(
  ALLERGY_ID_INPUT IN NUMBER 
) RETURN NUMBER IS
  ALLERGY_COUNT NUMBER;
BEGIN
  SELECT
    COUNT(1) "ALLERGY_COUNT"
  INTO ALLERGY_COUNT
  FROM
    ALLERGIES a
  WHERE
    a.allergy_id=ALLERGY_ID_INPUT;
  RETURN ALLERGY_COUNT;
END IS_ALLERGY_EXIST;

/

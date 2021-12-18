set SERVEROUTPUT ON;
DECLARE
    VISIT_ID_IN visit_history.visit_id%TYPE;
    DP_ID_IN  visit_history.dp_id%TYPE;
    DOCTOR_ID_IN  visit_history.doctor_id%TYPE;
    VISIT_NOTES_IN  visit_history.visit_notes%TYPE;
    PASSWORD_IN  varchar2(150);
    VACCINE_ID_IN vaccine_patient.vaccine_id%TYPE;
    PATIENT_ID_IN vaccine_patient.patient_id%TYPE;
    P_ID_IN  PRESCRIPTION.P_ID%TYPE;
    MEDICINE_ID_IN  prescription.medicine_id%TYPE;
    DOSAGE_IN  prescription.dosage%TYPE;
    FREQUENCY_IN  prescription.frequency%TYPE;
    END_DATE_IN  PRESCRIPTION.DATE_ENDED%TYPE;
    NOTES_IN  PRESCRIPTION.NOTES%TYPE;
    STATUS  VARCHAR2(1000);
    MESSAGE  VARCHAR2(1000);
    

    

BEGIN
    
    DBMS_OUTPUT.PUT_LINE('********TEST CASE EXECUTION********');
    DBMS_OUTPUT.PUT_LINE('---TEST FOR PR_ADD_UPDATE_VISIT_HISTORY---');
    DBMS_OUTPUT.PUT_LINE('##Senario: When all fields are null##');
    
    VISIT_ID_IN := NULL;
    DP_ID_IN := NULL;
    DOCTOR_ID_IN := NULL;
    VISIT_NOTES_IN := NULL;
    PASSWORD_IN := NULL;
    
    PK_DOCTOR.PR_ADD_UPDATE_VISIT_HISTORY (
        VISIT_ID_IN,
        DP_ID_IN,
        DOCTOR_ID_IN,
        VISIT_NOTES_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
    
    DBMS_OUTPUT.PUT_LINE('##Senario: When only DP id is null##');
    
    VISIT_ID_IN := NULL;
    DP_ID_IN := NULL;
    DOCTOR_ID_IN := 0;
    VISIT_NOTES_IN := '0';
    PASSWORD_IN := '0';
    
    PK_DOCTOR.PR_ADD_UPDATE_VISIT_HISTORY (
        VISIT_ID_IN,
        DP_ID_IN,
        DOCTOR_ID_IN,
        VISIT_NOTES_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
    DBMS_OUTPUT.PUT_LINE('##Senario: When only DOCTOR ID id is null##');
    
    VISIT_ID_IN := NULL;
    DP_ID_IN := 1; --THIS ID NEEDS TO BE THERE IN SYSTEM
    DOCTOR_ID_IN := NULL;
    VISIT_NOTES_IN := '0';
    PASSWORD_IN := '0';
    
    PK_DOCTOR.PR_ADD_UPDATE_VISIT_HISTORY (
        VISIT_ID_IN,
        DP_ID_IN,
        DOCTOR_ID_IN,
        VISIT_NOTES_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
    
    DBMS_OUTPUT.PUT_LINE('##Senario: When dp id is invalid i.e does not exist in system##');
    
    VISIT_ID_IN := NULL;
    DP_ID_IN := 0; --THIS ID should not BE THERE IN SYSTEM
    DOCTOR_ID_IN := NULL;
    VISIT_NOTES_IN := '0';
    PASSWORD_IN := '0';
    
    PK_DOCTOR.PR_ADD_UPDATE_VISIT_HISTORY (
        VISIT_ID_IN,
        DP_ID_IN,
        DOCTOR_ID_IN,
        VISIT_NOTES_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
    
    DBMS_OUTPUT.PUT_LINE('##Senario: When doctor enters invalid ID and password##');
    
    VISIT_ID_IN := NULL;
    DP_ID_IN := 1; 
    DOCTOR_ID_IN := 70;
    VISIT_NOTES_IN := '0';
    PASSWORD_IN := '0';
    
    PK_DOCTOR.PR_ADD_UPDATE_VISIT_HISTORY (
        VISIT_ID_IN,
        DP_ID_IN,
        DOCTOR_ID_IN,
        VISIT_NOTES_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
    DBMS_OUTPUT.PUT_LINE('##Senario: When doctor enters valid ID and password but invalid VISIT_ID_IN for update ##');
    
    VISIT_ID_IN := 123546;
    DP_ID_IN := 1; 
    DOCTOR_ID_IN := 70;
    VISIT_NOTES_IN := 'abcd';
    PASSWORD_IN := 'D_70';
    
    PK_DOCTOR.PR_ADD_UPDATE_VISIT_HISTORY (
        VISIT_ID_IN,
        DP_ID_IN,
        DOCTOR_ID_IN,
        VISIT_NOTES_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
    
    DBMS_OUTPUT.PUT_LINE('---TEST FOR PR_DELETE_VISIT_HISTORY---');
    DBMS_OUTPUT.PUT_LINE('##Senario: When all input fields are null ##');
    
    VISIT_ID_IN := null;
    DP_ID_IN := null; 
    DOCTOR_ID_IN := null;
    VISIT_NOTES_IN := null;
    PASSWORD_IN := null;
    
    PK_DOCTOR.PR_DELETE_VISIT_HISTORY(
        DOCTOR_ID_IN,
        VISIT_ID_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
    DBMS_OUTPUT.PUT_LINE('##Senario: When user credentials are invalid ##');
    
    VISIT_ID_IN := 123456;
    DP_ID_IN := null; 
    DOCTOR_ID_IN := 70;
    VISIT_NOTES_IN := null;
    PASSWORD_IN := '0';
    
    PK_DOCTOR.PR_DELETE_VISIT_HISTORY(
        DOCTOR_ID_IN,
        VISIT_ID_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
    DBMS_OUTPUT.PUT_LINE('##Senario: When record does not exist ##');
    
    VISIT_ID_IN := 123456;
    DP_ID_IN := null; 
    DOCTOR_ID_IN := 70;
    VISIT_NOTES_IN := null;
    PASSWORD_IN := 'D_70';
    
    PK_DOCTOR.PR_DELETE_VISIT_HISTORY(
        DOCTOR_ID_IN,
        VISIT_ID_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
    
    DBMS_OUTPUT.PUT_LINE('---TEST FOR PR_ADD_VACCINE_RECORD---');
    DBMS_OUTPUT.PUT_LINE('##Senario: When all input fields are null ##');
    
    VISIT_ID_IN := null;
    DP_ID_IN := null; 
    DOCTOR_ID_IN := null;
    VISIT_NOTES_IN := null;
    PASSWORD_IN := null;
    VACCINE_ID_IN := null;
    PATIENT_ID_IN := null;
    
    PK_DOCTOR.PR_ADD_VACCINE_RECORD  (
        VACCINE_ID_IN,
        PATIENT_ID_IN,
        DOCTOR_ID_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
    DBMS_OUTPUT.PUT_LINE('##Senario: When invalid vaccine ID is provided ##');
    
    VISIT_ID_IN := null;
    DP_ID_IN := null; 
    DOCTOR_ID_IN := 70;
    VISIT_NOTES_IN := null;
    PASSWORD_IN := 'D_70';
    VACCINE_ID_IN := 3216546;
    PATIENT_ID_IN := 1;
    
    PK_DOCTOR.PR_ADD_VACCINE_RECORD  (
        VACCINE_ID_IN,
        PATIENT_ID_IN,
        DOCTOR_ID_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
    DBMS_OUTPUT.PUT_LINE('##Senario: When invalid patient details is provided ##');
    
    VISIT_ID_IN := null;
    DP_ID_IN := null; 
    DOCTOR_ID_IN := 70;
    VISIT_NOTES_IN := null;
    PASSWORD_IN := 'D_70';
    VACCINE_ID_IN := 1;
    PATIENT_ID_IN := 156465468;
    
    PK_DOCTOR.PR_ADD_VACCINE_RECORD  (
        VACCINE_ID_IN,
        PATIENT_ID_IN,
        DOCTOR_ID_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
     DBMS_OUTPUT.PUT_LINE('##Senario: When invalid credentials are provided ##');
    
    VISIT_ID_IN := null;
    DP_ID_IN := null; 
    DOCTOR_ID_IN := 70;
    VISIT_NOTES_IN := null;
    PASSWORD_IN := '0';
    VACCINE_ID_IN := 1;
    PATIENT_ID_IN := 1;
    
    PK_DOCTOR.PR_ADD_VACCINE_RECORD  (
        VACCINE_ID_IN,
        PATIENT_ID_IN,
        DOCTOR_ID_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
    DBMS_OUTPUT.PUT_LINE('##Senario: When vaccine is already administered ##');
    
    VISIT_ID_IN := null;
    DP_ID_IN := null; 
    DOCTOR_ID_IN := 70;
    VISIT_NOTES_IN := null;
    PASSWORD_IN := 'D_70';
    VACCINE_ID_IN := 2;
    PATIENT_ID_IN := 1;
    
    PK_DOCTOR.PR_ADD_VACCINE_RECORD  (
        VACCINE_ID_IN,
        PATIENT_ID_IN,
        DOCTOR_ID_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
    
    DBMS_OUTPUT.PUT_LINE('---TEST FOR PR_DELETE_VACCINE_RECORD---');
    DBMS_OUTPUT.PUT_LINE('##Senario: When all input fields are null ##');
    
    VISIT_ID_IN := null;
    DP_ID_IN := null; 
    DOCTOR_ID_IN := null;
    VISIT_NOTES_IN := null;
    PASSWORD_IN := null;
    VACCINE_ID_IN := null;
    PATIENT_ID_IN := null;
    
    PK_DOCTOR.PR_DELETE_VACCINE_RECORD (
        VACCINE_ID_IN,
        PATIENT_ID_IN,
        DOCTOR_ID_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
    DBMS_OUTPUT.PUT_LINE('##Senario: When vaccine records arent found ##');
    
    VISIT_ID_IN := null;
    DP_ID_IN := null; 
    DOCTOR_ID_IN := 70;
    VISIT_NOTES_IN := null;
    PASSWORD_IN := 'D_70';
    VACCINE_ID_IN := 1234345;
    PATIENT_ID_IN := 4353453;
    
    PK_DOCTOR.PR_DELETE_VACCINE_RECORD (
        VACCINE_ID_IN,
        PATIENT_ID_IN,
        DOCTOR_ID_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
    DBMS_OUTPUT.PUT_LINE('---TEST FOR PR_ADD_UPDATE_PRESCRIPTION---');
    DBMS_OUTPUT.PUT_LINE('##Senario: When all input fields are null ##');
    
    VISIT_ID_IN := null;
    DP_ID_IN  := null;
    DOCTOR_ID_IN  := null;
    VISIT_NOTES_IN  := null;
    PASSWORD_IN  := null;
    VACCINE_ID_IN := null;
    PATIENT_ID_IN := null;
    P_ID_IN  := null;
    MEDICINE_ID_IN  := null;
    DOSAGE_IN  := null;
    FREQUENCY_IN  := null;
    END_DATE_IN := null;
    NOTES_IN := null;
    
    
    PK_DOCTOR.PR_ADD_UPDATE_PRESCRIPTION (
        P_ID_IN,
        VISIT_ID_IN,
        DOCTOR_ID_IN,
        PATIENT_ID_IN,
        MEDICINE_ID_IN,
        DOSAGE_IN,
        FREQUENCY_IN,
        END_DATE_IN,
        NOTES_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
    
    DBMS_OUTPUT.PUT_LINE('##Senario: When all input fields are null ##');
    
    VISIT_ID_IN := null;
    DP_ID_IN  := null;
    DOCTOR_ID_IN  := null;
    VISIT_NOTES_IN  := null;
    PASSWORD_IN  := null;
    VACCINE_ID_IN := null;
    PATIENT_ID_IN := null;
    P_ID_IN  := null;
    MEDICINE_ID_IN  := null;
    DOSAGE_IN  := null;
    FREQUENCY_IN  := null;
    END_DATE_IN := null;
    NOTES_IN := null;
    
    
    PK_DOCTOR.PR_ADD_UPDATE_PRESCRIPTION (
        P_ID_IN,
        VISIT_ID_IN,
        DOCTOR_ID_IN,
        PATIENT_ID_IN,
        MEDICINE_ID_IN,
        DOSAGE_IN,
        FREQUENCY_IN,
        END_DATE_IN,
        NOTES_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
    DBMS_OUTPUT.PUT_LINE('##Senario: When frequency is null ##');
    
    VISIT_ID_IN := 213;
    DP_ID_IN  := 123;
    DOCTOR_ID_IN  := 123;
    VISIT_NOTES_IN  := null;
    PASSWORD_IN  := '0';
    VACCINE_ID_IN := 123;
    PATIENT_ID_IN := 123;
    P_ID_IN  := 123;
    MEDICINE_ID_IN  := 1;
    DOSAGE_IN  := '250 mg';
    FREQUENCY_IN  := null;
    END_DATE_IN := sysdate+3;
    NOTES_IN := null;
    
    
    PK_DOCTOR.PR_ADD_UPDATE_PRESCRIPTION (
        P_ID_IN,
        VISIT_ID_IN,
        DOCTOR_ID_IN,
        PATIENT_ID_IN,
        MEDICINE_ID_IN,
        DOSAGE_IN,
        FREQUENCY_IN,
        END_DATE_IN,
        NOTES_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
    
    DBMS_OUTPUT.PUT_LINE('##When user credentials are invalid ##');
    
    VISIT_ID_IN := 213;
    DP_ID_IN  := 123;
    DOCTOR_ID_IN  := 123;
    VISIT_NOTES_IN  := null;
    PASSWORD_IN  := '0';
    VACCINE_ID_IN := 123;
    PATIENT_ID_IN := 123;
    P_ID_IN  := 123;
    MEDICINE_ID_IN  := 1;
    DOSAGE_IN  := '250 mg';
    FREQUENCY_IN  := 23;
    END_DATE_IN := sysdate+3;
    NOTES_IN := null;
    
    
    PK_DOCTOR.PR_ADD_UPDATE_PRESCRIPTION (
        P_ID_IN,
        VISIT_ID_IN,
        DOCTOR_ID_IN,
        PATIENT_ID_IN,
        MEDICINE_ID_IN,
        DOSAGE_IN,
        FREQUENCY_IN,
        END_DATE_IN,
        NOTES_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
     DBMS_OUTPUT.PUT_LINE('##When Patient details isnt found ##');
    
    VISIT_ID_IN := 213;
    DP_ID_IN  := 123;
    DOCTOR_ID_IN  := 70;
    VISIT_NOTES_IN  := null;
    PASSWORD_IN  := 'D_70';
    VACCINE_ID_IN := 123;
    PATIENT_ID_IN := 12356465;
    P_ID_IN  := 123;
    MEDICINE_ID_IN  := 1;
    DOSAGE_IN  := '250 mg';
    FREQUENCY_IN  := 23;
    END_DATE_IN := sysdate+3;
    NOTES_IN := null;
    
    
    PK_DOCTOR.PR_ADD_UPDATE_PRESCRIPTION (
        P_ID_IN,
        VISIT_ID_IN,
        DOCTOR_ID_IN,
        PATIENT_ID_IN,
        MEDICINE_ID_IN,
        DOSAGE_IN,
        FREQUENCY_IN,
        END_DATE_IN,
        NOTES_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
    DBMS_OUTPUT.PUT_LINE('##When End date is less than sysdate ##');
    
    VISIT_ID_IN := 213;
    DP_ID_IN  := 123;
    DOCTOR_ID_IN  := 70;
    VISIT_NOTES_IN  := null;
    PASSWORD_IN  := 'D_70';
    VACCINE_ID_IN := 123;
    PATIENT_ID_IN := 69;
    P_ID_IN  := 123;
    MEDICINE_ID_IN  := 1;
    DOSAGE_IN  := '250 mg';
    FREQUENCY_IN  := 23;
    END_DATE_IN := sysdate-3;
    NOTES_IN := null;
    
    
    PK_DOCTOR.PR_ADD_UPDATE_PRESCRIPTION (
        P_ID_IN,
        VISIT_ID_IN,
        DOCTOR_ID_IN,
        PATIENT_ID_IN,
        MEDICINE_ID_IN,
        DOSAGE_IN,
        FREQUENCY_IN,
        END_DATE_IN,
        NOTES_IN,
        PASSWORD_IN,
        STATUS,
        MESSAGE
    );
    
    DBMS_OUTPUT.PUT_LINE('Expected Status: F | Actual Status: ' || status);
    DBMS_OUTPUT.PUT_LINE('Actual Message: ' || MESSAGE);
    
END;


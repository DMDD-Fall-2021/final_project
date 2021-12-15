DROP VIEW "CITY_WISE_ACTIVE_CASE";
DROP VIEW "CITY_WISE_PATIENT";
DROP VIEW "DISEASE_ACTIVE_CASES";
DROP VIEW "TOP_3_HEALTIEST_CITIES";
DROP VIEW "ZIP_WISE_ACTIVE_CASE";
--------------------------------------------------------
--  DDL for View CITY_WISE_ACTIVE_CASE
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "CITY_WISE_ACTIVE_CASE" ("DISEASE_NAME", "CITY", "TOTAL_CASES") DEFAULT COLLATION "USING_NLS_COMP"  AS 
  SELECT DISEASE_NAME AS DISEASE_NAME, CITY AS CITY, SUM(CASES) AS TOTAL_CASES FROM zip_wise_active_case
GROUP BY DISEASE_NAME, CITY
;
--------------------------------------------------------
--  DDL for View CITY_WISE_PATIENT
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "CITY_WISE_PATIENT" ("CITY", "VACCINE_NAME", "VACCINATED_PEOPLE") DEFAULT COLLATION "USING_NLS_COMP"  AS 
  select z.city,v.vaccine_name, count(1) vaccinated_people from patient_details pd, zipcode z, vaccine_patient vp, vaccine v 
where vp.patient_id = pd.patient_id 
and v.vaccine_id = vp.vaccine_id
and pd.zip_id = z.zip_id 
group by z.city, v.vaccine_name
order by z.city, v.vaccine_name
;
--------------------------------------------------------
--  DDL for View DISEASE_ACTIVE_CASES
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "DISEASE_ACTIVE_CASES" ("DISEASE_NAME", "CASES") DEFAULT COLLATION "USING_NLS_COMP"  AS 
  SELECT d.disease_name AS disease_name, COUNT(*) AS CASES FROM DISEASES D, disease_patient DP
WHERE D.DISEASE_ID = dp.disease_id
GROUP BY d.disease_name
;
--------------------------------------------------------
--  DDL for View TOP_3_HEALTIEST_CITIES
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "TOP_3_HEALTIEST_CITIES" ("CITY") DEFAULT COLLATION "USING_NLS_COMP"  AS 
  select city from
(select city, sum(total_cases) as total_cases from city_wise_active_case
group by city order by total_cases) 
where rownum < 4
;
--------------------------------------------------------
--  DDL for View ZIP_WISE_ACTIVE_CASE
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "ZIP_WISE_ACTIVE_CASE" ("DISEASE_NAME", "ZIP_ID", "CITY", "COUNTY", "COUNTRY", "CASES") DEFAULT COLLATION "USING_NLS_COMP"  AS 
  SELECT d.disease_name AS disease_name, z.zip_id AS ZIP_ID, z.city AS CITY, z.county AS COUNTY, c.country_name AS COUNTRY ,COUNT(*) AS CASES FROM DISEASES D, disease_patient DP, patient_details pd, zipcode z, country C
WHERE D.DISEASE_ID = dp.disease_id
AND dp.patient_id = pd.patient_id
AND pd.zip_id = z.zip_id
AND z.country_code = c.country_code
GROUP BY d.disease_name, Z.zip_id, z.city, z.county, c.country_name
ORDER BY d.disease_name, z.zip_id
;

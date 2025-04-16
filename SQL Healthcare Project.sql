CREATE DATABASE hospital_analytics;
USE hospital_analytics;

-- Patients Table
CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(10),
    date_of_birth DATE,
    contact_number VARCHAR(20),
    email VARCHAR(100)
);

-- Admissions Table
CREATE TABLE admissions (
    admission_id INT PRIMARY KEY,
    patient_id INT,
    department VARCHAR(50),
    admission_date DATE,
    discharge_date DATE,
    reason_for_admission VARCHAR(100),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- Diagnoses Table
CREATE TABLE diagnoses (
    diagnosis_id INT PRIMARY KEY,
    admission_id INT,
    icd_code VARCHAR(10),
    description TEXT,
    FOREIGN KEY (admission_id) REFERENCES admissions(admission_id)
);

-- Treatments Table
CREATE TABLE treatments (
    treatment_id INT PRIMARY KEY,
    admission_id INT,
    treatment_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    doctor VARCHAR(100),
    FOREIGN KEY (admission_id) REFERENCES admissions(admission_id)
);

-- Readmissions Table
CREATE TABLE readmissions (
    readmission_id INT PRIMARY KEY,
    patient_id INT,
    readmission_date DATE,
    reason VARCHAR(100),
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- Staff Table
CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    name VARCHAR(100),
    role VARCHAR(50),
    department VARCHAR(50),
    contact_number VARCHAR(20)
);

SELECT * FROM patients LIMIT 5;
SELECT * FROM admissions LIMIT 5;
SELECT * FROM diagnoses LIMIT 5;
SELECT * FROM treatments LIMIT 5;
SELECT * FROM readmissions LIMIT 5;
SELECT * FROM staff LIMIT 5;

SELECT COUNT(*) AS total_patients FROM patients;

SELECT department, COUNT(*) AS admission_count
FROM admissions
GROUP BY department
ORDER BY admission_count DESC;

SELECT icd_code, COUNT(*) AS frequency
FROM diagnoses
GROUP BY icd_code
ORDER BY frequency DESC
LIMIT 5;


SELECT DISTINCT p.first_name, p.last_name, r.readmission_date, r.reason
FROM patients p
JOIN readmissions r ON p.patient_id = r.patient_id
ORDER BY r.readmission_date DESC;

SELECT DISTINCT p.first_name, p.last_name, r.readmission_date, r.reason
FROM patients p
JOIN readmissions r ON p.patient_id = r.patient_id
ORDER BY r.readmission_date DESC;

SELECT patients.patient_id
FROM patients
JOIN admissions ON patients.patient_id = admissions.patient_id;

SELECT department,
       AVG(DATEDIFF(discharge_date, admission_date)) AS avg_stay_days
FROM admissions
GROUP BY department;

SELECT department,
       AVG(DATEDIFF(discharge_date, admission_date)) AS avg_stay_days
FROM admissions
GROUP BY department
ORDER BY avg_stay_days DESC;

SELECT
  patients.patient_id,
  patients.first_name,
  patients.last_name,
  admissions.department,
  admissions.reason_for_admission
FROM patients
JOIN admissions ON patients.patient_id = admissions.patient_id
ORDER BY patients.patient_id ASC;

SELECT 
  diagnoses.description,
  admissions.department,
  COUNT(*) AS case_count
FROM diagnoses
JOIN admissions ON diagnoses.admission_id = admissions.admission_id
GROUP BY diagnoses.description, admissions.department
ORDER BY case_count DESC;

SELECT 
  patients.patient_id,
  patients.first_name,
  patients.last_name,
  admissions.department,
  admissions.reason_for_admission,
  COUNT(*) OVER (
    PARTITION BY patients.patient_id, admissions.department, admissions.reason_for_admission
  ) AS admission_count
FROM patients
JOIN admissions ON patients.patient_id = admissions.patient_id
ORDER BY patients.patient_id ASC;

SELECT 
  department,
  COUNT(*) AS admission_count
FROM admissions
GROUP BY department;

SELECT 
  department,
  admission_count,
  RANK() OVER (ORDER BY admission_count DESC) AS department_rank
FROM (
  SELECT 
    department,
    COUNT(*) AS admission_count
  FROM admissions
  GROUP BY department
) AS dept_counts;

INSERT INTO patients (
  patient_id, first_name, last_name, gender, date_of_birth, contact_number, email
)
VALUES (
  102, 'Tarun', 'Kumar', 'Male', '1995-07-22', '999-123-4567', 'tarun@example.com'
);


UPDATE patients
SET email = 'newtarun@email.com'
WHERE patient_id = 102;

DELETE FROM patients
WHERE patient_id = 102;

SELECT MIN(admission_date) AS earliest_admission
FROM admissions;

SELECT MAX(admission_date) AS latest_admission
FROM admissions;

SELECT AVG(DATEDIFF(discharge_date, admission_date)) AS avg_stay
FROM admissions;

SELECT 
  admission_id,
  patient_id,
  admission_date,
  discharge_date,
  DATEDIFF(discharge_date, admission_date) AS stay_length,

  CASE
    WHEN DATEDIFF(discharge_date, admission_date) <= 3 THEN 'Short'
    WHEN DATEDIFF(discharge_date, admission_date) BETWEEN 4 AND 7 THEN 'Medium'
    ELSE 'Long'
  END AS stay_type

FROM admissions
ORDER BY stay_length DESC;

SELECT AVG(DATEDIFF(discharge_date, admission_date)) AS avg_stay
FROM admissions;

SELECT 
  a.admission_id,
  a.patient_id,
  DATEDIFF(a.discharge_date, a.admission_date) AS stay_length
FROM admissions a
WHERE DATEDIFF(a.discharge_date, a.admission_date) >
      (SELECT AVG(DATEDIFF(discharge_date, admission_date)) FROM admissions)
ORDER BY stay_length DESC;


WITH stay_details AS (
  SELECT
    a.admission_id,
    a.patient_id,
    p.first_name,
    p.last_name,
    DATEDIFF(a.discharge_date, a.admission_date) AS stay_length
  FROM admissions a
  JOIN patients p ON a.patient_id = p.patient_id
)

SELECT *
FROM stay_details
WHERE stay_length > 5
ORDER BY stay_length DESC;

WITH dept_stay AS (
  SELECT 
    department,
    SUM(DATEDIFF(discharge_date, admission_date)) AS total_stay_days
  FROM admissions
  GROUP BY department
)

SELECT 
  department,
  total_stay_days,
  RANK() OVER (ORDER BY total_stay_days DESC) AS stay_rank
FROM dept_stay;

SELECT 
  admission_id,
  patient_id,
  admission_date,
  DATEDIFF(discharge_date, admission_date) AS stay_length,

  AVG(DATEDIFF(discharge_date, admission_date)) OVER (
    ORDER BY admission_date
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
  ) AS moving_avg_stay
FROM admissions
ORDER BY admission_date;

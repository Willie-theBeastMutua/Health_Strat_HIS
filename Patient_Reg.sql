DROP DATABASE IF EXISTS PatientRegistration;

CREATE DATABASE PatientRegistration;

USE PatientRegistration;

CREATE TABLE Patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    telephone VARCHAR(20),
    name VARCHAR(100),
    dob DATE,
    id_number VARCHAR(20),
    address VARCHAR(200),
    county VARCHAR(50),
    sub_county VARCHAR(50),
    next_of_kin_name VARCHAR(100),
    next_of_kin_dob DATE,
    next_of_kin_id_number VARCHAR(20),
    next_of_kin_gender VARCHAR(10),
    next_of_kin_relationship VARCHAR(50),
    next_of_kin_telephone VARCHAR(20),
    email VARCHAR(100),
    gender VARCHAR(10),
    marital_status VARCHAR(20),
    reference_number VARCHAR(10)
);
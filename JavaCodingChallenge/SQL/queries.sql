
create database  hospital_db;
use hospital_db;

create table patient (
    patient_id int primary key auto_increment,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    date_of_birth date not null,
    gender varchar(10) check (gender in ('Male', 'Female', 'Other')),
    contact_number varchar(15),
    address varchar(255)
);

create table doctor (
    doctor_id int primary key auto_increment,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    specialization varchar(100),
    contact_number varchar(15)
);

create table appointment (
    appointment_id int primary key auto_increment,
    patient_id int,
    doctor_id int,
    appointment_date date not null,
    description text,
    constraint fk_patient_id foreign key (patient_id) references patient(patient_id) on delete cascade,
    constraint fk_doctor_id foreign key (doctor_id) references doctor(doctor_id) on delete cascade
);

INSERT INTO Doctor (first_name, last_name, specialization, contact_number) VALUES
('Aarav', 'Sharma', 'Cardiologist', '9876543210'),
('Diya', 'Verma', 'Pediatrician', '9988776655'),
('Kiran', 'Patel', 'Dermatologist', '9765432109'),
('Meera', 'Nair', 'Gynecologist', '9876543211'),
('Rohan', 'Reddy', 'Orthopedist', '9988776656'),
('Priya', 'Pillai', 'Neurologist', '9765432110'),
('Vikram', 'Singh', 'Oncologist', '9876543212'),
('Ananya', 'Gupta', 'ENT Specialist', '9988776657'),
('Suresh', 'Kumar', 'General Surgeon', '9765432111'),
('Deepika', 'Menon', 'Endocrinologist', '9876543213');
-- select * from patient;

INSERT INTO Patient (first_name, last_name, date_of_birth, gender, contact_number, address) VALUES
('Aishwarya', 'Rajan', '1990-05-15', 'Female', '9840012345', '12, Anna Nagar, Chennai'),
('Bharath', 'Subramanian', '1985-10-22', 'Male', '9940056789', '45, MG Road, Coimbatore'),
('Charulatha', 'Krishnan', '2002-03-08', 'Female', '9840123456', '7, Gandhi Street, Madurai'),
('Dinesh', 'Kumar', '1998-07-01', 'Male', '9940067890', '23, Nehru Avenue, Tiruchirappalli'),
('Esha', 'Sharma', '1993-12-10', 'Female', '9840234567', '5, Kamaraj Road, Salem'),
('Farhan', 'Khan', '2005-09-18', 'Male', '9940078901', '10, Bazaar Street, Tirunelveli'),
('Gayathri', 'Nair', '1980-04-25', 'Female', '9840345678', '32, Lake View Road, Vellore'),
('Harish', 'Raghavan', '1996-01-03', 'Male', '9940089012', '16, Church Street, Erode'),
('Ishwarya', 'Prakash', '2001-06-12', 'Female', '9840456789', '9, Park Avenue, Tiruppur'),
('Jerin', 'Mathew', '1987-11-29', 'Male', '9940090123', '28, Beach Road, Thoothukudi');
-- select * from patient;

INSERT INTO Appointment (patient_id, doctor_id, appointment_date, description) VALUES
(1, 1, '2024-01-20', 'Regular checkup'),
(2, 2, '2024-01-21', 'Child vaccination'),
(3, 3, '2024-01-22', 'Skin consultation'),
(4, 4, '2024-01-23', 'Prenatal checkup'),
(5, 5, '2024-01-24', 'Follow-up on fracture'),
(6, 6, '2024-01-25', 'Migraine treatment'),
(7, 7, '2024-01-26', 'Cancer treatment review'),
(8, 8, '2024-01-27', 'Ear infection checkup'),
(9, 9, '2024-01-28', 'Post-surgery follow up'),
(10, 10, '2024-01-29', 'Thyroid level check');



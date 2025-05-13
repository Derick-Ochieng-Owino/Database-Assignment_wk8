-- Creating 'Doctors' Table
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    UNIQUE (email)
);

-- Creating 'Patients' Table
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    date_of_birth DATE NOT NULL,
    phone_number VARCHAR(15),
    email VARCHAR(100),
    UNIQUE (email)
);

-- Creating 'Appointments' Table (1:M relationship between Patients and Doctors)
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason_for_visit TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Creating 'Medical_History' Table (M:1 relationship between Patients and Doctors)
CREATE TABLE Medical_History (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    diagnosis TEXT,
    treatment TEXT,
    date_of_diagnosis DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Creating 'Rooms' Table (M:1 relationship between Doctors and Rooms)
CREATE TABLE Rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL,
    room_type ENUM('Single', 'Double', 'ICU', 'General') NOT NULL,
    availability BOOLEAN DEFAULT TRUE
);

-- Creating 'Patient_Room_Assignment' Table (M:M relationship between Patients and Rooms)
CREATE TABLE Patient_Room_Assignment (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    room_id INT NOT NULL,
    admission_date DATE NOT NULL,
    discharge_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

-- Creating 'Bills' Table (1:M relationship between Patients and Bills)
CREATE TABLE Bills (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    bill_date DATE NOT NULL,
    payment_status ENUM('Paid', 'Pending') DEFAULT 'Pending',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

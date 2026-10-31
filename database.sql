-- SUPERFIVE database (pwede i-run sa phpMyAdmin / MySQL Workbench).
-- Note: automatic na kini gihimo sa program (Database/DatabaseSetup.java) pag-open sa login screen.

CREATE DATABASE IF NOT EXISTS superfive;
USE superfive;

CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100),
    username VARCHAR(50) UNIQUE,
    password VARCHAR(255)
);

-- admin (human na ang ALTER TABLE admin DROP COLUMN full-name)
CREATE TABLE IF NOT EXISTS admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    password VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS passenger (
    passenger_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    contact_number VARCHAR(20),
    email VARCHAR(100),
    discount_type VARCHAR(20),
    id_number VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    trip_code VARCHAR(20),
    bus_no VARCHAR(20),
    origin VARCHAR(50),
    destination VARCHAR(50),
    travel_date DATE,
    departure_time VARCHAR(20),
    fare DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS seat (
    seat_id INT AUTO_INCREMENT PRIMARY KEY,
    schedule_id INT,
    seat_number INT,
    status VARCHAR(20),
    FOREIGN KEY (schedule_id) REFERENCES schedule(schedule_id)
);

CREATE TABLE IF NOT EXISTS booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    passenger_id INT,
    schedule_id INT,
    seat_id INT,
    original_booking_id INT,
    booking_date DATETIME,
    total_fare DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (passenger_id) REFERENCES passenger(passenger_id),
    FOREIGN KEY (schedule_id) REFERENCES schedule(schedule_id),
    FOREIGN KEY (seat_id) REFERENCES seat(seat_id),
    FOREIGN KEY (original_booking_id) REFERENCES booking(booking_id)
);

CREATE TABLE IF NOT EXISTS payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    payment_status VARCHAR(20),
    transaction_date DATETIME,
    reference_no VARCHAR(50),
    total_fare DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id)
);

-- default admin account
INSERT INTO admin (username, password)
SELECT 'admin', 'admin123' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM admin WHERE username = 'admin');

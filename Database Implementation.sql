SELECT USER(), VERSION(); 
SHOW DATABASES;         
CREATE DATABASE CSC312_DB;
USE CSC312_DB;

CREATE TABLE manufacturer (
  manufacturer_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  country VARCHAR(100)
);

CREATE TABLE vehicle_class (
  class_id INT AUTO_INCREMENT PRIMARY KEY,
  class_name VARCHAR(50) NOT NULL
);

CREATE TABLE vehicle_model (
  model_id INT AUTO_INCREMENT PRIMARY KEY,
  model_name VARCHAR(100) NOT NULL,
  year INT,
  price INT,
  manufacturer_id INT,
  class_id INT,
  FOREIGN KEY (manufacturer_id) REFERENCES manufacturer(manufacturer_id),
  FOREIGN KEY (class_id) REFERENCES vehicle_class(class_id)
);

CREATE TABLE performance_spec (
  model_id INT PRIMARY KEY,
  engine_capacity INT NOT NULL,
  cylinders INT NOT NULL,
  power INT NOT NULL,
  torque INT NOT NULL,
  weight INT NOT NULL,
  perf_rating INT NOT NULL,
  FOREIGN KEY (model_id) REFERENCES vehicle_model(model_id)
);

CREATE TABLE part (
  part_id INT AUTO_INCREMENT PRIMARY KEY ,
  part_name VARCHAR(100) NOT NULL,
  category VARCHAR(50),
  brand VARCHAR(50),
  price INT
);

CREATE TABLE model_part (
  model_id INT,
  part_id INT,
  rating_modifier INT,
  PRIMARY KEY (model_id, part_id),
  FOREIGN KEY (model_id) REFERENCES vehicle_model(model_id),
  FOREIGN KEY (part_id) REFERENCES part(part_id)
);

INSERT INTO manufacturer (name, country) VALUES
('BMW', 'Germany'),
('Dodge', 'USA'),
('McLaren', 'UK'),
('Mercedes-Benz', 'Germany'),
('Nissan', 'Japan'),
('Pagani', 'Italy'),
('Renault', 'France');

INSERT INTO vehicle_class (class_name) VALUES
('Mini car'),
('Small car'),
('Medium car'),
('Large car'),
('Executive car'),
('Luxury car'),
('Sport utility car'),
('Multi purpose car'),
('Sport coupé');

INSERT INTO vehicle_model (model_name, year, price, manufacturer_id, class_id) VALUES
('M3 Coupe', 2007, 70000, 1, 9),
('X5 M', 2011, 95000, 1, 7),
('X6 M', 2011, 98000, 1, 7),
('Z4 M Roadster', 2008, 60000, 1, 9),
('Challenger R/T', 2009, 38000, 2, 9),
('Charger R/T', 2011, 42000, 2, 4),
('Charger SRT8', 2008, 65000, 2, 4),
('Viper SRT', 2013, 150000, 2, 9),
('SLR McLaren', 2006, 480000, 4, 9),
('CL 65 AMG', 2004, 220000, 4, 6),
('CLS 55 AMG', 2005, 110000, 4, 5),
('SL 65 AMG', 2005, 230000, 4, 9),
('SLK 55 AMG', 2005, 85000, 4, 9),
('350Z Grand Touring Coupe', 2007, 38000, 5, 9),
('370Z', 2010, 45000, 5, 9),
('GT-R', 2008, 120000, 5, 9),
('Skyline GT-R LM Limited', 1996, 110000, 5, 9),
('Zonda F', 2009, 700000, 6, 9),
('Clio RS', 2013, 22000, 7, 2),
('Megane Renaultsport 225 Trophy', 2005, 30000, 7, 3),
('Megane RS 275 Trophy', 2015, 40000, 7, 3);

INSERT INTO performance_spec (model_id, engine_capacity, cylinders, power, torque, weight, perf_rating) VALUES
(1, 3999, 8, 309, 400, 1655, 215),
(2, 4395, 8, 414, 678, 2435, 235),
(3, 4395, 8, 414, 678, 2415, 235),
(4, 3246, 6, 252, 365, 1485, 190),
(5, 5700, 8, 276, 540, 1995, 170),
(6, 5700, 8, 276, 536, 1890, 175),
(7, 6100, 8, 317, 569, 1510, 205),
(8, 8400, 10, 477, 813, 1465, 295),
(9, 5439, 8, 460, 780, 1768, 285),
(10, 5980, 12, 450, 1000, 2155, 255),
(11, 5439, 8, 350, 700, 1920, 225),
(12, 5980, 12, 450, 1000, 2110, 260),
(13, 5439, 8, 265, 510, 1540, 205),
(14, 3498, 6, 228, 363, 1545, 165),
(15, 3700, 6, 248, 366, 1510, 185),
(16, 3799, 6, 357, 588, 1740, 270),
(17, 2568, 6, 206, 368, 1530, 170),
(18, 7291, 12, 443, 760, 1230, 300),
(19, 1618, 4, 147, 240, 1204, 115),
(20, 1998, 4, 165, 300, 1355, 135),
(21, 1998, 4, 201, 360, 1340, 150);

INSERT INTO part (part_name, category, brand, price) VALUES
('BBS Forged Wheel Set', 'Wheels & Tyres', 'BBS', 8000),
('König Lightweight Wheel Set', 'Wheels & Tyres', 'König', 5500),
('KW Coilover Kit', 'Suspension', 'KW', 4500),
('Eibach Lowering Springs', 'Suspension', 'Eibach', 1500),
('Garrett Turbo Upgrade Kit', 'Engine', 'Garrett', 12000),
('NOS Nitrous Oxide Kit', 'Engine', 'NOS', 6000),
('K&N Performance Air Intake', 'Engine', 'K&N', 800),
('Scorpion Off-Road Tyres', 'Wheels & Tyres', 'Pirelli', 2800),
('Bilstein Off-Road Lift Suspension', 'Suspension', 'Bilstein', 5200),
('APR Carbon Rear Wing', 'Aero', 'APR', 3500),
('Akrapovič Titanium Exhaust', 'Exhaust', 'Akrapovič', 5000),
('Recaro Sport Seats', 'Weight', 'Recaro', 3000),
('AMG SPEEDSHIFT Transmission', 'Transmission', 'AMG', 15000),
('AMG Sports Suspension', 'Suspension', 'AMG', 12000),
('AMG High-Performance Brakes', 'Brakes', 'AMG', 10000),
('AMG Sports Exhaust System', 'Exhaust', 'AMG', 7000),
('Brembo Performance Brake Kit', 'Brakes', 'Brembo', 12000),
('Carbon-Ceramic Brakes', 'Brakes', 'Brembo', 60000),
('Bilstein DampTronic Suspension', 'Suspension', 'Bilstein', 14000),
('Bilstein Adjustable Shocks', 'Suspension', 'Bilstein', 9000),
('StopTech Slotted Brake Rotors', 'Brakes', 'StopTech', 7500),
('Pirelli P Zero Corsa Tyres', 'Wheels & Tyres', 'Pirelli', 4000),
('Sidewinder II Track Wheels', 'Wheels & Tyres', 'SRT', 9500),
('Sabelt Lightweight Seats', 'Weight', 'Sabelt', 6500),
('Michelin Pilot Sport 2 Tyres', 'Wheels & Tyres', 'Michelin', 4500),
('RAYS Forged Alloy Wheels', 'Wheels & Tyres', 'RAYS', 11000),
('Cup Chassis Pack', 'Suspension', 'Renault Sport', 6000),
('Limited-Slip Differential', 'Drivetrain', 'GKN', 8500),
('M Compound Brake System', 'Brakes', 'BMW M', 11000);

INSERT INTO model_part (model_id, part_id, rating_modifier) VALUES
(10, 3, +6),
(11, 4, +5),
(12, 1, +8),
(13, 2, +7);

INSERT INTO model_part (model_id, part_id, rating_modifier) VALUES
(9, 1, +5),
(9, 3, +4);

INSERT INTO model_part (model_id, part_id, rating_modifier) VALUES
(18, 1, +9),
(18, 4, +7);

INSERT INTO model_part (model_id, part_id, rating_modifier) VALUES
(1, 3, -4),
(2, 2, -3),
(3, 4, -2),
(4, 1, -5);

INSERT INTO model_part (model_id, part_id, rating_modifier) VALUES
(5, 4, -5),
(6, 3, -6),
(7, 1, -7),
(8, 2, -8);

INSERT INTO model_part (model_id, part_id, rating_modifier) VALUES
(14, 2, +1),
(15, 4, +2),
(16, 3, +1),
(17, 1, 0); 

INSERT INTO model_part (model_id, part_id, rating_modifier) VALUES
(19, 4, -2),
(20, 2, +2),
(21, 3, +3);

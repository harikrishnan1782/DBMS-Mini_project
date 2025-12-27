DROP DATABASE IF EXISTS horizon__airways;
DROP DATABASE IF EXISTS airways;

create database  airways;
use airways;

create table roles(role_id int auto_increment primary key ,
 role_name varchar(50) unique not null);
 
 insert into roles (role_name) values  ('passanger');
 
 create table users(user_id int auto_increment primary key,
 full_name Varchar(50) NOT NULL,
 email varchar(50) unique NOT NULL,
 password varchar(50) NOT NULL,
 role_id int ,
 created_at datetime default current_timestamp,
 foreign key (role_id) references roles (role_id) );
 
 ALTER TABLE users MODIFY phone VARCHAR(20) NULL;
 
INSERT INTO users (full_name, email, password, role_id) VALUES ('Hari Krishnan', 'hari@mail.com', 'pass123', 1);

  
 create table airports(airport_id int AUTO_INCREMENT Primary key,
 airport_code varchar(20) Unique NOT NULL,
 airport_name varchar(30) NOT NULL,
 city varchar(40) ,
 country varchar(30));

 create table aircraft(aircraft_id INT AUTO_INCREMENT primary key,
 model Varchar(30) NOT NULL,
 total_seats int NOT NULL,
 cost_per_km decimal(10,2) NOT NULL);

 create table routes(route_id int AUTO_INCREMENT Primary key,
 source_airport_id int,
 destination_airport_id int,
 distance_km int NOT NULL,
 foreign key(source_airport_id) references airports(airport_id),
 foreign key(destination_airport_id) references airports(airport_id),
 constraint check_diffrent_airports Check(source_airport_id <> destination_airport_id));
 
 create table flights(flight_id int  AUTO_INCREMENT Primary key,
 flight_number varchar(10) Unique NOT NULL,
 route_id int,
 aircraft_id int,
 departure_time datetime NOT NULL,
 arrival_time datetime NOT NULL,
 base_fare decimal(10,2) NOT NULL,
 flight_status varchar(30) Default 'Scheduled',
 foreign key (route_id) references routes(route_id),
 foreign key(aircraft_id) references aircraft (aircraft_id),
 constraint check_arrival_is_greater_depature CHECK (arrival_time > departure_time));

 create table bookings(booking_id int AUTO_INCREMENT Primary key,
 user_id int,  -- fk
 flight_id int, -- fk
 booking_date datetime default current_timestamp,
 seats_booked int not null check(seats_booked > 0),
 total_amount decimal(10,2) NOT NULL,
 booking_status varchar(30) default 'pending',
 foreign key(user_id) references users(user_id) ,
 foreign key(flight_id) references flights(flight_id));
 
 create table  payments(
 payment_id int  AUTO_INCREMENT primary key,
 booking_id int NOT NULL,
 amount_paid decimal(10,2) NOT NULL,
 payment_method varchar(30) NOT NULL,
 payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
 payment_status varchar(20) DEFAULT 'Completed',
 foreign key(booking_id) references bookings(booking_id)
);
INSERT INTO roles (role_name) VALUES ('Passenger'), ('Admin');
INSERT INTO users (full_name, email, password, role_id) VALUES ('Hari Krishnan', 'hari@mail.com', 'pass123', 2);

INSERT INTO users(full_name,email,password,role_id) VALUES
('Amit Sharma','amit1@mail.com','pass123',1),
('Ravi Kumar','ravi2@mail.com','pass123',1),
('Neha Verma','neha3@mail.com','pass123',1),
('Anita Singh','anita4@mail.com','pass123',1),
('Vijay Patel','vijay5@mail.com','pass123',1),
('Priya Das','priya6@mail.com','pass123',1),
('Kiran Gupta','kiran7@mail.com','pass123',1),
('Rohit Mehta','rohit8@mail.com','pass123',1),
('Sneha Iyer','sneha9@mail.com','pass123',1),
('Manish Jain','manish10@mail.com','pass123',1),
('Arjun Reddy','arjun11@mail.com','pass123',1),
('Sanjay Rao','sanjay12@mail.com','pass123',1),
('Rakesh Pillai','rakesh13@mail.com','pass123',1),
('Ritu Kapoor','ritu14@mail.com','pass123',1),
('Rohan Shah','rohan15@mail.com','pass123',1),
('Nisha Roy','nisha16@mail.com','pass123',1),
('Pooja Nair','pooja17@mail.com','pass123',1),
('Karthik Mohan','karthik18@mail.com','pass123',1),
('Anjali Singh','anjali19@mail.com','pass123',1),
('Akash Sinha','akash20@mail.com','pass123',1),
('Farhan Ali','farhan21@mail.com','pass123',1),
('Hemant Joshi','hemant22@mail.com','pass123',1),
('Sonal Mishra','sonal23@mail.com','pass123',1),
('Mahesh Gowda','mahesh24@mail.com','pass123',1),
('Tanvi Saxena','tanvi25@mail.com','pass123',1),
('Deepak K','deepak26@mail.com','pass123',1),
('Alok Jaiswal','alok27@mail.com','pass123',1),
('Bhavna K','bhavna28@mail.com','pass123',1),
('Rahul Dev','rahul29@mail.com','pass123',1),
('Chandan L','chandan30@mail.com','pass123',1),
('Kavita T','kavita31@mail.com','pass123',1),
('Suresh Y','suresh32@mail.com','pass123',1),
('Veena R','veena33@mail.com','pass123',1),
('Joel A','joel34@mail.com','pass123',1),
('Mathew N','mathew35@mail.com','pass123',1),
('Jatin K','jatin36@mail.com','pass123',1),
('Lavanya K','lavanya37@mail.com','pass123',1),
('Himanshu P','himanshu38@mail.com','pass123',1),
('Naveen M','naveen39@mail.com','pass123',1),
('Amulya G','amulya40@mail.com','pass123',1),
('Gayathri S','gayathri41@mail.com','pass123',1),
('Jeevan T','jeevan42@mail.com','pass123',1),
('Divya K','divya43@mail.com','pass123',1),
('Siddharth A','siddharth44@mail.com','pass123',1),
('Haritha R','haritha45@mail.com','pass123',1),
('Rohini P','rohini46@mail.com','pass123',1),
('Vandana N','vandana47@mail.com','pass123',1),
('Samarth H','samarth48@mail.com','pass123',1),
('Kishore L','kishore49@mail.com','pass123',1);

INSERT INTO airports(airport_code,airport_name,city,country) VALUES
('DEL','Indira Gandhi International','New Delhi','India'),
('BOM','Chhatrapati Shivaji Intl','Mumbai','India'),
('MAA','Chennai International','Chennai','India'),
('BLR','Kempegowda Intl','Bengaluru','India'),
('HYD','Rajiv Gandhi Intl','Hyderabad','India'),
('CCU','Subhas Chandra Bose Intl','Kolkata','India'),
('GOI','Manohar Parrikar Intl','Goa','India'),
('AMD','Sardar Vallabhbhai Patel','Ahmedabad','India'),
('PNQ','Pune Airport','Pune','India'),
('BBI','Biju Patnaik Intl','Bhubaneswar','India'),
('COK','Cochin Intl Airport','Kochi','India'),
('IXM','Madurai Airport','Madurai','India'),
('IXE','Mangalore Airport','Mangalore','India'),
('IXC','Chandigarh Intl','Chandigarh','India'),
('TRV','Trivandrum Intl','Thiruvananthapuram','India'),
('BHO','Raja Bhoj Airport','Bhopal','India'),
('PAT','Jay Prakash Narayan Intl','Patna','India'),
('RPR','Swami Vivekanand Airport','Raipur','India'),
('NAG','Dr Ambedkar Intl','Nagpur','India'),
('LKO','Chaudhary Charan Singh','Lucknow','India'),
('BDQ','Vadodara Airport','Vadodara','India'),
('JAI','Jaipur Intl Airport','Jaipur','India'),
('SXR','Srinagar Airport','Srinagar','India'),
('IXJ','Jammu Airport','Jammu','India'),
('GAU','Lokpriya Gopinath Bordoloi','Guwahati','India'),
('DIB','Dibrugarh Airport','Dibrugarh','India'),
('IMF','Imphal Intl Airport','Imphal','India'),
('IXA','Agartala Intl Airport','Agartala','India'),
('VGA','Vijayawada Airport','Vijayawada','India'),
('VTZ','Visakhapatnam Airport','Visakhapatnam','India'),
('TIR','Tirupati Airport','Tirupati','India'),
('IXR','Birsa Munda Airport','Ranchi','India'),
('GWL','Gwalior Airport','Gwalior','India'),
('HBX','Hubli Airport','Hubballi','India'),
('JLR','Jabalpur Airport','Jabalpur','India'),
('UDR','Maharana Pratap Airport','Udaipur','India'),
('STV','Surat Airport','Surat','India'),
('ATQ','Sri Guru Ram Das Jee','Amritsar','India'),
('IXU','Aurangabad Airport','Aurangabad','India'),
('DHM','Gaggal Airport','Dharamshala','India'),
('TEZ','Tezpur Airport','Tezpur','India'),
('IXB','Bagdogra Airport','Siliguri','India'),
('DMU','Dimapur Airport','Nagaland','India'),
('JSA','Jaisalmer Airport','Jaisalmer','India'),
('HJR','Khajuraho Airport','Khajuraho','India'),
('PBD','Porbandar Airport','Porbandar','India'),
('JGB','Jagdalpur Airport','Jagdalpur','India'),
('MYQ','Mysore Airport','Mysore','India'),
('BEK','Bareilly Airport','Bareilly','India'),
('DXB','Dubai International','Dubai','UAE');

INSERT INTO aircraft(model,total_seats,cost_per_km) VALUES
('Airbus A320',180,500.00),
('Airbus A321neo',220,550.00),
('Boeing 737-800',160,480.00),
('Boeing 737 MAX 8',178,510.00),
('ATR-72',70,250.00),
('Airbus A319',150,450.00),
('Boeing 737-900',178,520.00),
('Airbus A320neo',186,515.00),
('ATR-42',50,220.00),
('Boeing 787-8',242,800.00),
('Airbus A330-200',260,850.00),
('Airbus A321',212,540.00),
('Boeing 757-200',200,600.00),
('A220-300',160,440.00),
('A220-100',130,420.00),
('E190',114,350.00),
('E195',132,380.00),
('E175',88,300.00),
('Airbus A350-900',300,950.00),
('Boeing 777-300ER',396,1100.00),
('Boeing 777-200',312,1050.00),
('Boeing 767-300',261,820.00),
('A321LR',206,560.00),
('B787-9',290,880.00),
('Q400',78,260.00),
('A310-300',220,650.00),
('B757-300',243,680.00),
('CRJ-900',86,310.00),
('CRJ-700',70,300.00),
('MD-90',153,550.00),
('MD-88',142,540.00),
('A330neo',285,870.00),
('A310',222,640.00),
('B737 Classic',146,470.00),
('B737 MAX10',204,530.00),
('Airbus A318',107,400.00),
('B737 MAX7',153,510.00),
('A350-1000',366,1000.00),
('B777X',426,1200.00),
('B747-8',467,1300.00),
('A380',525,1400.00),
('A350 Regional',290,920.00),
('E170',80,310.00),
('E145',50,290.00),
('Fokker100',97,320.00),
('Sukhoi Superjet',108,340.00),
('A340-300',350,980.00),
('B767-400ER',296,900.00),
('A340-500',372,1050.00),
('B787-10',330,910.00);

INSERT INTO routes(source_airport_id,destination_airport_id,distance_km) VALUES
(1, 2, 1148), -- DEL -> BOM
(2, 1, 1148), -- BOM -> DEL
(1, 3, 1760), -- DEL -> MAA
(3, 1, 1760), -- MAA -> DEL
(1, 4, 1740), -- DEL -> BLR
(4, 1, 1740), -- BLR -> DEL
(2, 4, 842),  -- BOM -> BLR
(4, 2, 842),  -- BLR -> BOM
(2, 3, 1028), -- BOM -> MAA
(3, 2, 1028), -- MAA -> BOM
(3, 4, 290),  -- MAA -> BLR
(4, 3, 290),  -- BLR -> MAA
(1, 5, 1253), -- DEL -> HYD
(5, 1, 1253), -- HYD -> DEL
(4, 5, 500),  -- BLR -> HYD
(5, 4, 500),  -- HYD -> BLR
(1, 6, 1305), -- DEL -> CCU
(6, 1, 1305), -- CCU -> DEL
(2, 7, 424),  -- BOM -> GOI
(7, 2, 424),  -- GOI -> BOM
(1, 22, 241), -- DEL -> JAI
(22, 1, 241), -- JAI -> DEL
(1, 23, 645), -- DEL -> SXR
(23, 1, 645), -- SXR -> DEL
(11, 4, 360), -- COK -> BLR
(4, 11, 360), -- BLR -> COK
(1, 50, 2185), -- DEL -> DXB (Intl)
(50, 1, 2185), -- DXB -> DEL
(2, 50, 1930), -- BOM -> DXB
(50, 2, 1930), -- DXB -> BOM
(3, 50, 2900), -- MAA -> DXB
(50, 3, 2900), -- DXB -> MAA
(4, 50, 2700), -- BLR -> DXB
(50, 4, 2700); -- DXB -> BLR

INSERT INTO flights (flight_number, route_id, aircraft_id, departure_time, arrival_time, base_fare, flight_status) VALUES
-- Past (2024)
('AI-101', 1, 1, '2024-11-01 08:00:00', '2024-11-01 10:10:00', 5500.00, 'Completed'),
('AI-102', 2, 3, '2024-11-01 14:00:00', '2024-11-01 16:15:00', 5800.00, 'Completed'),
('6E-205', 3, 2, '2024-11-02 09:00:00', '2024-11-02 11:45:00', 6200.00, 'Delayed'),
('6E-301', 5, 4, '2024-11-05 18:00:00', '2024-11-05 20:45:00', 5900.00, 'Completed'),
('QP-401', 7, 5, '2024-11-10 07:30:00', '2024-11-10 09:00:00', 3500.00, 'Cancelled'),
('SG-555', 9, 1, '2024-11-15 12:00:00', '2024-11-15 14:00:00', 4200.00, 'Completed'),
('AI-808', 27, 10, '2024-12-01 22:00:00', '2024-12-02 01:30:00', 18500.00, 'Completed'), -- DEL->DXB
('EK-501', 28, 20, '2024-12-05 04:00:00', '2024-12-05 08:30:00', 21000.00, 'Completed'),
('AI-999', 19, 8, '2024-12-20 10:00:00', '2024-12-20 11:15:00', 2800.00, 'Completed'), -- BOM->GOI
('6E-777', 11, 5, '2024-12-25 08:00:00', '2024-12-25 09:00:00', 1500.00, 'Delayed'),

-- Future (2025)
('AI-103', 1, 1, '2025-06-01 08:00:00', '2025-06-01 10:10:00', 5600.00, 'Scheduled'),
('AI-104', 2, 3, '2025-06-01 15:00:00', '2025-06-01 17:15:00', 5900.00, 'Scheduled'),
('6E-206', 3, 2, '2025-06-02 09:00:00', '2025-06-02 11:45:00', 6300.00, 'Scheduled'),
('QP-402', 7, 5, '2025-06-05 07:30:00', '2025-06-05 09:00:00', 3600.00, 'Scheduled'),
('SG-556', 9, 1, '2025-06-10 12:00:00', '2025-06-10 14:00:00', 4300.00, 'Scheduled'),
('AI-809', 27, 10, '2025-06-15 22:00:00', '2025-06-16 01:30:00', 19000.00, 'Scheduled'),
('EK-502', 28, 20, '2025-06-18 04:00:00', '2025-06-18 08:30:00', 22000.00, 'Scheduled'),
('AI-001', 19, 8, '2025-06-20 10:00:00', '2025-06-20 11:15:00', 3000.00, 'Scheduled'),
('6E-888', 11, 5, '2025-06-25 08:00:00', '2025-06-25 09:00:00', 1600.00, 'Scheduled'),
('UK-991', 15, 6, '2025-06-28 16:00:00', '2025-06-28 17:00:00', 2500.00, 'Scheduled');

INSERT INTO bookings (user_id, flight_id, booking_date, seats_booked, total_amount, booking_status) VALUES
-- Past Bookings
(2, 1, '2024-10-25 10:00:00', 1, 5500.00, 'Confirmed'),
(3, 1, '2024-10-26 11:00:00', 2, 11000.00, 'Confirmed'),
(4, 2, '2024-10-28 14:00:00', 1, 5800.00, 'Confirmed'),
(5, 3, '2024-10-30 09:00:00', 1, 6200.00, 'Confirmed'),
(6, 4, '2024-11-01 10:00:00', 3, 17700.00, 'Confirmed'),
(7, 5, '2024-11-05 12:00:00', 1, 3500.00, 'Cancelled'), -- Refund Scenario
(8, 7, '2024-11-20 15:00:00', 2, 37000.00, 'Confirmed'), -- Dubai Trip
(9, 7, '2024-11-21 16:00:00', 1, 18500.00, 'Confirmed'),
(10, 9, '2024-12-15 09:00:00', 4, 11200.00, 'Confirmed'), -- Goa Trip
(11, 10, '2024-12-20 10:00:00', 1, 1500.00, 'Confirmed'),

(12, 11, '2025-05-10 10:00:00', 1, 5600.00, 'Confirmed'),
(13, 11, '2025-05-11 11:00:00', 2, 11200.00, 'Confirmed'),
(14, 12, '2025-05-15 14:00:00', 1, 5900.00, 'Pending'),
(15, 13, '2025-05-18 09:00:00', 1, 6300.00, 'Confirmed'),
(16, 16, '2025-06-01 10:00:00', 2, 38000.00, 'Confirmed'), -- Dubai Trip
(17, 18, '2025-06-05 12:00:00', 1, 3000.00, 'Confirmed'),
(18, 19, '2025-06-10 08:00:00', 1, 1600.00, 'Confirmed'),
(19, 20, '2025-06-15 16:00:00', 3, 7500.00, 'Confirmed'),
(20, 11, '2025-05-12 10:00:00', 1, 5600.00, 'Confirmed'),
(21, 12, '2025-05-16 14:00:00', 1, 5900.00, 'Confirmed'),
(22, 1, '2024-10-27 10:00:00', 1, 5500.00, 'Confirmed'),
(23, 2, '2024-10-29 14:00:00', 1, 5800.00, 'Confirmed'),
(24, 7, '2024-11-22 15:00:00', 1, 18500.00, 'Confirmed'),
(25, 9, '2024-12-16 09:00:00', 2, 5600.00, 'Confirmed'),
(26, 16, '2025-06-02 10:00:00', 1, 19000.00, 'Confirmed'),
(27, 11, '2025-05-13 10:00:00', 1, 5600.00, 'Confirmed'),
(28, 13, '2025-05-19 09:00:00', 2, 12600.00, 'Confirmed'),
(29, 18, '2025-06-06 12:00:00', 1, 3000.00, 'Confirmed'),
(30, 19, '2025-06-11 08:00:00', 1, 1600.00, 'Confirmed'),
(31, 20, '2025-06-16 16:00:00', 1, 2500.00, 'Confirmed'),
(32, 1, '2024-10-25 12:00:00', 1, 5500.00, 'Confirmed'),
(33, 9, '2024-12-17 09:00:00', 1, 2800.00, 'Confirmed'),
(34, 16, '2025-06-03 10:00:00', 1, 19000.00, 'Confirmed'),
(35, 11, '2025-05-14 10:00:00', 1, 5600.00, 'Confirmed'),
(36, 12, '2025-05-17 14:00:00', 1, 5900.00, 'Confirmed'),
(37, 7, '2024-11-23 15:00:00', 1, 18500.00, 'Confirmed'),
(38, 13, '2025-05-20 09:00:00', 1, 6300.00, 'Confirmed'),
(39, 18, '2025-06-07 12:00:00', 1, 3000.00, 'Confirmed'),
(40, 19, '2025-06-12 08:00:00', 1, 1600.00, 'Confirmed'),
(41, 1, '2024-10-26 13:00:00', 1, 5500.00, 'Confirmed'),
(42, 9, '2024-12-18 09:00:00', 1, 2800.00, 'Confirmed'),
(43, 16, '2025-06-04 10:00:00', 1, 19000.00, 'Confirmed'),
(44, 11, '2025-05-15 10:00:00', 1, 5600.00, 'Confirmed'),
(45, 12, '2025-05-18 14:00:00', 1, 5900.00, 'Confirmed'),
(46, 7, '2024-11-24 15:00:00', 1, 18500.00, 'Confirmed'),
(47, 13, '2025-05-21 09:00:00', 1, 6300.00, 'Confirmed'),
(48, 18, '2025-06-08 12:00:00', 1, 3000.00, 'Confirmed'),
(49, 19, '2025-06-13 08:00:00', 1, 1600.00, 'Confirmed'),
(50, 20, '2025-06-17 16:00:00', 1, 2500.00, 'Confirmed');

INSERT INTO payments (booking_id, amount_paid, payment_method, payment_status) VALUES
(1, 5500.00, 'UPI', 'Completed'),
(2, 11000.00, 'Credit Card', 'Completed'),
(3, 5800.00, 'Net Banking', 'Completed'),
(4, 6200.00, 'UPI', 'Completed'),
(5, 17700.00, 'Credit Card', 'Completed'),
(6, 3500.00, 'UPI', 'Refunded'), -- Refunded
(7, 37000.00, 'Credit Card', 'Completed'),
(8, 18500.00, 'UPI', 'Completed'),
(9, 11200.00, 'Debit Card', 'Completed'),
(10, 1500.00, 'UPI', 'Completed'),
(11, 5600.00, 'Net Banking', 'Completed'),
(12, 11200.00, 'Credit Card', 'Completed'),
(13, 0.00, 'UPI', 'Pending'), -- Unpaid
(14, 6300.00, 'UPI', 'Completed'),
(15, 38000.00, 'Credit Card', 'Completed'),
(16, 3000.00, 'UPI', 'Completed'),
(17, 1600.00, 'Net Banking', 'Completed'),
(18, 7500.00, 'Debit Card', 'Completed'),
(19, 5600.00, 'UPI', 'Completed'),
(20, 5900.00, 'Credit Card', 'Completed'),
(21, 5500.00, 'UPI', 'Completed'),
(22, 5800.00, 'Net Banking', 'Completed'),
(23, 18500.00, 'Credit Card', 'Completed'),
(24, 5600.00, 'UPI', 'Completed'),
(25, 19000.00, 'Credit Card', 'Completed'),
(26, 5600.00, 'Net Banking', 'Completed'),
(27, 12600.00, 'Credit Card', 'Completed'),
(28, 3000.00, 'UPI', 'Completed'),
(29, 1600.00, 'Net Banking', 'Completed'),
(30, 2500.00, 'UPI', 'Completed'),
(31, 5500.00, 'UPI', 'Completed'),
(32, 2800.00, 'Debit Card', 'Completed'),
(33, 19000.00, 'Credit Card', 'Completed'),
(34, 5600.00, 'UPI', 'Completed'),
(35, 5900.00, 'Net Banking', 'Completed'),
(36, 18500.00, 'Credit Card', 'Completed'),
(37, 6300.00, 'UPI', 'Completed'),
(38, 3000.00, 'Debit Card', 'Completed'),
(39, 1600.00, 'UPI', 'Completed'),
(40, 5500.00, 'Net Banking', 'Completed'),
(41, 2800.00, 'UPI', 'Completed'),
(42, 19000.00, 'Credit Card', 'Completed'),
(43, 5600.00, 'UPI', 'Completed'),
(44, 5900.00, 'Net Banking', 'Completed'),
(45, 18500.00, 'Credit Card', 'Completed'),
(46, 6300.00, 'UPI', 'Completed'),
(47, 3000.00, 'Net Banking', 'Completed'),
(48, 1600.00, 'UPI', 'Completed'),
(49, 2500.00, 'Credit Card', 'Completed');

SELECT * FROM flights;
SELECT * FROM routes;
SELECT * FROM users;
SELECT * FROM bookings;
SELECT * FROM payments;
SELECT * FROM aircraft;
SELECT * FROM airports;


USE airways;

-- 1. Create the Admin Role
INSERT INTO roles (role_name) VALUES ('admin');

-- 2. Create the Admin User (Login: admin@horizon.com / admin123)
-- We assume role_id 2 is admin because 'passanger' was 1
INSERT INTO users (full_name, email, password, role_id) 
VALUES ('System Admin', 'admin@horizon.com', 'admin123', 2);

-- 3. Add Dummy Data for Flights (So search works)
INSERT INTO airports (airport_code, airport_name, city, country) VALUES 
('JFK', 'John F Kennedy', 'New York', 'USA'),
('LHR', 'Heathrow', 'London', 'UK'),
('DXB', 'Dubai Intl', 'Dubai', 'UAE');

INSERT INTO aircraft (model, total_seats, cost_per_km) VALUES 
('Boeing 777', 300, 15.50),
('Airbus A320', 180, 12.00);

INSERT INTO routes (source_airport_id, destination_airport_id, distance_km) VALUES 
(1, 2, 5500), -- NY to London
(2, 3, 5500); -- London to Dubai

-- FLIGHT FOR TODAY (So it shows up in search)
INSERT INTO flights (flight_number, route_id, aircraft_id, departure_time, arrival_time, base_fare, flight_status) 
VALUES 
('HZN-101', 1, 1, CONCAT(CURDATE(), ' 10:00:00'), CONCAT(CURDATE(), ' 18:00:00'), 550.00, 'Scheduled');

USE airways;

-- 1. Add a few more Global Airports
INSERT INTO airports (airport_code, airport_name, city, country) VALUES 
('CDG', 'Charles de Gaulle', 'Paris', 'France'),
('HND', 'Haneda Airport', 'Tokyo', 'Japan'),
('SIN', 'Changi Airport', 'Singapore', 'Singapore'),
('SYD', 'Kingsford Smith', 'Sydney', 'Australia'),
('FRA', 'Frankfurt Airport', 'Frankfurt', 'Germany');

-- 2. Create Routes for these new destinations
-- (Assuming IDs: 1=JFK, 2=LHR, 3=DXB, 4=CDG, 5=HND, 6=SIN, 7=SYD, 8=FRA)
INSERT INTO routes (source_airport_id, destination_airport_id, distance_km) VALUES 
(1, 4, 5800), -- NY to Paris
(4, 1, 5800), -- Paris to NY
(3, 6, 5850), -- Dubai to Singapore
(6, 7, 6300), -- Singapore to Sydney
(2, 5, 9500), -- London to Tokyo
(5, 1, 10800),-- Tokyo to NY
(8, 3, 4800); -- Frankfurt to Dubai

-- 3. INSERT 20 FLIGHTS (Dynamic Dates starting from TODAY)
INSERT INTO flights (flight_number, route_id, aircraft_id, departure_time, arrival_time, base_fare, flight_status) VALUES 

-- FLIGHTS FOR TODAY
('HZN-201', 1, 1, CONCAT(CURDATE(), ' 08:00:00'), CONCAT(CURDATE(), ' 16:00:00'), 650.00, 'Scheduled'),
('HZN-202', 2, 2, CONCAT(CURDATE(), ' 14:30:00'), CONCAT(CURDATE(), ' 22:30:00'), 720.50, 'Scheduled'),
('HZN-203', 3, 1, CONCAT(CURDATE(), ' 18:00:00'), DATE_ADD(CONCAT(CURDATE(), ' 18:00:00'), INTERVAL 7 HOUR), 550.00, 'Scheduled'),

-- FLIGHTS FOR TOMORROW
('HZN-204', 1, 1, CONCAT(DATE_ADD(CURDATE(), INTERVAL 1 DAY), ' 09:00:00'), CONCAT(DATE_ADD(CURDATE(), INTERVAL 1 DAY), ' 17:00:00'), 600.00, 'Scheduled'),
('HZN-205', 4, 2, CONCAT(DATE_ADD(CURDATE(), INTERVAL 1 DAY), ' 11:15:00'), CONCAT(DATE_ADD(CURDATE(), INTERVAL 1 DAY), ' 19:15:00'), 450.00, 'Scheduled'),
('HZN-206', 5, 1, CONCAT(DATE_ADD(CURDATE(), INTERVAL 1 DAY), ' 23:00:00'), DATE_ADD(CONCAT(DATE_ADD(CURDATE(), INTERVAL 1 DAY), ' 23:00:00'), INTERVAL 12 HOUR), 1200.00, 'Scheduled'),

-- FLIGHTS FOR DAY AFTER TOMORROW
('HZN-207', 2, 2, CONCAT(DATE_ADD(CURDATE(), INTERVAL 2 DAY), ' 06:45:00'), CONCAT(DATE_ADD(CURDATE(), INTERVAL 2 DAY), ' 14:45:00'), 680.00, 'Scheduled'),
('HZN-208', 3, 1, CONCAT(DATE_ADD(CURDATE(), INTERVAL 2 DAY), ' 13:00:00'), CONCAT(DATE_ADD(CURDATE(), INTERVAL 2 DAY), ' 20:00:00'), 590.00, 'Scheduled'),
('HZN-209', 6, 2, CONCAT(DATE_ADD(CURDATE(), INTERVAL 2 DAY), ' 15:30:00'), CONCAT(DATE_ADD(CURDATE(), INTERVAL 2 DAY), ' 23:30:00'), 800.00, 'Scheduled'),

-- FLIGHTS IN 3 DAYS
('HZN-210', 1, 1, CONCAT(DATE_ADD(CURDATE(), INTERVAL 3 DAY), ' 08:00:00'), CONCAT(DATE_ADD(CURDATE(), INTERVAL 3 DAY), ' 16:00:00'), 620.00, 'Scheduled'),
('HZN-211', 7, 2, CONCAT(DATE_ADD(CURDATE(), INTERVAL 3 DAY), ' 10:00:00'), CONCAT(DATE_ADD(CURDATE(), INTERVAL 3 DAY), ' 18:00:00'), 950.00, 'Scheduled'),
('HZN-212', 4, 1, CONCAT(DATE_ADD(CURDATE(), INTERVAL 3 DAY), ' 19:45:00'), DATE_ADD(CONCAT(DATE_ADD(CURDATE(), INTERVAL 3 DAY), ' 19:45:00'), INTERVAL 8 HOUR), 510.00, 'Scheduled'),

-- FLIGHTS IN 4 DAYS
('HZN-213', 2, 2, CONCAT(DATE_ADD(CURDATE(), INTERVAL 4 DAY), ' 07:30:00'), CONCAT(DATE_ADD(CURDATE(), INTERVAL 4 DAY), ' 15:30:00'), 700.00, 'Scheduled'),
('HZN-214', 5, 1, CONCAT(DATE_ADD(CURDATE(), INTERVAL 4 DAY), ' 12:00:00'), DATE_ADD(CONCAT(DATE_ADD(CURDATE(), INTERVAL 4 DAY), ' 12:00:00'), INTERVAL 11 HOUR), 1150.00, 'Scheduled'),
('HZN-215', 8, 2, CONCAT(DATE_ADD(CURDATE(), INTERVAL 4 DAY), ' 16:20:00'), CONCAT(DATE_ADD(CURDATE(), INTERVAL 4 DAY), ' 22:20:00'), 430.00, 'Scheduled'),

-- FLIGHTS IN 5 DAYS
('HZN-216', 3, 1, CONCAT(DATE_ADD(CURDATE(), INTERVAL 5 DAY), ' 05:00:00'), CONCAT(DATE_ADD(CURDATE(), INTERVAL 5 DAY), ' 13:00:00'), 560.00, 'Scheduled'),
('HZN-217', 6, 2, CONCAT(DATE_ADD(CURDATE(), INTERVAL 5 DAY), ' 14:00:00'), CONCAT(DATE_ADD(CURDATE(), INTERVAL 5 DAY), ' 22:00:00'), 810.00, 'Scheduled'),
('HZN-218', 1, 1, CONCAT(DATE_ADD(CURDATE(), INTERVAL 5 DAY), ' 21:00:00'), DATE_ADD(CONCAT(DATE_ADD(CURDATE(), INTERVAL 5 DAY), ' 21:00:00'), INTERVAL 8 HOUR), 640.00, 'Scheduled'),

-- FLIGHTS IN 6 DAYS
('HZN-219', 7, 2, CONCAT(DATE_ADD(CURDATE(), INTERVAL 6 DAY), ' 09:30:00'), CONCAT(DATE_ADD(CURDATE(), INTERVAL 6 DAY), ' 17:30:00'), 920.00, 'Scheduled'),
('HZN-220', 4, 1, CONCAT(DATE_ADD(CURDATE(), INTERVAL 6 DAY), ' 13:15:00'), CONCAT(DATE_ADD(CURDATE(), INTERVAL 6 DAY), ' 21:15:00'), 495.00, 'Scheduled');
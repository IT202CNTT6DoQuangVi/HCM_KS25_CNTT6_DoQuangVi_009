CREATE DATABASE airline_manage;
USE airline_manage;


CREATE TABLE Passengers(
passenger_id VARCHAR(50) PRIMARY KEY,
full_name VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
phone VARCHAR(15) NOT NULL UNIQUE

);

CREATE TABLE Airlines (
airline_id VARCHAR(5) PRIMARY KEY,
airline_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Flights (
flight_id VARCHAR(5) PRIMARY KEY,
route_name VARCHAR(100) NOT NULL,
airline_id VARCHAR(5) NOT NULL,
ticket_price DECIMAL(10,2) NOT NULL,
available_seats INT NOT NULL,
CONSTRAINT FOREIGN KEY (airline_id) REFERENCES Airlines(airline_id)
);

CREATE TABLE Bookings(
booking_id INT PRIMARY KEY AUTO_INCREMENT,
passenger_id VARCHAR(5) NOT NULL,
flight_id VARCHAR(5) NOT NULL,
flight_status VARCHAR(20) NOT NULL,
booking_date DATE NOT NULL DEFAULT(CURRENT_TIMESTAMP),
CONSTRAINT FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id),
CONSTRAINT FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);


INSERT INTO Passengers
VALUES('P01','Trần Văn Bình','binh.tv@gmail.com','0981111111'),
('P02','Lê Thị Hoa','hoa.lt@gmai.com','0982222222'),
('P03','Nguyễn Trọng Tuấn','tuan.nt@gmail.com','0983333333'),
('P04','Hoàng Minh Châu','chau.hm@gmail.com','0984444444'),
('P05','Đinh Kiều Oanh','oanh.dk@gmail.com','0985555555');

INSERT INTO Airlines 
VALUES('A01','Vietnam Airlines'),
('A02','VietJet Air'),
('A03','Bamboo Aiways'),
('A04','Pacific Airlines');

INSERT INTO Flights 
VALUES('F01','HN-HCM','A01',2500000,50),
('F02','HN-DN','A01',1500000,30),
('F03','HCM-DN','A02',1200000,40),
('F04','HN-PQ','A03',3000000,20),
('F05','HCM-DL','A04',1000000,15);

INSERT INTO Bookings 
VALUES(1,'P01','F01','Booked','2025-10-01'),
(2,'P02','F02','Boarded','2025-10-02'),
(3,'P01','F02','Boarded','2025-10-03'),
(4,'P04','F05','Cancelled','2025-10-04'),
(5,'P05','F01','Booked','2025-10-05');


 SET SQL_SAFE_UPDATES=0;
 UPDATE Flights SET available_seats=available_seats+10 WHERE route_name='HN-PQ';
 UPDATE Flights SET ticket_price = ticket_price * (1  + 0.05) WHERE route_name='HN-PQ';
 
 -- DELETE FROM Bookings
 -- WHERE flight_status='Cancelled'
 -- OR booking_date< '2025-10-03'; -- để ra chạy cuối, hoặc cuối giờ bỏ ra sau cùng đoạn code
 
 SELECT flight_id,route_name,ticket_price FROM Flights 
 WHERE ticket_price BETWEEN 1200000 AND 2500000 
 AND available_seats>0;
 
 SELECT full_name,email FROM Passengers 
 WHERE full_name LIKE 'Trần%';
 
 SELECT booking_id,passenger_id,booking_date FROM Bookings 
 ORDER BY booking_date DESC;
 
 SELECT * FROM Flights 
 ORDER BY ticket_price DESC LIMIT 3;
 
 SELECT route_name, available_seats FROM Flights 
 LIMIT 2 OFFSET 2;


SELECT b.booking_id, p.full_name,f.route_name,b.booking_date 
FROM Bookings b
JOIN Passengers p 
ON b.passenger_id=p.passenger_id
JOIN Flights f
ON b.flight_id=f.flight_id
WHERE flight_status='Booked';

SELECT a.airline_name, f.route_name
FROM Airlines a
LEFT JOIN Flights f 
ON a.airline_id=f.airline_id;



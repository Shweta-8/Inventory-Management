Create Database Inventory

Create Table Supplier
( SID CHAR(5) PRIMARY KEY,
SNAME VARCHAR(30) NOT NULL,
SADD VARCHAR(30) NOT NULL,
SCITY VARCHAR(5) CHECK (SCITY='DELHI'),
SPHONE CHAR(15) UNIQUE,
EMAIL VARCHAR(50)
);

INSERT INTO SUPPLIER (SID, SNAME, SADD, SCITY, SPHONE, EMAIL) VALUES
('S0001', 'Tech Supplies Ltd.', '123 Tech Street', 'DELHI', '9876543210', 'supplier1@example.com'),
('S0002', 'Hardware Solutions', '456 Hardware Ave', 'DELHI', '8765432109', 'supplier2@example.com'), 
('S0003', 'Tech Innovators', '789 Tech Park', ' DELHI ', '9876543210', 'supplier3@example.com'),  
('S0004', 'Mega Electronics', '321 Circuit Lane', ' DELHI ', '7654321098', 'supplier4@example.com'),  
('S0005', 'Fasten Tools', '654 Industrial Road', 'DELHI, '6543210987', 'supplier5@example.com') ;

Create Table Product
(PID CHAR(5) PRIMARY KEY,
PDESC VARCHAR(50) NOT NULL,
PRICE INT CHECK (PRICE >0),
CATEGORY VARCHAR(2) CHECK (CATEGORY IN ('IT','HA','HC')),
SID CHAR(5) unique,
FOREIGN KEY (SID) REFERENCES supplier (SID));



INSERT INTO PRODUCT (PID, PDESC, PRICE, CATEGORY, SID) VALUES
('P0001', 'Laptop', 55000, 'IT', 'S0001'),
('P0002', 'Smartphone', 20000, 'IT', 'S0001'),
('P0003', 'Washing Machine', 15000, 'HA', 'S0002'),
('P0004', 'Refrigerator', 25000, 'HA', 'S0002'),
('P0005', 'Health Monitor', 5000, 'HC', 'S0001');

Create Table STOCK
(PID CHAR(5),
SQTY INT CHECK (SQTY>=0),
ROL INT CHECK (ROL>=0),
MOQ INT CHECK  (MOQ>=5),
FOREIGN KEY (PID) REFERENCES PRODUCT(PID))

INSERT INTO STOCK (PID, SQTY, ROL, MOQ) VALUES
('P0001', 10, 2, 5),
('P0002', 15, 3, 5),
('P0003', 5, 1, 5),
('P0004', 8, 2, 5),
('P0005', 20, 4, 5);

Create Table Cust
(CID CHAR(5) PRIMARY KEY,
CNAME VARCHAR(50) NOT NULL,
CADDRESS VARCHAR (50) NOT NULL,
CITY VARCHAR(50) NOT NULL ,
PHONE CHAR(10) NOT NULL,
EMAIL VARCHAR(50) NOT NULL,
DOB DATE CHECK (DOB < '2000-01-01') )

INSERT INTO CUST (CID, CNAME, CADDRESS, CITY, PHONE, EMAIL, DOB) VALUES
('C0001', 'Rahul', 'A-101 Green', 'Delhi', '9998887776', 'rahul.sharma@example.com', '1998-06-15'),
('C0002', 'Neha Verma', 'B-202 Blue Towers', 'Mumbai', '9887766554', 'neha.verma@example.com', '1996-08-22'),
('C0003', 'Amit Singh', 'C-303 Red Avenue', 'Delhi', '9776655443', 'amit.singh@example.com', '1998-12-10'),
('C0004', 'Priya Sharma', 'B-201 Green Colony', 'Mumbai', '9887766554', 'priya.sharma@example.com', '1995-07-22'),  
('C0005', 'Rahul Verma', 'D-456 Blue Street', 'Bangalore', '9771122334', 'rahul.verma@example.com', '1992-03-15');

Create Table Orders(
OID CHAR(5) PRIMARY KEY,
ODATE DATE NOT NULL,
PID CHAR(5),
CID CHAR(5),
OQTY INT CHECK (OQTY>=1),
FOREIGN KEY (CID) REFERENCES CUST(CID),
    FOREIGN KEY (PID) REFERENCES PRODUCT(PID)
);

INSERT INTO ORDERS (OID, ODATE, CID, PID, OQTY) VALUES
('O0001', '2025-02-25', 'C0001', 'P0001', 1),
('O0002', '2025-02-20', 'C0002', 'P0003', 2),
('O0003', '2025-02-15', 'C0003', 'P0005', 3),
('O0004', '2025-02-18', 'C0001', 'P0002', 1),
('O0005', '2025-02-22', 'C0002', 'P0004', 1 );

select * from Supplier
select * from Product
select * from STOCK
select * from Cust
select * from ORDERS

-

-- Coding Challenge - Car Rental System – SQL

create database car_rental_system;

use car_rental_system;

create table vehicles(
 vehicleID int Primary Key,
 make varchar(255),
 model varchar(255),
 yearDetail year,
 dailyRate decimal(10,2),
 available int check(available in(0,1)),
 passengerCapacity  int,
 engineCapacity int
 );
 

create table customers(
	customerId int primary key,
    firstName varchar(255),
    lastName varchar(255),
    email varchar(255),
    phoneNumber varchar(20)
    );
    
create table leases(
	leaseId int primary key,
    vehicleId int,
    customerId int,
    startDate date,
    endDate date,
    leaseType enum('Daily','Monthly'),
    foreign key (vehicleId) references vehicles(vehicleId),
    foreign key (customerId) references customers(customerId)
    );
    


create table payments(
	paymentId int primary key,
    leaseId int,
    paymentDate date,
    amount int,
    foreign key (leaseId) references leases(leaseId)
    );
    
    
insert into vehicles(vehicleId, make, model, yearDetail, dailyRate, available, passengerCapacity, engineCapacity)
VALUES
(1,'Toyota', 'Camry', 2022, 50.00, 1, 4, 1450),
(2,'Honda', 'Civic', 2023, 45.00, 1, 7, 1500),
(3,'Ford', 'Focus', 2022, 48.00, 0, 4, 1400),
(4,'Nissan', 'Altima', 2023, 52.00, 1, 7, 1200),
(5,'Chevrolet', 'Malibu', 2022, 47.00, 1, 4, 1800),
(6,'Hyundai', 'Sonata', 2023, 49.00, 0, 7, 1400),
(7,'BMW', '3 Series', 2023, 60.00, 1, 7, 2499),
(8,'Mercedes', 'C-Class', 2022, 58.00, 1, 8, 2599),
(9,'Audi','A4',2022, 55.00, 0, 4, 2500),
(10,'Lexus','ES',2023,54.00,1,4,2500);

select * from vehicles;

insert into customers (customerId, firstName, lastName, email, phoneNumber)
VALUES
(1, 'John', 'Doe', 'johndoe@example.com', '555-555-5555'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
(3, 'Robert', 'Johnson', 'robert@example.com', '555-789-1234'),
(4, 'Sarah', 'Brown', 'sarah@example.com', '555-456-7890'),
(5, 'David', 'Lee', 'david@example.com', '555-987-6543'),
(6, 'Laura', 'Hall', 'laura@example.com', '555-234-5678'),
(7, 'Michael', 'Davis', 'michael@example.com', '555-876-5432'),
(8, 'Emma', 'Wilson', 'emma@example.com', '555-432-1098'),
(9, 'William', 'Taylor', 'william@example.com', '555-321-6547'),
(10, 'Olivia', 'Adams', 'olivia@example.com', '555-765-4321');

select * from customers;

insert into leases (leaseID, vehicleId, customerID, startDate, endDate, leaseType)
values
(1, 1, 1, '2023-01-01', '2023-01-05', 'Daily'),
(2, 2, 2, '2023-02-15', '2023-02-28', 'Monthly'),
(3, 3, 3, '2023-03-10', '2023-03-15', 'Daily'),
(4, 4, 4, '2023-04-20', '2023-04-30', 'Monthly'),
(5, 5, 5, '2023-05-05', '2023-05-10', 'Daily'),
(6, 4, 3, '2023-06-15', '2023-06-30', 'Monthly'),
(7, 7, 7, '2023-07-01', '2023-07-10', 'Daily'),
(8, 8, 8, '2023-08-12', '2023-08-15', 'Monthly'),
(9, 3, 3, '2023-09-07', '2023-09-10', 'Daily'),
(10, 10, 10, '2023-10-10', '2023-10-31', 'Monthly');
select * from leases;

insert into payments (paymentID, leaseID, paymentDate, amount)
values
(1, 1, '2023-01-03', 200.00),
(2, 2, '2023-02-20', 1000.00),
(3, 3, '2023-03-12', 75.00),
(4, 4, '2023-04-25', 900.00),
(5, 5, '2023-05-07', 60.00),
(6, 6, '2023-06-18', 1200.00),
(7, 7, '2023-07-03', 40.00),
(8, 8, '2023-08-14', 1100.00),
(9, 9, '2023-09-09', 80.00),
(10, 10, '2023-10-25', 1500.00);

select * from payments;

-- Queries

-- 1. Update the daily rate for a Mercedes car to 68.

update vehicles
set dailyRate=68.00
where make='Mercedes';


-- 2. Delete a specific customer and all associated leases and payments.
set @@foreign_key_checks=0;

delete from payments
where leaseId=(select leaseId from leases where customerId=10);

delete from customers where customerId=10;
delete from leases where customerId=10;

set @@foreign_key_checks=1;

-- 3. Rename the "paymentDate" column in the Payment table to "transactionDate".

alter table payments
rename column paymentDate to transactionDate;


-- 4. Find a specific customer by email.
select * from customers where email='laura@example.com';

-- 5. Get active leases for a specific customer.
select * from leases
where customerId=1 and endDate>=date(now()); -- return null since last date of active lease is 2023-09-10 for all customers 


-- 6. Find all payments made by a customer with a specific phone number.
select p.* 
from payments p
join leases l
on p.leaseId = l.leaseId
join customers c
on l.customerId = c.customerId
where c.phoneNumber = '555-876-5432';

-- 7. Calculate the average daily rate of all available cars.

select avg(dailyRate) "Average Daily Rate of Available Cars" from vehicles
where available =1;

-- 8. Find the car with the highest daily rate.

select * from vehicles 
where dailyRate= (select max(dailyRate) from vehicles);

-- 9. Retrieve all cars leased by a specific customer.

select v.*
from vehicles v
join leases l
on v.vehicleId=l.vehicleId
where l.customerID=2;

-- 10. Find the details of the most recent lease.

select * from leases
order by startDate desc
limit 10;


-- 11. List all payments made in the year 2023.

select * from payments
where year(transactionDate) =2023;

-- 12. Retrieve customers who have not made any payments.

select * from customers 
where customerId
in (select distinct customerId from leases where leaseId not in (select leaseId from payments)); -- reutrns null since all customer had made their payment


-- 13. Retrieve Car Details and Their Total Payments.
select v.vehicleID, v.make, v.model, sum(p.amount) "Total Payments"
from vehicles v
join leases l on v.vehicleID = l.vehicleID
join payments p on l.leaseId = p.leaseId
group by v.vehicleID, v.make, v.model; 


-- 14. Calculate Total Payments for Each Customer.

select c.customerId, c.firstName, c.lastName, sum(p.amount) "Total Payment"
from customers c
join leases l on c.customerId = l.customerId
join payments p on l.leaseId = p.leaseId
group by c.customerId, c.firstName, c.lastName;

-- 15. List Car Details for Each Lease.
select l.leaseId, v.*
from leases l
join vehicles v on l.vehicleID = v.vehicleID
order by l.leaseId;


-- 16. Retrieve Details of Active Leases with Customer and Car Information.

select  l.*, concat(c.firstName,' ', c.lastName) "Customer Name", concat(v.make,' ', v.model) "Car Name"
from leases l
join customers c on l.customerId = c.customerId
join vehicles v on l.vehicleID = v.vehicleID
where l.endDate >= date(now()); -- -- return null since last date of active lease is 2023-09-10 for all customers 


-- 17. Find the Customer Who Has Spent the Most on Leases.

select c.customerId, c.firstName, c.lastName, sum(p.amount) as total_spent
from customers c
join leases l on c.customerId = l.customerId
join payments p on l.leaseId = p.leaseId
group by c.customerId, c.firstName, c.lastName
order by total_spent desc 
limit 1;



-- 18. List All Cars with Their Current Lease Information.

select v.vehicleID, concat(v.make,' ', v.model) "Vehicle Name", l.leaseId, concat(c.firstName,' ', c.lastName) "Customer Name", l.startDate, l.endDate
from vehicles v
left join leases l on v.vehicleID = l.vehicleID
left join customers c on l.customerId = c.customerId;




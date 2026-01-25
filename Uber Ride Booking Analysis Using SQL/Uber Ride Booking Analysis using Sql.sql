-- Project Uber Ride Booking Analysis
USE e_commerce_platform;

CREATE TABLE uber_rides (
    `Date` DATE,`Time` TIME,`Booking ID` VARCHAR(50),`Booking Status` VARCHAR(50),`Customer ID` VARCHAR(50),`Vehicle Type` VARCHAR(50),`Pickup Location` VARCHAR(50),
    `Drop Location` VARCHAR(50),`Avg VTAT` INT,`Avg CTAT` INT,`Cancelled Rides by Customer` INT,`Reason for cancelling by Customer` VARCHAR(100),`Cancelled Rides by Driver` INT,
    `Driver Cancellation Reason` VARCHAR(100),`Incomplete Rides` INT,`Incomplete Rides Reason` VARCHAR(100),`Booking Value` INT,`Ride Distance` INT,`Driver Ratings` INT,
    `Customer Rating` INT,`Payment Method` VARCHAR(50)
);

SET GLOBAL local_infile = 1;
LOAD DATA LOCAL INFILE 'C:/Users/HP/Desktop/CSV/Uber Ride Booking Clean Dataset.csv'
INTO TABLE uber_rides
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


Use e_commerce_platform;
select * from uber_rides;

-- Count of Customer by Booking Status
select `Booking Status`, Count(Distinct(`Booking ID`)) from uber_rides
group by `Booking Status`;

-- Total Booking
select Count(`Booking ID`) from uber_rides;

-- Total Customer of Uber 
Select Count(Distinct(`Customer ID`)) from uber_rides;

--  Unique vehicle
select Distinct(`Vehicle Type`) from uber_rides;

-- The no.of Booking by Payment Method
Select `Payment Method`, Count(`Booking ID`)as Total_Booking 
from uber_rides
group by `Payment Method` order by Total_Booking desc ;

-- Average Booking Value
Select avg(`Booking Value`) from uber_rides;

-- avg ride distance
select avg(`Ride Distance`), Avg(`Driver Ratings`)
from uber_rides;

-- Insert a time frame conditional column  in  table
-- Add Timeframe Column
-- FIrst add a empty column
Alter table uber_rides
add column Time_Frame TIME;

Select `Booking ID`, `Time`, 
CASE 
    when Hour(`Time`) >=6 AND  Hour(`Time`)<12 Then 'Morning'
    when Hour(`Time`)>=12 AND Hour(`Time`) <17 Then 'Afternoon'
    when Hour(`Time`)>=17 AND Hour(`Time`) <= 21 Then 'Evening'
    else 'Night'
END as Time_Frame
from uber_rides;

ALTER TABLE uber_rides
DROP COLUMN Time_Frame;

-- Payment Type by sum of Boooking value
select `Payment Method`, Sum(`Booking Value`) as Total_Booking_Value 
from uber_rides
group by `Payment Method` order by Total_Booking_Value Desc;

-- most Booking by Pickup location
select `Pickup Location` , Sum(`Booking Value`) as Total_Booking_Value
from uber_rides
group by `Pickup Location` Order by Total_Booking_Value desc limit 10;

-- Which vehicle type has highest Cancelled Rides
select `Vehicle Type`, COUNT(`Booking Status`) as Total_cancelled_ride from uber_rides
where `Booking Status` = "Cancelled by Customer"
group by `vehicle Type` order by Total_cancelled_ride desc;

use e_commerce_platform;
-- What is the most common reason for customer cancellation
select `Reason for cancelling by customer` as Customer_Cancellation_Reason
from uber_rides
group by `Reason for cancelling by customer`;

-- Which Vehicle has highest driver cancellation rate
Select `Vehicle Type`, Sum(`Cancelled Rides by Driver`) as Total_Cancelled_Rides
from uber_rides
group by `Vehicle Type`
Order by Total_Cancelled_Rides desc;

-- What is the average (Pickup Time) VTAT for each vehicle type?
 select `Vehicle Type`, avg(`AVg VTAT`) as AVG_Pickup_Time from 
 uber_rides  group by `Vehicle Type` 
 order by AVG_Pickup_Time;
 
 -- Avg distance, Revenue/ Booking Value by Vehicle type
Select `Vehicle Type`, Avg(`Ride Distance`) As Avg_Distance, Sum(`Booking Value`) as Total_Revenue
from uber_rides
where `Booking Status` = 'Completed'
group by `Vehicle Type`
Order by Total_Revenue desc;

SELECT HOUR(`Time`) as Hour_of_Day, COUNT(`Booking ID`) as Total_Rides
FROM uber_rides
GROUP BY 1
ORDER BY Total_Rides DESC;  -- 6 to 10 am highest booking are there.
 
 -- Which Pickup Locations have the highest Cancelled Rides by Driver?
 SELECT `Pickup Location`, COUNT(*) as Cancelled_Count
FROM uber_rides
WHERE `Booking Status` = 'Cancelled by Driver'
GROUP BY 1
ORDER BY Cancelled_Count DESC
LIMIT 5;

-- Calculate avg - VTAT, Customer Rating, sum - Cancelled Rides by Customer, cancelled rides by driver, incomplete ride, Booking value
select Avg(`Avg VTAT`), sum(`Cancelled Rides by Customer`),Sum(`Cancelled Rides by Driver`),sum(`Incomplete Rides`), 
sum(`Booking Value`),avg(`Customer Rating`)
from uber_rides;

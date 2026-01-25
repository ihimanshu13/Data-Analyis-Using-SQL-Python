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

select * from uber_rides;


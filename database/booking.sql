-- phpMyAdmin SQL Dump
-- version 5.0.2
-- Generation Time: Jan 28,2022 at 12:00 PM
-- 
-- PHP Version: 7.2.33
SET SQL_MODE ="NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
-- 
-- 
-- DATABASE: 'booking'
-- 
--  -------------------------------------------
-- Table structure for table 'booked'
-- 
-- 
CREATE TABLE booked(
id int(30) NOT NULL,
schedule_id int(30) NOT NULL,
ref_no text NOT NULL,
name varchar(250) NOT NULL,
qty int(11) NOT NULL,
status tinyint(1) DEFAULT 0 COMMENT '1=paid, 0- unpaid'
-- date_updated datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 
-- 
-- Dumping data for table 'booked'
-- 
INSERT INTO booked (id, schedule_id, ref_no, name
,qty,status)VALUES (1,1,297979278,"Pascal JUMA",
1,1);
-- 
--
CREATE TABLE bus (
id int(30) NOT NULL,
name varchar(250) NOT NULL,
bus_number varchar(50) NOT NULL,
status tinyint(1) NOT NULL DEFAULT 1 COMMENT '0=inactive, 1 = active'
-- date_updated' datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table 'bus'
-- 
INSERT INTO bus (id, name ,bus_number, status) 
VALUES (3, "Buscar", 5001, 1);
-- 
-- Table structure for table 'location'
-- 
CREATE TABLE location (
id int(30) NOT NULL,
terminal_name text NOT NULL,
city varchar(250) NOT NULL,
state varchar(250) NOT NULL
-- status tinyint(1) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table 'location'
-- 
INSERT INTO location (id, terminal_name, city,state)VALUES(1,"Kinatwa stage", "kitui",1);
-- 
-- Table structure for table 'schedule_list'
-- 
CREATE TABLE schedule_list (
id int(30) NOT NULL,
bus_id int(30) NOT NULL,
from_location int(30) NOT NULL,
to_location int(30) NOT NULL,
departure_time datetime NOT NULL,
eta datetime NOT NULL,
status tinyint(4) NOT NULL DEFAULT 1,
availability int(11) NOT NULL,
price text NOT NULL
-- date_updated' timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Dumping data for table 'schedule_list'
-- 
INSERT INTO schedule_list (id, bus_id, from_location,
to_location,departure_time,eta,status,availability,price)
VALUES(1, 3, "kinatwa stage", "Afya centre", 2022-01-29 14:11:00, 2022-01-30 14:10:00,1, 30,240);

-- 
-- Table data for table 'users'
-- 
CREATE TABLE users (
id int(30) NOT NULL,
name varchar(150) NOT NULL,
user_type tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 =admin, 2=faculty, 3=student',
username varchar(25) NOT NULL,
password varchar(25) NOT NULL,
status tinyint(1) NOT NULL DEFAULT 1 
-- CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 
-- Dumping data for table 'users'
-- 
INSERT INTO users (id, name, user_type,username,password,status,date_updated)VALUES
(1,"Admin",1,"admin","admin123",1);
-- 
-- Indexes for dumped tables
-- 
-- 
-- Indexes for table 'booked'
-- 
ALTER TABLE booked
ADD PRIMARY KEY (id);

-- 
-- Indexes for table 'bus'
-- 
ALTER TABLE bus
ADD PRIMARY KEY (id);

-- 
-- Indexes for table 'location'
-- 
ALTER TABLE location
ADD PRIMARY KEY (id);

-- 
-- Indexes for table 'schedule_list'
-- 
ALTER TABLE schedule_list
ADD PRIMARY KEY (id);

-- 
-- Indexes for table 'users'
-- 

ALTER TABLE users
ADD PRIMARY KEY (id);

-- 
-- AUTO_INCREMENT for dumped tables
-- 

-- 
-- AUTO_INCREMENT for table 'booked'
-- 
ALTER TABLE booked
MODIFY id int(30) NOT NULL AUTO_INCREMENT,
AUTO_INCREMENT=4;
-- 
-- AUTO_INCREMENT for table 'location'
-- 
ALTER TABLE location
MODIFY id int(30) NOT NULL AUTO_INCREMENT,
AUTO_INCREMENT=3;

-- 
-- AUTO_INCREMENT for table 'schedule_list'
-- 
ALTER TABLE schedule_list
MODIFY id int(30) NOT NULL AUTO_INCREMENT,
AUTO_INCREMENT=3;

-- 
-- AUTO_INCREMENT for table 'users'
-- 
ALTER TABLE users
MODIFY id int(30) NOT NULL AUTO_INCREMENT,
AUTO_INCREMENT=3;
COMMIT;


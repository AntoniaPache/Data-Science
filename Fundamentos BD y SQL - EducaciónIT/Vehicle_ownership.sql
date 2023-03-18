drop database if exists vehicle_ownership;
create database Vehicle_ownership;
use Vehicle_ownership; 
select * from vehicle_ownership;
create table Vehicle_ownership (
Pais varchar(250) null,
Codigo varchar(11) null,
Año year(4) null,
Vehicles_per1000 int(10) null
);
select * from Vehicle_ownership;
load data infile 'C:\Users\ANTONIA\Documents' 
into table vehicle_ownership 
FIELDS TERMINATED BY ','
ENCLOSED BY '"';
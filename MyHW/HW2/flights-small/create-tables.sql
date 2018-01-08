-- Jiashuo Zhang hw2 part1
.mode csv

PRAGMA foreign_keys=ON;

create table Carriers(
	cid varchar(10) primary key,
	name varchar(100));

create table Months(
	mid int primary key,
	month varchar(10));

create table Weekdays(
	did int primary key,
	day_of_week varchar(10));

create table Flights(
	fid int primary key,
	year int,
	month_id int references Months(mid),
	day_of_month int,
	day_of_week_id int references Weekdays(did),
	carrier_id varchar(10) references Carriers(cid),
	flight_num int,
	origin_city varchar(100),
	origin_state varchar(50),
	dest_city varchar(100),
	dest_state varchar(50),
	departure_delay real,
	taxi_out real,
	arrival_delay real,
	canceled int,
	actual_time real,
	distance real);

.import carriers.csv Carriers
.import months.csv Months
.import weekdays.csv Weekdays
.import flights-small.csv Flights


-- Jiashuo Zhang hw2 part1
.mode csv

PRAGMA foreign_keys=ON;

create table Flights(
	fid int primary key,
	year int,
	month_id int references Months(mid),
	day_of_month int,
	day_of_week_id int references Weekdays(did),
	carrier_id varchar references Carriers(cid),
	flight_num int,
	origin_city varchar,
	origin_state varchar,
	dest_city varchar,
	dest_state varchar,
	departure_delay real,
	taxi_out real,
	arrival_delay real,
	canceled int,
	actual_time real,
	distance real);

create table Carriers(
	cid varchar primary key,
	name varchar);

create table Months(
	mid int primary key,
	month varchar);

create table Weekdays(
	did int primary key,
	day_of_week varchar);

.import flights-small.csv Flights
.import carriers.csv Carriers
.import months.csv Months
.import weekdays.csv Weekdays

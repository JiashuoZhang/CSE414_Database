-- Jiashuo Zhang hw3
-- Flights (fid, year, month_id, day_of_month, day_of_week_id, carrier_id, flight_num, 
--          origin_city, origin_state, dest_city, dest_state, departure_delay, taxi_out, 
--          arrival_delay, canceled, actual_time, distance)
-- Carriers (cid, name)
-- Months (mid, month)
-- Weekdays (did, day_of_week)

-- 1. For each origin city, find the destination city (or cities) with the longest direct flight. 
-- By direct flight, we mean a flight with no intermediate stops. Judge the longest flight in time, 
-- not distance. Show the name of the origin city, destination city, and the flight time between them. 
-- Do not include duplicates of the same origin/destination city pair. 
-- Order the result by origin_city name then destination city name.
-- [333 rows]
-- Returns 333 rows and takes 14s
select distinct f1.origin_city, f1.dest_city, t1.maxtime
from Flights f1, 
        (select origin_city, max(actual_time) as maxtime
        from Flights
        group by origin_city) t1
where f1.origin_city = t1.origin_city and f1.actual_time = t1.maxtime
order by f1.origin_city, f1.dest_city;

-- 2. Find all origin cities that only serve flights shorter than 3 hours. 
-- You can assume that flights with NULL actual_time are not 3 hours or more. 
-- Return only the names of the cities sorted by name. List each city only once in the result. 
-- [147 rows]
-- Returns 147 rows and takes 30s
select distinct f1.origin_city
from Flights f1
where f1.origin_city not in 
						(select f2.origin_city
						from Flights f2
						where f2.actual_time >= 180)
order by f1.origin_city;

-- 3. For each origin city, find the percentage of departing flights shorter than 3 hours. 
-- For this question, treat flights with null actual_time values as longer than 3 hours. 
-- Return the name of the city and the percentage value. Order by percentage value. 
-- Be careful to handle cities without any flights shorter than 3 hours. 
-- We will accept both 0 and NULL as the result for those cities. [327 rows]
-- Returns 327 rows and takes 13s
select t1.origin_city, (100.0 * shorterFlights / totalFlights) as percentage
from	(select f1.origin_city, count(*) as totalFlights 
		from Flights f1
		group by f1.origin_city) t1
		left outer join
		(select f1.origin_city, count(*) as shorterFlights
		from Flights f1
		where f1.actual_time < 180 or f1.actual_time = NULL
		group by f1.origin_city) t2
		on t1.origin_city = t2.origin_city
order by percentage;

-- 325 rows, calculates the number of departing flights < 3 hours
select f1.origin_city, count(*) as shorterFlights
from Flights f1
where f1.actual_time < 180 or f1.actual_time = NULL
group by f1.origin_city;

-- 327 rows, calculates the number of total flights
select f1.origin_city, count(*) as totalFlights 
from Flights f1
group by f1.origin_city;

-- 4. List all cities that cannot be reached from Seattle though a direct flight 
-- but can be reached with one stop (i.e., with two flights). 
-- Do not include Seattle as one of these destinations (even though you could get back 
-- with two flights). Order results alphabetically. [256 rows]
select distinct f2.dest_city
from Flights f1, Flights f2
where f1.origin_city = 'Seattle WA' and 
		f1.dest_city = f2.origin_city and
		f2.dest_city != 'Seattle WA' and
		f2.dest_city not in
							(select f3.dest_city
							from Flights f3
							where origin_city = 'Seattle WA')
order by f2.dest_city;

-- 5. List all cities that cannot be reached from Seattle though a direct flight 
-- nor with one stop (i.e., with two flights). Do not forget to consider all cities 
-- that appear in a flight as an origin_city. Order results alphabetically. 
-- [3 or 4 rows]
-- Returns 3 rows and takes 30s
select distinct f.origin_city
from Flights f
where f.origin_city not in
		(select distinct f2.dest_city
		from Flights f1, Flights f2
		where f1.origin_city = 'Seattle WA' and f1.dest_city = f2.origin_city
		union
		select distinct f3.dest_city
		from Flights f3
		where f3.origin_city = 'Seattle WA')
order by f.origin_city;
-- Devils Lake ND
-- Hattiesburg/Laurel MS
-- St. Augustine FL
-- Victoria TX

-- 5 mins
select distinct f.origin_city
from Flights f
where 
	f.origin_city not in
		(select f1.dest_city
		from Flights f1
		where f1.origin_city = 'Seattle WA') and
	f.origin_city not in
		(select f3.dest_city
		from Flights f2, Flights f3
		where f2.origin_city = 'Seattle WA' and f2.dest_city = f3.origin_city)
order by f.origin_city;


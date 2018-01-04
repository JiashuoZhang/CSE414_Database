-- Jiashuo Zhang hw2 part2
-- Flights (fid, year, month_id, day_of_month, day_of_week_id, carrier_id, flight_num, 
--          origin_city, origin_state, dest_city, dest_state, departure_delay, taxi_out, 
--          arrival_delay, canceled, actual_time, distance)
-- Carriers (cid, name)
-- Months (mid, month)
-- Weekdays (did, day_of_week)

-- 1. Find the distinct flight numbers of all flights from Seattle to Boston by Alaska Airlines Inc. on Mondays. 
-- Also notice that, in the database, the city names include the state. So Seattle appears as Seattle WA.
select distinct flight_num
from Flights, Carriers, Weekdays
where origin_city = "Seattle WA" and dest_city = "Boston MA" and
		day_of_week_id = did and day_of_week = "Monday" and
		carrier_id = cid and name = "Alaska Airlines Inc.";

-- 2. Find all flights from Seattle to Boston on July 15th 2015. 
-- Search only for itineraries that have one stop. Both legs of the flight must have occurred 
-- on the same day and must be with the same carrier. The total flight time (actual_time) of the 
-- entire itinerary should be less than 7 hours (but notice that actual_time is in minutes). 
-- For each itinerary, the query should return the name of the carrier, the first flight number, 
-- the origin and destination of that first flight, the flight time, the second flight number, 
-- the origin and destination of the second flight, the second flight time, and finally the total flight time. 
-- [488 rows]
select name, F1.flight_num, F1.origin_city, F1.dest_city, F1.actual_time,
		F2.flight_num, F2.origin_city, F2.dest_city, (F1.actual_time + F2.actual_time) as totalTime
from Flights F1, Flights F2, Carriers, Months
where F1.carrier_id = F2.carrier_id and F1.carrier_id = cid and
		F1.month_id = mid and F2.month_id = mid and month = "July" and
		F1.day_of_month = 15 and F1.year = 2015 and
		F2.day_of_month = 15 and F2.year = 2015 and
		F1.origin_city = "Seattle WA" and F1.dest_city = F2.origin_city and F2.dest_city = "Boston MA" and
		totalTime < 420
group by F1.flight_num, F2.flight_num
limit 20;


-- 3. Find the day of the week with the longest average arrival delay. 
-- Return the name of the day and the average delay. [1 row]
select day_of_week, avg(arrival_delay) as avgDelay
from Flights, Weekdays
where day_of_week_id = did
group by did
order by avgDelay desc
limit 1 ; -- constrain the number of row returned

-- 4.Find the names of all airlines that ever flew more than 1000 flights in one day. 
-- Return only the names. Do not return any duplicates. [11 rows]
select distinct name
from Flights, Carriers--, Months, Weekdays
where carrier_id = cid
group by name, year, month_id, day_of_month
having count(*) > 1000;

-- 5.Find all airlines that had more than 0.5 percent of their flights out of Seattle be canceled. 
-- Return the name of the airline and the percentage of canceled flight out of Seattle. 
-- Order the results by the percentage of canceled flights in ascending order. [6 rows]
select name, (sum(canceled)*100.0 / count(canceled)) as percentage
from Flights, Carriers
where carrier_id = cid and origin_city = "Seattle WA"
group by name
having percentage > 0.5
order by percentage;
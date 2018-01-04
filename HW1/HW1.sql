# Homework 1 Jiashuo Zhang
# Dec 29, 2017

# (1)
-- Create a talbe Edges
CREATE TABLE Edges(
	Source INT, 
	Destination INT
);

-- Insert tuples
INSERT INTO Edges VALUES (10, 5), (6, 25), (1, 3), (4, 4);

-- Return all tuples
SELECT * FROM Edges;

-- Return Source column
SELECT Source FROM Edges;

-- Return all tuples where Source > Destination
SELECT * FROM Edges
WHERE Source > Destination;

-- No error
INSERT INTO Edges VALUES ('-1', '2000');
SELECT * FROM Edges;

# (2)
create table MyRestaurants (
	Name varchar(50), 
	Type varchar(20), 
	Dist int,
	LastVisit varchar(10), 
	iLike int);

# (3)
INSERT INTO MyRestaurants VALUES ('hub', 'junkfood', 10, '2017-10-31', 1);
INSERT INTO MyRestaurants VALUES ('henry', 'chinese', 5, '2017-10-21', 0);
INSERT INTO MyRestaurants VALUES ('udon', 'japanese', 20, '2017-09-01', 1);
INSERT INTO MyRestaurants VALUES ('meesum', 'cantonese', 15, '2017-10-11', 1);
INSERT INTO MyRestaurants VALUES ('caliburger', 'american', 18, '2016-10-11', 0);
INSERT INTO MyRestaurants VALUES ('pho', 'vietnamese', 8, '2017-06-11', NULL);

# (4)
.separator ','
SELECT * FROM MyRestaurants;

.separator '|'
SELECT * FROM MyRestaurants;

.mode column
.width 15 15 15 15 15
SELECT * FROM MyRestaurants;

.headers on
SELECT * FROM MyRestaurants;

.headers off
SELECT * FROM MyRestaurants;

# (5)
SELECT 		Name, Dist
FROM 		MyRestaurants
WHERE 		Dist <= 20
ORDER BY 	Name;

# (6)
SELECT		Name
FROM		MyRestaurants
WHERE		iLike = 1 AND LastVisit < DATE('now', '-3 months');


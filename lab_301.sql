-- SOLUTION: LAB 3.01 | SQL: Normalization, DDL & Aggregation

-- ----------------------------------------------------
-- Exercise 1: Blog Database - Normalized DDL
-- ----------------------------------------------------

-- Authors table
CREATE TABLE authors (
                         id INT PRIMARY KEY AUTO_INCREMENT,
                         name VARCHAR(255) NOT NULL
);

-- Posts table
CREATE TABLE posts (
                       id INT PRIMARY KEY AUTO_INCREMENT,
                       author_id INT NOT NULL,
                       title VARCHAR(255) NOT NULL,
                       word_count INT,
                       views INT,
                       FOREIGN KEY (author_id) REFERENCES authors(id)
);

-- Sample INSERTs (optional)
INSERT INTO authors (name) VALUES ('Maria Charlotte'), ('Juan Perez'), ('Gemma Alcocer');

INSERT INTO posts (author_id, title, word_count, views) VALUES
                                                            (1, 'Best Paint Colors', 814, 14),
                                                            (2, 'Small Space Decorating Tips', 1146, 221),
                                                            (1, 'Hot Accessories', 986, 105),
                                                            (1, 'Mixing Textures', 765, 22),
                                                            (2, 'Kitchen Refresh', 1242, 307),
                                                            (1, 'Homemade Art Hacks', 1002, 193),
                                                            (3, 'Refinishing Wood Floors', 1571, 7542);


-- ----------------------------------------------------
-- Exercise 2: Airline Database - Normalized DDL
-- ----------------------------------------------------

-- Customers
CREATE TABLE customers (
                           id INT PRIMARY KEY AUTO_INCREMENT,
                           name VARCHAR(255) NOT NULL,
                           status VARCHAR(50),
                           total_mileage INT
);

INSERT INTO customers (name, status, total_mileage) VALUES
                                                        ('Agustine Riviera', 'Silver', 115235),
                                                        ('Alaina Sepulvida', 'None', 6008),
                                                        ('Tom Jones', 'Gold', 205767),
                                                        ('Sam Rio', 'None', 2653),
                                                        ('Jessica James', 'Silver', 127656),
                                                        ('Ana Janco', 'Silver', 136773),
                                                        ('Jennifer Cortez', 'Gold', 300582),
                                                        ('Christian Janco', 'Silver', 14642);

-- Aircrafts
CREATE TABLE aircrafts (
                           id INT PRIMARY KEY AUTO_INCREMENT,
                           name VARCHAR(100) NOT NULL,
                           total_seats INT
);

INSERT INTO aircrafts (name, total_seats) VALUES
                                              ('Boeing 747', 400),
                                              ('Airbus A330', 236),
                                              ('Boeing 777', 264);

-- Flights
CREATE TABLE flights (
                         flight_number VARCHAR(10) PRIMARY KEY,
                         aircraft_id INT,
                         mileage INT,
                         FOREIGN KEY (aircraft_id) REFERENCES aircrafts(id)
);

INSERT INTO flights (flight_number, aircraft_id, mileage) VALUES
                                                              ('DL143', 1, 135),
                                                              ('DL122', 2, 4370),
                                                              ('DL53', 3, 2078),
                                                              ('DL222', 3, 1765),
                                                              ('DL37', 1, 531);

-- Bookings (many-to-many: customer <-> flight)
CREATE TABLE bookings (
                          id INT PRIMARY KEY AUTO_INCREMENT,
                          customer_id INT,
                          flight_number VARCHAR(10),
                          FOREIGN KEY (customer_id) REFERENCES customers(id),
                          FOREIGN KEY (flight_number) REFERENCES flights(flight_number)
);

INSERT INTO bookings (customer_id, flight_number) VALUES
                                                      (1, 'DL143'),
                                                      (1, 'DL122'),
                                                      (2, 'DL122'),
                                                      (1, 'DL143'),
                                                      (3, 'DL122'),
                                                      (3, 'DL53'),
                                                      (1, 'DL143'),
                                                      (4, 'DL143'),
                                                      (1, 'DL143'),
                                                      (3, 'DL222'),
                                                      (5, 'DL143'),
                                                      (4, 'DL143'),
                                                      (6, 'DL222'),
                                                      (7, 'DL222'),
                                                      (5, 'DL122'),
                                                      (4, 'DL37'),
                                                      (8, 'DL222');

-- ----------------------------------------------------
-- Exercise 3: Queries
-- ----------------------------------------------------

-- 1. Total number of flights:
SELECT COUNT(DISTINCT flight_number) FROM flights;

-- 2. Average flight distance:
SELECT AVG(mileage) FROM flights;

-- 3. Average number of seats per aircraft:
SELECT AVG(total_seats) FROM aircrafts;

-- 4. Average miles flown by customers, grouped by status:
SELECT status, AVG(total_mileage) FROM customers GROUP BY status;

-- 5. Max miles flown by customers, grouped by status:
SELECT status, MAX(total_mileage) FROM customers GROUP BY status;

-- 6. Number of aircrafts with "Boeing" in their name:
SELECT COUNT(*) FROM aircrafts WHERE name LIKE '%Boeing%';

-- 7. Flights with distance between 300 and 2000 miles:
SELECT * FROM flights WHERE mileage BETWEEN 300 AND 2000;

-- 8. Average flight distance booked, grouped by customer status:
SELECT c.status, AVG(f.mileage) AS avg_distance
FROM bookings b
         JOIN customers c ON b.customer_id = c.id
         JOIN flights f ON b.flight_number = f.flight_number
GROUP BY c.status;

-- 9. Most booked aircraft among Gold members:
SELECT a.name, COUNT(*) AS total_bookings
FROM bookings b
         JOIN customers c ON b.customer_id = c.id
         JOIN flights f ON b.flight_number = f.flight_number
         JOIN aircrafts a ON f.aircraft_id = a.id
WHERE c.status = 'Gold'
GROUP BY a.name
ORDER BY total_bookings DESC
LIMIT 1;

CREATE DATABASE IF NOT EXISTS `ics0012_anesterova_MailOrder`;
USE ics0012_anesterova_MailOrder;

CREATE TABLE IF NOT EXISTS customers (
	id INT auto_increment PRIMARY KEY,
    zip_code INT NOT NULL,
    first_name VARCHAR(55) NOT NULL,
    last_name VARCHAR(55) NOT NULL
	);

CREATE TABLE IF NOT EXISTS employees (
	id INT auto_increment PRIMARY KEY,
    zip_code INT NOT NULL,
    first_name VARCHAR(55) NOT NULL,
    last_name VARCHAR(55) NOT NULL
	);
    
CREATE TABLE IF NOT EXISTS orders (
	id INT auto_increment PRIMARY KEY,
    customer_id INT NOT NULL,
    employee_id INT,
    date_of_receipt VARCHAR(30) NOT NULL,
    exp_ship_date VARCHAR(30) NOT NULL,
    actual_ship_date VARCHAR(30) NULL,
    FOREIGN KEY (customer_id) REFERENCES customers (id),
    FOREIGN KEY (employee_id) REFERENCES employees (id)
	);
   
CREATE TABLE IF NOT EXISTS parts (
	id INT auto_increment PRIMARY KEY,
    naming VARCHAR(255) NOT NULL,
    price FLOAT,
    quantity_in_stock INT
	);

CREATE TABLE IF NOT EXISTS orders_parts (
	order_id INT NOT NULL,
    part_id INT NOT NULL,
    quantity_of_part INT,
    PRIMARY KEY (order_id, part_id),
    FOREIGN KEY (order_id) REFERENCES orders (id),
    FOREIGN KEY (part_id) REFERENCES parts (id)
	);
    
    
insert into customers (zip_code, first_name, last_name) values (75103, 'Todd', 'Shiel');
insert into customers (zip_code, first_name, last_name) values (20601, 'Franzen', 'Henkmann');
insert into customers (zip_code, first_name, last_name) values (74807, 'Justen', 'Drew');
insert into customers (zip_code, first_name, last_name) values (79613, 'Valina', 'Harnett');
insert into customers (zip_code, first_name, last_name) values (49303, 'Aldous', 'Slocomb');


insert into employees (zip_code, first_name, last_name) values (41543, 'Toby', 'Galbraeth');
insert into employees (zip_code, first_name, last_name) values (29023, 'Catlaina', 'Boriston');
insert into employees (zip_code, first_name, last_name) values (43221, 'Anastassia', 'Scandrett');


insert into parts (naming, price, quantity_in_stock) values ('6 batteries (AA)', 3.74, 4539);
insert into parts (naming, price, quantity_in_stock) values ('LED light bulb', 1.87, 1117);
insert into parts (naming, price, quantity_in_stock) values ('Power strip', 13.37, 128);
insert into parts (naming, price, quantity_in_stock) values ('USB-C to USB adapter', 2.37, 838);
insert into parts (naming, price, quantity_in_stock) values ('Door hinge', 2.74, 150);
insert into parts (naming, price, quantity_in_stock) values ('Water filter 200L', 23.58, 963);
insert into parts (naming, price, quantity_in_stock) values ('Door knob', 14.63, 52);
insert into parts (naming, price, quantity_in_stock) values ('Box nail', 0.23, 4208);
insert into parts (naming, price, quantity_in_stock) values ('Furniture caster wheel', 1.82, 2458);
insert into parts (naming, price, quantity_in_stock) values ('Vacuum cleaner bag', 5.15, 324);


insert into orders (customer_id, employee_id, date_of_receipt, exp_ship_date, actual_ship_date) VALUES
(1, 2, '01:12:41 10-10-2024', '10:00:00 25-10-2024', '09:54:21 25-10-2024'),
(1, 1, '18:27:14 16-11-2024', '10:00:00 02-12-2024', NULL),
(2, 1, '13:15:04 08-10-2024', '13:00:00 11-10-2024', '16:10:12 11-10-2024'),
(2, 3, '13:18:54 08-10-2024', '13:00:00 11-10-2024', '16:10:22 11-10-2024'),
(2, 2, '11:01:32 05-11-2024', '13:00:00 11-11-2024', '12:54:34 08-11-2024'),
(3, 2, '18:22:12 01-10-2024', '11:00:00 15-10-2024', '11:08:42 14-10-2024'),
(3, 1, '16:14:25 01-11-2024', '11:00:00 15-11-2024', NULL),
(4, 3, '12:24:37 02-12-2023', '16:00:00 21-12-2023', '15:12:48 28-12-2023'),
(4, 1, '04:42:16 18-02-2024', '16:00:00 23-02-2024', '15:56:37 23-02-2024'),
(4, 2, '22:33:15 04-03-2024', '16:00:00 07-03-2024', '16:02:47 07-03-2024'),
(4, 3, '23:24:19 15-11-2024', '16:00:00 19-11-2024', NULL),
(5, 3, '14:47:57 10-09-2024', '14:30:00 18-09-2024', '14:24:53 18-09-2024'),
(5, 1, '17:43:16 11-11-2024', '14:30:00 25-11-2024', NULL);


insert into orders_parts (order_id, part_id, quantity_of_part) VALUES
(1, 4, 1),
(1, 1, 5),
(2, 2, 3),
(2, 5, 2),
(2, 7, 1),
(2, 8, 20),
(3, 2, 1),
(3, 10, 2),
(4, 2, 2),
(4, 6, 1),
(5, 2, 1),
(5, 1, 2),
(6, 1, 200),
(6, 3, 40),
(6, 4, 20),
(7, 1, 180),
(7, 3, 50),
(7, 4, 15),
(8, 1, 1),
(8, 2, 2),
(9, 1, 1),
(9, 10, 3),
(10, 1, 2),
(10, 9, 4),
(11, 8, 8),
(11, 2, 1),
(12, 1, 1),
(12, 3, 2),
(12, 10, 1),
(13, 4, 1),
(13, 7, 1),
(13, 8, 20);


SELECT o.id AS 'Order number', concat(c.first_name, " ", c.last_name) AS "Customer name", 
sum(o_p.quantity_of_part) AS "Number of ordered items", ROUND(sum(o_p.quantity_of_part * p.price), 2) AS 'Total sum', 
o.exp_ship_date AS 'Expected shipping date', o.actual_ship_date AS 'Actual shipping date' FROM orders o
JOIN customers c ON o.customer_id = c.id 
JOIN orders_parts o_p ON o.id = o_p.order_id
JOIN parts p ON p.id = o_p.part_id
WHERE STR_TO_DATE(o.date_of_receipt, '%H:%i:%s %d-%m-%Y') 
BETWEEN STR_TO_DATE('00:00:00 01-11-2024', '%H:%i:%s %d-%m-%Y') 
AND STR_TO_DATE('23:59:59 17-11-2024', '%H:%i:%s %d-%m-%Y')
GROUP BY o.id;


SELECT o.id AS 'Order number', o.date_of_receipt AS 'Date and time of the order', concat(c.first_name, " ", c.last_name) AS "Customer name", 
p.naming AS 'Part name', o_p.quantity_of_part AS 'Quantity', ROUND(p.price * o_p.quantity_of_part, 2) AS 'Price' FROM orders o
JOIN customers c ON c.id = o.customer_id
JOIN orders_parts o_p ON o_p.order_id = o.id
JOIN parts p ON p.id = o_p.part_id
WHERE o.id = 6;


SELECT p.naming AS 'Part name', count(o_p.order_id) AS 'Frequency of ordering' FROM parts p
JOIN orders_parts o_p ON o_p.part_id = p.id
GROUP BY p.id;
create database Zomato;
use zomato;

-- Question - 1
create table Salespeople ( snum int, sname varchar(50) , city varchar (50) , comm decimal(4,2));
insert into Salespeople (snum , sname , city , comm) values 
(1001, 'Peel', 'London', 0.12),
(1002, 'Serres', 'San Jose', 0.13),
(1003, 'Axelrod', 'New York', 0.10),
(1004, 'Motika', 'London', 0.11),
(1007, 'Rafkin', 'Barcelona', 0.15);
select * from Salespeople ;

-- Question - 2
create table orders ( cnum int , cname varchar(50) , city varchar(50)  , rating int , snum int );
insert into orders (cnum , cname , city , rating  , snum ) values
(2001, 'Hoffman' , 'London' , 100 , 1001),
(2002, 'Glovanne', 'Rome' , 200 , 1003),
(2003, 'Liu', 'San Jose' , 300 , 1002),
(2004 , 'Grass' , 'Berlin', 100, 1002),
(2006 , 'Clemens' , 'London' , 300 , 1007),
(2007 , 'Pereira' , 'Rome' , 100 , 1004),
(2008 , 'James', 'London' , 200 , 1007) ;
select * from cust;
Rename table orders to Cust;
select * from cust;

-- Question - 3
CREATE TABLE orders ( onum int , amt decimal(10, 2), odate date, cnum int, snum int );

insert into  orders (onum, amt, odate, cnum, snum) values
(3001, 18.69, '1994-10-03', 2008, 1007),
(3002, 1900.10, '1994-10-03', 2007, 1004),
(3003, 767.19, '1994-10-03', 2001, 1007),
(3005, 5160.45, '1994-10-03', 2003, 1002),
(3006, 1098.16, '1994-10-04', 2008, 1007),
(3007, 75.75, '1994-10-05', 2004, 1002),
(3008, 4723.00, '1994-10-05', 2006, 1001),
(3009, 1713.23, '1994-10-06', 2002, 1003),
(3010, 1309.95, '1994-10-06', 2004, 1002),
(3011, 9891.88, '1994-10-06', 2006, 1001);
select * from orders;

-- Question - 4
select 
s.sname AS salesperson_name,
c.cname AS customer_name,
s.city AS city
from Salespeople s JOIN Cust c ON s.city = c.city;

-- Question - 5
select
c.cname AS customer_name,
s.sname AS salesperson_name
from Cust c JOIN Salespeople s ON c.snum = s.snum;

-- Question - 6
SELECT o.onum, o.amt, o.odate, o.cnum, o.snum
FROM orders o
JOIN cust c ON o.cnum = c.cnum  -- Join orders with customers on customer number
JOIN salespeople s ON o.snum = s.snum  -- Join orders with salespeople on salesperson number
WHERE c.city != s.city;  -- Condition to check if the cities are different

-- Question - 7
SELECT o.onum, c.cname
FROM orders o
JOIN cust c ON o.cnum = c.cnum;

-- Question - 8
  
SELECT a.cname AS customer_name1, b.cname AS customer_name2, a.rating 
FROM cust a
JOIN cust b 
ON a.rating = b.rating
WHERE a.cname < b.cname;

-- Question - 9
SELECT s1.cname AS customer1, s2.cname AS customer2, s1.snum
FROM cust s1
JOIN cust s2 ON s1.snum = s2.snum
WHERE s1.cnum < s2.cnum
ORDER BY s1.snum, customer1, customer2;

-- Question - 10
select s1.sname as salesperson1,s2.sname as salesperson2,s1.city
from salespeople as s1 inner join salespeople as s2 on s1.city=s2.city and s1.sname<s2.sname;

-- Question - 11
select s1.sname as salesperson1,s2.sname as salesperson2,s1.city
from salespeople as s1 inner join salespeople as s2 on s1.city=s2.city and s1.sname<s2.sname;

-- Question - 12
SELECT onum, amt, odate, cnum, snum
FROM orders
WHERE odate = '1994-10-04' 
  AND amt > (SELECT AVG(amt) FROM orders WHERE odate = '1994-10-04');
  
-- Question - 13
SELECT o.onum, o.amt, o.odate, o.cnum, o.snum
FROM orders o
JOIN salespeople s
ON o.snum = s.snum
WHERE s.city = 'London';

-- Question - 14
SELECT c.cnum, c.cname
FROM cust c
WHERE c.cnum > (
    SELECT s.snum + 1000
    FROM salespeople s
    WHERE s.sname = 'Serres'
    LIMIT 1
);

-- Question - 15
SELECT COUNT(*) AS customer_count
FROM cust c
WHERE c.rating > (
    SELECT AVG(rating)
    FROM cust
    WHERE city = 'San Jose'
);

-- Question - 16
SELECT s.snum, s.sname, COUNT(DISTINCT o.cnum) AS customer_count
FROM salespeople s
JOIN orders o ON s.snum = o.snum
GROUP BY s.snum, s.sname
HAVING COUNT(DISTINCT o.cnum) > 1;

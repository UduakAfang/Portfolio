Select * 
from booking_records;

select * 
from customer_records;

-- Identify Duplicate Records based on Ticket_number Column
Select ticket_number, count(*)
from booking_records
group by Ticket_Number
order by count(*) desc;
-- No Duplicates Seen--

-- Want to see top 15 customers(name AND customer_id) based on Ticket Sales--
Select * 
from
(Select c.Customer_id, Name, Sum(Total_Price), 
rank() over(order by Sum(Total_Price) desc) as rank_top_customers
from booking_records b
join customer_records c on b.Name = c.Customer_Name
group by Customer_id) x
where x.rank_top_customers < 16;

-- Most Popular Routes (to and from) --
select IATA_Code_Des, count(*)
from booking_records
group by IATA_Code_Des
ORDER BY count(*) desc;
-- ABV - LOS was first with 46 --

-- Take a look at new customers in each year 2019,2020 and 2021)
-- 2019

SELECT c.Customer_id, Customer_Name
FROM amitdb.customer_records c
WHERE NOT EXISTS (
    SELECT 11
    FROM amitdb.demsco_records d 
    WHERE c.Customer_Name=d.Name AND year(d.Booking_Date) in (2018,2020,2021,2022)
)
order by Customer_id;

-- 2020
SELECT c.Customer_id, Customer_Name
FROM amitdb.customer_records c
WHERE NOT EXISTS (
    SELECT 11
    FROM amitdb.demsco_records d 
    WHERE c.Customer_Name=d.Name AND year(d.Booking_Date) in (2018,2019,2021,2022)
)
order by Customer_id;

-- 2021

SELECT c.Customer_id, Customer_Name
FROM amitdb.customer_records c
WHERE NOT EXISTS (
    SELECT 11
    FROM amitdb.demsco_records d 
    WHERE c.Customer_Name=d.Name AND year(d.Booking_Date) in (2018,2019,2020,2022)
)
order by Customer_id;


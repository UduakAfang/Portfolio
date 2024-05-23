-- High Level Sales Analysis

-- What was the total quantity sold for all products?
SELECT SUM(qty)
FROM sales;

-- each product
SELECT pd.product_name, SUM(qty) total_quantity_sold
FROM sales s
JOIN product_details pd ON s.prod_id = pd.product_id 
GROUP BY pd.product_name
ORDER BY 2 DESC;

--What is the total generated revenue for all products before discounts?
SELECT SUM(price * qty) revenue
FROM sales;


-- each product
SELECT pd.product_name, SUM(s.price * qty) total_revenue
FROM sales s
JOIN product_details pd ON s.prod_id = pd.product_id 
GROUP BY pd.product_name
ORDER BY 2 DESC;

-- What was the total discount amount for all products?

SELECT CAST(SUM(qty * price * discount/100.0) AS FLOAT) AS total_discount
FROM sales

-- each product
SELECT pd.product_name, CAST(SUM(qty * s.price * discount/100.0) AS FLOAT) AS total_discount
FROM sales s
JOIN product_details pd ON s.prod_id = pd.product_id 
GROUP BY pd.product_name
ORDER BY 2 DESC;

----        Transaction Analysis

--How many unique transactions were there?
SELECT COUNT(DISTINCT txn_id)
FROM sales;

-- What is the average unique products purchased in each transaction?
SELECT AVG(sub.product_count)
FROM 
    (
    SELECT COUNT(DISTINCT prod_id) product_count
    FROM sales
    GROUP BY txn_id
    ) sub
;

-- What are the 25th, 50th and 75th percentile values for the revenue per transaction?

WITH revenue AS
(
    SELECT txn_id, SUM(price * qty) revenue
    FROM sales
    GROUP BY txn_id
)
SELECT DISTINCT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY revenue) OVER () as "25th Percentile",
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY revenue) OVER () as "50th Percentile",
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY revenue) OVER () as "75th Percentile"
FROM revenue;


-- What is the average discount value per transaction?

SELECT AVG(sub.trans_disc)
FROM
    ( 
        SELECT txn_id, CAST (SUM(price * qty * discount/100.0) as decimal(5,1)) as trans_disc
        FROM sales
        GROUP BY txn_id
    )sub

-- What is the percentage split of all transactions for members vs non-members?

SELECT 
    CAST (100.0 * COUNT(DISTINCT CASE WHEN member = 't' THEN txn_id END)
     / COUNT(DISTINCT txn_id) AS float) AS member_transaction_percentage,
    CAST (100.0 * COUNT(DISTINCT CASE WHEN member = 'f' THEN txn_id END) 
    / COUNT(DISTINCT txn_id) AS float) AS nonmember_transaction_percentage
FROM sales;

-- What is the average revenue for member transactions and non-member transactions?

with revenue AS
    (
        SELECT txn_id, member, CAST (SUM(price * qty * 1.0) AS float) revenue
        FROM sales
        GROUP BY member, txn_id
    )
SELECT member,CAST( AVG(revenue) AS decimal(5,2)) avg_revenue
FROM revenue
GROUP BY member;

-- What are the top 3 products by total revenue before discount?

SELECT TOP 3 pd.product_name, SUM(s.qty * s.price) revenue
FROM sales s
JOIN [product_details] pd on pd.product_id = s.prod_id
GROUP BY pd.product_name
ORDER BY 2 DESC;

-- What is the total quantity, revenue and discount for each segment?

SELECT segment_name, SUM(s.qty * s.price) revenue, 
        SUM(s.qty) quantity,
        CAST(SUM(s.qty * s.price * s.discount/100.0) as float) discount
FROM sales s
JOIN [product_details] pd on pd.product_id = s.prod_id
GROUP BY pd.segment_name;


-- What is the top selling product for each segment?
SELECT segment_name,sub.product_name, total_qty_sold,rank
FROM
    (
        SELECT product_name, pd.segment_name, SUM(s.qty) total_qty_sold,
        ROW_NUMBER () OVER (PARTITION BY pd.segment_name ORDER BY SUM(s.qty) DESC ) rank
        FROM sales s
        JOIN [product_details] pd on pd.product_id = s.prod_id
        GROUP BY segment_name, product_name
    ) sub
WHERE sub.rank = 1
ORDER BY segment_name,sub.rank;


-- What is the total quantity, revenue and discount for each category?

SELECT category_name,
         SUM(s.qty) quantity,
         SUM(s.qty * s.price) revenue, 
         CAST(SUM(s.qty * s.price * s.discount/100.0) as float) discount
FROM sales s
JOIN [product_details] pd on pd.product_id = s.prod_id
GROUP BY pd.category_name;

-- What is the top selling product for each category?

SELECT category_name,sub.product_name, total_qty_sold
FROM
    (
        SELECT product_name, pd.category_name, SUM(s.qty) total_qty_sold,
        ROW_NUMBER () OVER (PARTITION BY category_name ORDER BY SUM(s.qty) DESC ) rank
        FROM sales s
        JOIN [product_details] pd on pd.product_id = s.prod_id
        GROUP BY category_name, product_name
    ) sub
WHERE sub.rank = 1
ORDER BY category_name,sub.rank ASC;

-- What is the percentage split of revenue by product for each segment?

WITH revenue AS (
    SELECT 
        pd.segment_name,
        pd.product_name,
        SUM(s.price * qty) AS total_revenue
    FROM sales s
    JOIN [product_details] pd on pd.product_id = s.prod_id
    GROUP BY product_name, segment_name
)
SELECT 
    segment_name,
    product_name,
    total_revenue,
    100.0 * total_revenue / SUM(total_revenue) OVER (PARTITION BY segment_name) AS percentage_of_segment
FROM revenue;


-- What is the percentage split of revenue by segment for each category?

WITH revenue AS (
    SELECT 
        pd.category_name,
        pd.segment_name,
        SUM(s.price * qty) AS total_revenue
    FROM sales s
    JOIN [product_details] pd on pd.product_id = s.prod_id
    GROUP BY category_name, segment_name
)
SELECT 
    category_name,
    segment_name,
    total_revenue,
    100.0 * total_revenue 
    / 
    SUM(total_revenue) OVER (PARTITION BY category_name) AS percentage_of_category
FROM revenue;

-- What is the percentage split of total revenue by category?

WITH category_revenue AS (
    SELECT 
        pd.category_name,
        SUM(s.price * s.qty) AS total_revenue
    FROM sales s
    INNER JOIN product_details pd ON s.prod_id = pd.product_id
    GROUP BY category_name
)
SELECT 
    category_name,
    total_revenue,
    100.0 * total_revenue / SUM(total_revenue) OVER () AS percentage_of_total_revenue
FROM category_revenue;


-- What is the total transaction “penetration” for each product?
-- (hint: penetration = number of transactions where at least 1 quantity of 
--  a product was purchased divided by total number of transactions)

WITH TransactionCounts AS (
  SELECT
    prod_id,
    COUNT(DISTINCT txn_id) AS transaction_count
  FROM
    sales
  WHERE
    qty > 0
  GROUP BY
    prod_id
),
TotalTransactions AS (
  SELECT
    COUNT(DISTINCT txn_id) AS total_transactions
  FROM
    sales
)
SELECT
  product_name,
  tc.transaction_count,
  CAST(100.0 *  tc.transaction_count AS FLOAT) / tt.total_transactions AS penetration
FROM
  TransactionCounts tc
  CROSS JOIN TotalTransactions tt
      JOIN product_details PD ON TC.prod_id = PD.product_id



-- What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?

WITH TransactionProducts AS (
  SELECT
    txn_id,
    prod_id,
    product_name
  FROM
    sales
    JOIN product_details ON sales.prod_id = product_details.product_id
  WHERE
    qty > 0
),
TransactionCombinations AS (
  SELECT
    tp1.txn_id,
    tp1.product_name AS product1,
    tp2.product_name AS product2,
    tp3.product_name AS product3
  FROM
    TransactionProducts tp1
  JOIN
    TransactionProducts tp2 ON tp1.txn_id = tp2.txn_id AND tp1.prod_id < tp2.prod_id
  JOIN
    TransactionProducts tp3 ON tp1.txn_id = tp3.txn_id AND tp2.prod_id < tp3.prod_id
)
SELECT TOP 1
  product1,
  product2,
  product3,
  COUNT(*) AS combination_count
FROM
  TransactionCombinations
GROUP BY
  product1,
  product2,
  product3
ORDER BY
  combination_count DESC;

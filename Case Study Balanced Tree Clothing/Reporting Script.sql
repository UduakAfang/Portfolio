-- Define the date range for the month to view
DECLARE @StartDate DATE;
DECLARE @EndDate DATE;

-- Calculate the first and last day of the previous month
SET @StartDate = '2021-01-01';
SET @EndDate = '2021-01-31';

-- -- Calculate the first and last day of the previous month
-- SET @StartDate = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 1, 0);
-- SET @EndDate = EOMONTH(@StartDate); -- Only works if date is current

-- High-Level Sales Analysis
-- Total quantity sold for all products
SELECT SUM(qty) AS total_quantity_sold
FROM sales
WHERE start_txn_time BETWEEN @StartDate AND @EndDate;

-- Total quantity sold for each product
SELECT pd.product_name, SUM(qty) AS total_quantity_sold
FROM sales s
JOIN product_details pd ON s.prod_id = pd.product_id 
WHERE start_txn_time BETWEEN @StartDate AND @EndDate
GROUP BY pd.product_name
ORDER BY total_quantity_sold DESC;

-- Total generated revenue for all products before discounts
SELECT SUM(price * qty) AS total_revenue
FROM sales
WHERE start_txn_time BETWEEN @StartDate AND @EndDate;

-- Total generated revenue for each product before discounts
SELECT pd.product_name, SUM(s.price * qty) AS total_revenue
FROM sales s
JOIN product_details pd ON s.prod_id = pd.product_id 
WHERE start_txn_time BETWEEN @StartDate AND @EndDate
GROUP BY pd.product_name
ORDER BY total_revenue DESC;

-- Total discount amount for all products
SELECT CAST(SUM(qty * price * discount / 100.0) AS FLOAT) AS total_discount
FROM sales
WHERE start_txn_time BETWEEN @StartDate AND @EndDate;

-- Total discount amount for each product
SELECT pd.product_name, CAST(SUM(qty * s.price * discount / 100.0) AS FLOAT) AS total_discount
FROM sales s
JOIN product_details pd ON s.prod_id = pd.product_id 
WHERE start_txn_time BETWEEN @StartDate AND @EndDate
GROUP BY pd.product_name
ORDER BY total_discount DESC;

-- Transaction Analysis
-- Number of unique transactions
SELECT COUNT(DISTINCT txn_id) AS unique_transactions
FROM sales
WHERE start_txn_time BETWEEN @StartDate AND @EndDate;

-- Average unique products purchased in each transaction
SELECT AVG(sub.product_count) AS avg_unique_products_per_transaction
FROM (
    SELECT COUNT(DISTINCT prod_id) AS product_count
    FROM sales
    WHERE start_txn_time BETWEEN @StartDate AND @EndDate
    GROUP BY txn_id
) sub;

-- Percentiles for the revenue per transaction
WITH revenue AS (
    SELECT txn_id, SUM(price * qty) AS revenue
    FROM sales
    WHERE start_txn_time BETWEEN @StartDate AND @EndDate
    GROUP BY txn_id
)
SELECT DISTINCT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY revenue) OVER () AS "25th Percentile",
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY revenue) OVER () AS "50th Percentile",
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY revenue) OVER () AS "75th Percentile"
FROM revenue;

-- Average discount value per transaction
SELECT AVG(sub.trans_disc) AS avg_discount_per_transaction
FROM (
    SELECT txn_id, CAST(SUM(price * qty * discount / 100.0) AS DECIMAL(5, 1)) AS trans_disc
    FROM sales
    WHERE start_txn_time BETWEEN @StartDate AND @EndDate
    GROUP BY txn_id
) sub;

-- Percentage split of transactions for members vs non-members
SELECT 
    CAST(100.0 * COUNT(DISTINCT CASE WHEN member = 't' THEN txn_id END) / COUNT(DISTINCT txn_id) AS FLOAT) AS member_transaction_percentage,
    CAST(100.0 * COUNT(DISTINCT CASE WHEN member = 'f' THEN txn_id END) / COUNT(DISTINCT txn_id) AS FLOAT) AS nonmember_transaction_percentage
FROM sales
WHERE start_txn_time BETWEEN @StartDate AND @EndDate;

-- Average revenue for member and non-member transactions
WITH revenue AS (
    SELECT txn_id, member, CAST(SUM(price * qty * 1.0) AS FLOAT) AS revenue
    FROM sales
    WHERE start_txn_time BETWEEN @StartDate AND @EndDate
    GROUP BY member, txn_id
)
SELECT member, CAST(AVG(revenue) AS DECIMAL(5, 2)) AS avg_revenue
FROM revenue
GROUP BY member;

-- Top 3 products by total revenue before discount
SELECT TOP 3 pd.product_name, SUM(s.qty * s.price) AS revenue
FROM sales s
JOIN product_details pd ON pd.product_id = s.prod_id
WHERE start_txn_time BETWEEN @StartDate AND @EndDate
GROUP BY pd.product_name
ORDER BY revenue DESC;

-- Total quantity, revenue, and discount for each segment
SELECT segment_name, SUM(s.qty * s.price) AS revenue, 
       SUM(s.qty) AS quantity,
       CAST(SUM(s.qty * s.price * s.discount / 100.0) AS FLOAT) AS discount
FROM sales s
JOIN product_details pd ON pd.product_id = s.prod_id
WHERE start_txn_time BETWEEN @StartDate AND @EndDate
GROUP BY pd.segment_name;

-- Top selling product for each segment
SELECT segment_name, sub.product_name, total_qty_sold, rank
FROM (
    SELECT product_name, pd.segment_name, SUM(s.qty) AS total_qty_sold,
           ROW_NUMBER() OVER (PARTITION BY pd.segment_name ORDER BY SUM(s.qty) DESC) AS rank
    FROM sales s
    JOIN product_details pd ON pd.product_id = s.prod_id
    WHERE start_txn_time BETWEEN @StartDate AND @EndDate
    GROUP BY segment_name, product_name
) sub
WHERE sub.rank = 1
ORDER BY segment_name, sub.rank;

-- Total quantity, revenue, and discount for each category
SELECT category_name, SUM(s.qty) AS quantity,
       SUM(s.qty * s.price) AS revenue, 
       CAST(SUM(s.qty * s.price * s.discount / 100.0) AS FLOAT) AS discount
FROM sales s
JOIN product_details pd ON pd.product_id = s.prod_id
WHERE start_txn_time BETWEEN @StartDate AND @EndDate
GROUP BY pd.category_name;

-- Top selling product for each category
SELECT category_name, sub.product_name, total_qty_sold
FROM (
    SELECT product_name, pd.category_name, SUM(s.qty) AS total_qty_sold,
           ROW_NUMBER() OVER (PARTITION BY category_name ORDER BY SUM(s.qty) DESC) AS rank
    FROM sales s
    JOIN product_details pd ON pd.product_id = s.prod_id
    WHERE start_txn_time BETWEEN @StartDate AND @EndDate
    GROUP BY category_name, product_name
) sub
WHERE sub.rank = 1
ORDER BY category_name, sub.rank ASC;

-- Percentage split of revenue by product for each segment
WITH revenue AS (
    SELECT pd.segment_name, pd.product_name, SUM(s.price * qty) AS total_revenue
    FROM sales s
    JOIN product_details pd ON pd.product_id = s.prod_id
    WHERE start_txn_time BETWEEN @StartDate AND @EndDate
    GROUP BY product_name, segment_name
)
SELECT segment_name, product_name, total_revenue,
       100.0 * total_revenue / SUM(total_revenue) OVER (PARTITION BY segment_name) AS percentage_of_segment
FROM revenue;

-- Percentage split of revenue by segment for each category
WITH revenue AS (
    SELECT pd.category_name, pd.segment_name, SUM(s.price * qty) AS total_revenue
    FROM sales s
    JOIN product_details pd ON pd.product_id = s.prod_id
    WHERE start_txn_time BETWEEN @StartDate AND @EndDate
    GROUP BY category_name, segment_name
)
SELECT category_name, segment_name, total_revenue,
       100.0 * total_revenue / SUM(total_revenue) OVER (PARTITION BY category_name) AS percentage_of_category
FROM revenue;

-- Percentage split of total revenue by category
WITH category_revenue AS (
    SELECT pd.category_name, SUM(s.price * s.qty) AS total_revenue
    FROM sales s
    INNER JOIN product_details pd ON s.prod_id = pd.product_id
    WHERE start_txn_time BETWEEN @StartDate AND @EndDate
    GROUP BY category_name
)
SELECT category_name, total_revenue,
       100.0 * total_revenue / SUM(total_revenue) OVER () AS percentage_of_total_revenue
FROM category_revenue;

-- Total transaction penetration for each product
WITH TransactionCounts AS (
    SELECT prod_id, COUNT(DISTINCT txn_id) AS transaction_count
    FROM sales
    WHERE qty > 0 AND start_txn_time BETWEEN @StartDate AND @EndDate
    GROUP BY prod_id
),
TotalTransactions AS (
    SELECT COUNT(DISTINCT txn_id) AS total_transactions
    FROM sales
    WHERE start_txn_time BETWEEN @StartDate AND @EndDate
)
SELECT PD.product_name, tc.transaction_count,
       CAST(100.0 * tc.transaction_count AS FLOAT) / tt.total_transactions AS penetration
FROM TransactionCounts tc
CROSS JOIN TotalTransactions tt
JOIN product_details PD ON tc.prod_id = PD.product_id;

-- Most common combination of at least 1 quantity of any 3 products in a single transaction
WITH TransactionProducts AS (
  SELECT
    txn_id,
    prod_id
  FROM
    sales
  WHERE
    qty > 0 AND start_txn_time BETWEEN @StartDate AND @EndDate
),
TransactionCombinations AS (
  SELECT
    tp1.txn_id,
    tp1.prod_id AS product1,
    tp2.prod_id AS product2,
    tp3.prod_id AS product3
  FROM
    TransactionProducts tp1
  JOIN
    TransactionProducts tp2 ON tp1.txn_id = tp2.txn_id AND tp1.prod_id < tp2.prod_id
  JOIN
    TransactionProducts tp3 ON tp1.txn_id = tp3.txn_id AND tp2.prod_id < tp3.prod_id
)
SELECT
  product1,
  product2,
  product3,
  COUNT(*) AS combination_count
INTO CommonCombinationReport
FROM
  TransactionCombinations
GROUP BY
  product1,
  product2,
  product3
ORDER BY
  combination_count DESC
;

-- Final Output Statements
SELECT * FROM CommonCombinationReport;

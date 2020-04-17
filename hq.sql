SELECT id, account_id
FROM orders
WHERE (standard_amt_usd / standard_qty) AS new_table
LIMIT 10

SELECT id,
account_id,
standard_amt_usd / standard_qty AS unit_price
FROM orders
LIMIT 10

SELECT id,
account_id,
(standard / total) *100 AS percentage_of_revenue
FROM orders


All the companies whose names start with 'C'.

SELECT *
FROM accounts
WHERE name = '%C';

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom')



SELECT name,primary_poc,sales_rep_id
FROM accounts
WHERE name LIKE ('Walmart','Target','Nordstrom')

SELECT *
FROM web_events
WHERE channel NOT LIKE ('Organic' 'Adwords')

SELECT *
FROM accounts
WHERE name NOT LIKE ('C%')

SELECT *
FROM accounts
WHERE name NOT LIKE ('%one%')

SELECT *
FROM accounts
WHERE name NOT LIKE ('%S')



SELECT * 
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;


SELECT * 
FROM accounts
WHERE name NOT LIKE 'C%' AND LIKE '%s'

SELECT *
FROM accounts
WHERE name NOT LIKE 'C%' AND name NOT LIKE '%s'

SELECT occurred_at, gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 and 29



SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at IN '2016-02-02'
ORDER BY occured_at DESC

SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000


SELECT id
FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 100 OR poster_qty > 1000)

SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') AND (name LIKE '%ana' OR name LIKE '%Ana%');


JOIN

SELECT accounts.*, orders.*
FROM accounts
JOIN orders
ON orders.account_id = accounts.id

SELECT orders.standard_qty, orders.poster_qty, accounts.website, accounts.primary_poc
FROM orders
JOIN accounts
ON orders.id = accounts.id

SELECT web_events.channel,web_events.occurred_at,accounts.primary_poc, accounts.name
FROM web_events
JOIN accounts 
ON web_events.account_id = accounts.id
WHERE accounts.name IN ('Walmart')

SELECT r.name region, s.name sales_rep, a.name account_name
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id


SELECT r.name region, a.name account
o.total_amt_usd / orders.total  unit_price
FROM region r
JOIN orders o
ON region.id = orders.id
JOIN accounts a
ON orders.account_id = accounts.id

SELECT orders.*,
accounts.*
FROM orders
LEFT JOIN accounts
ON orders.account_id = accounts.id
AND accounts.sale_rep = 12345


*~*~*~ Group By Quiz *~*~*~

SELECT MIN (accounts.name), orders.occurred_at
FROM orders
JOIN accounts
ON orders.account_id = accounts.id
GROUP BY orders.occurred_at
ORDER BY orders.occurred_at DESC

SELECT SUM(orders.total_amt_usd) total_usd, accounts.name
FROM orders
JOIN accounts
ON accounts.id = orders.account_id
GROUP BY accounts.name

SELECT web_events.occurred_at,
accounts.name,
web_events.channel
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
ORDER BY occurred_at DESC
LIMIT 1

SELECT COUNT(*)channel_useage, web_events.channel channel_name 
FROM web_events
GROUP BY web_events.channel

SELECT MIN (orders.total_amt_usd) AS total_usd, accounts.name 
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
GROUP BY accounts.name
ORDER BY total_usd 

SELECT COUNT(*) AS sales_reps, region.name
FROM sales_reps
JOIN region
ON sales_reps.region_id = region.id
GROUP BY region.name
ORDER BY sales_reps


~*~*~ GROUP BY PART || ~*~*~

SELECT accounts.name,
AVG(orders.gloss_qty) AS gloss_money,
AVG(orders.poster_qty) AS poster_money,
AVG(orders.standard_qty) AS standard_money
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
GROUP BY name
ORDER BY name


SELECT accounts.name,
AVG(orders.gloss_amt_usd) AS gloss_money,
AVG(orders.poster_amt_usd) AS poster_money,
AVG(orders.standard_amt_usd) AS standard_money
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
GROUP BY name
ORDER BY name

SELECT sales_reps.name, web_events.channel, COUNT(*) occurences
FROM accounts
JOIN sales_reps
ON sales_reps.id = accounts.sales_rep_id
JOIN web_events 
ON accounts.id = web_events.account_id
GROUP BY sales_reps.name, channel
ORDER BY occurences DESC

SELECT region.name, web_events.channel, 
COUNT(web_events.channel) channel_usage
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
JOIN sales_reps
ON sales_reps.id = accounts.sales_rep_id
JOIN region
ON sales_reps.region_id = region.id
GROUP BY region.name, channel
ORDER BY channel_usage DESC


~*~* DISTINCT *~*~*
SELECT DISTINCT accounts.name acct_name, region.name region_name
FROM accounts
JOIN sales_reps
ON accounts.sales_rep_id = sales_reps.id
JOIN region
ON sales_reps.region_id = region.id


SELECT COUNT(*), sales_reps.id, sales_reps.name
FROM accounts
JOIN sales_reps
ON sales_reps.id = accounts.sales_rep_id
GROUP BY sales_reps.id, sales_reps.name

*~*~* HAVING *~*~*
SELECT COUNT(*) AS total, sales_reps.id, sales_reps.name
FROM accounts
JOIN sales_reps
ON accounts.sales_rep_id = sales_reps.id
GROUP BY sales_reps.id, sales_reps.name
HAVING COUNT(*) > 5
ORDER BY total DESC

SELECT COUNT(*) AS orders, accounts.name, accounts.id
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
GROUP BY accounts.name, accounts.id
HAVING COUNT(*) > 20
ORDER BY orders

SELECT COUNT(*) AS orders, accounts.name, accounts.id
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
GROUP BY accounts.name, accounts.id
ORDER BY orders DESC 
LIMIT 1

SELECT COUNT(*) AS orders, accounts.name, orders.total_amt_usd
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
GROUP BY accounts.name, orders.total_amt_usd
ORDER BY orders.total_amt_usd DESC 
LIMIT 1


SELECT SUM(orders.total_amt_USD) AS sum, accounts.name,accounts.id
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
GROUP BY accounts.name, accounts.id
HAVING SUM(orders.total_amt_usd) > 30000
ORDER BY sum DESC 



SELECT SUM(orders.total_amt_usd) AS SUM, accounts.name
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
GROUP BY accounts.name
HAVING SUM(orders.total_amt_usd) < 1000
ORDER BY SUM  


SELECT SUM(orders.total_amt_usd) AS SUM, accounts.name, accounts.id
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
GROUP BY accounts.name, accounts.id
ORDER BY SUM DESC
LIMIT 1


SELECT SUM(orders.total_amt_usd) SUM, accounts.name, accounts.id
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
GROUP BY accounts.name,accounts.id
ORDER BY SUM(orders.total_amt_usd)
LIMIT 1

SELECT COUNT(*) AS orders, accounts.name, web_events.channel
FROM accounts
JOIN web_events
ON accounts.id = web_events.account_id
GROUP BY accounts.name, web_events.channel
HAVING COUNT(*) > 6 AND channel = 'facebook'
ORDER BY orders 

SELECT COUNT(*) AS orders, accounts.name, web_events.channel
FROM accounts
JOIN web_events
ON accounts.id = web_events.account_id
GROUP BY accounts.name, web_events.channel
HAVING channel = 'facebook'
ORDER BY orders DESC
LIMIT 1

SELECT MAX(web_events.channel) AS winner, accounts.name 
FROM accounts
JOIN web_events
ON accounts.id = web_events.account_id
GROUP BY accounts.name
ORDER BY winner DESC

SELECT accounts.name, accounts.id, web_events.channel, COUNT(*) use_of_channel
FROM accounts
JOIN web_events
ON accounts.id = web_events.account_id
GROUP BY accounts.name, accounts.id, web_events.channel
ORDER BY use_of_channel DESC

LIMIT 10

years

SELECT DATE_TRUNC ('year', occurred_at) AS years, SUM(orders.total_amt_usd)
FROM orders
GROUP BY 1
ORDER BY 2 DESC

SELECT DATE_PART('month', occurred_at) AS years, SUM(orders.total_amt_usd)
FROM orders

GROUP BY 1
ORDER BY 2 DESC

SELECT DATE_PART ('year', occurred_at) AS years, COUNT(*) total
FROM orders
GROUP BY 1
ORDER BY 2 DESC

SELECT DATE_PART ('month', occurred_at) AS years, COUNT(*) totals
FROM orders
GROUP BY 1
ORDER BY 2 DESC

SELECT DATE_TRUNC ('month', occurred_at) AS years, SUM(orders.gloss_amt_usd), accounts.name
FROM orders
JOIN accounts
ON orders.account_id = accounts.id
GROUP BY occurred_at, orders.gloss_amt_usd, accounts.name
HAVING accounts.name = 'Walmart'
ORDER BY 2 DESC
LIMIT 1

Using Case Statements

SELECT account_id
    

SELECT account_id, occurred_at, total
  CASE WHEN total > 500 THEN 'Over 400'
  WHEN total > 1000 THEN 'Over 1000'
  WHEN total > 1500 THEN 'Over 1500'
  ELSE 'Too small' END AS 'new_total_column'
FROM orders

SELECT account_id, occurred_at, total
CASE WHEN total > 500 'over 500'
WHEN total BETWEEN 1000 AND 8000 THEN 'cool'
WHEN total > 500 AND total < 300 THEN 'status'

SELECT account_id,
CASE WHEN standard_qty = 0 OR standard_qty IS NULL
THEN 0 ELSE standard_amt_usd/standard_qty 
END AS unit_price
FROM orders 
LIMIT 10

SELECT CASE WHEN total > 500 THEN 'Over 500'
            ELSE '5000 or under' END AS new_table
FROM orders
GROUP BY 1

*~*~* Case Statement Quiz *~*~

SELECT account_id, total_amt_usd,
CASE WHEN total_amt_usd > '3000' THEN 'Large'
     ELSE 'Small' END AS level_order
FROM orders

SELECT CASE WHEN total > 2000 THEN 'At Least 2000'
      WHEN total BETWEEN 2000 and 1000 THEN 'Between'
      ELSE 'Less than 1000' END as new_totals,
      COUNT(*) usage,
FROM orders
GROUP BY 1


SELECT accounts.name, orders.total,
CASE WHEN orders.total > 200000 THEN 'lifetime value'
      WHEN orders.total BETWEEN 200000 AND 100000 THEN '2nd tier'
      ELSE 'Third Tier' END AS levels

FROM accounts
JOIN orders
ON accounts.id = orders.account_id
GROUP BY 1,2 
ORDER By 2 DESC


SELECT account_id, total_amt_usd,
DATE_PART('year',occurred_at) AS occurred
FROM orders
JOIN accounts
ON accounts.id = orders.account_id
WHERE occurred IS LIKE 2016 
GROUP BY 1,2, occurred

SELECT COUNT(*),sales_reps.name, accounts.id, orders.total,
CASE WHEN orders.total > 200 THEN 'top'
      ELSE 'not' 
      END AS hot_or_not
FROM sales_reps
JOIN accounts
ON sales_reps.id = accounts.sales_rep_id
JOIN orders
ON accounts.id = orders.account_id
GROUP BY 4,2,3 
ORDER BY 4 DESC


SELECT SUM(purch_amt)
FROM orders;

SELECT AVG(purch_amt), COUNT(*) all_orders
FROM orders

SELECT COUNT(DISTINCT salesman_id)
FROM orders
***** would be 12 bc thas the amt of sales_id but DISTINCT eliminate repetiveness, so its 6 ****

SELECT COUNT(*) -- count counts the rows
FROM customers

SELECT COUNT (grade)
FROM customer


SELECT MAX(purch_amt)
FROM orders

SELECT MAX(grade), city
FROM orders

SELECT MAX(purch_amt), customer_id
FROM orders
GROUP BY customer_id (cant use an aggregate function to group by)

SELECT MAX(purch_amt), customer_id, ord_date
FROM orders
GROUP BY customer_id, order_id

SELECT MAX(purch_amt), ord_date, salesman_id
FROM orders
WHERE ord_date = '2012-08-17'
GROUP BY ord_date, salesman_id



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




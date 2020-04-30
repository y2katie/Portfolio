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

SELECT MAX(purch_amt),ord_date,sales_man_id
FROM orders
GROUP BY 2,3
ORDER BY MAX(purch_amt) DESC

SELECT MAX(purch_amt), customer_id, ord_date
FROM orders
GROUP BY 2,3
HAVING MAX(purch_amt) > 2000 AND MAX(purch_amt) < 6000

SELECT purch_amt, customer_id, ord_date
FROM orders
WHERE purch_amt > 2000 AND purch_amt < 6000

SELECT MAX(purch_amt), ord_date, customer_id
FROM orders
GROUP BY ord_date, customer_id
HAVING MAX(purch_amt) IN (2000,3000,5760,6000)

SELECT COUNT(*), ord_date
FROM orders
GROUP BY 2
HAVING ord_date = '2012-08-17'

SELECT COUNT(*)
FROM salesman
WHERE city IS NOT NULL

SELECT COUNT(*) AS num_products, pro_price
FROM item_mast
GROUP BY 2
HAVING pro_price > 350

SELECT SUM(dpt_allotment)
FROM emp_department

SELECT COUNT(*), emp_dept 
FROM emp_details
GROUP BY emp_dept


practice
SELECT channel, 
AVG(num_events)
FROM
(SELECT DATE_TRUNC('day', occurred_at) AS num_events,
channel, COUNT(*) event_count
FROM web_events
GROUP BY 1,2) sub
GROUP BY 1

SubQuery Test

SELECT DATE_TRUNC('day', occurred_at) AS occurred_at,
channel, COUNT(*) events_per_day
FROM web_events
GROUP BY 1,2
ORDER BY events_per_day DESC

SELECT * 
FROM
(SELECT DATE_TRUNC('day', occurred_at) AS occurred_at,
channel, COUNT(*) events_per_day
FROM web_events
GROUP BY 1,2
ORDER BY events_per_day DESC) sub


SELECT AVG(events_per_day),
channel
FROM
(SELECT DATE_TRUNC('day', occurred_at) AS occurred_at,
channel, COUNT(*) events_per_day
FROM web_events
GROUP BY 1,2
ORDER BY events_per_day DESC) sub
GROUP BY 2



SELECT MIN(occurred_at) as MIN
FROM orders

SELECT DATE_TRUNC('month',MIN(occurred_at) as MIN
FROM orders

SELECT *
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
(SELECT DATE_TRUNC('month',MIN(occurred_at)) as min_month
FROM orders)
ORDER BY occurred_at

SELECT AVG(gloss_qty),
       AVG(standard_qty),
       AVG(poster_qty)
FROM ORDERS 
WHERE DATE_TRUNC('year', occurred_at) =
(SELECT DATE_TRUNC('month', MIN(occurred_at))
FROM orders
  ORDER BY 1) sub
  ORDER BY 1,2,3


1
SELECT  reg_name, MAX(total)
selecting the unique region name and maximum total of sales from info below
FROM (
in this query ive already compiled all the data and its ripe for the sub query picking 
SELECT region.name reg_name,sales_reps.name rep_name, SUM(total_amt_usd) total
FROM region
JOIN sales_reps
ON sales_reps.region_id = region.id
JOIN accounts 
ON sales_reps.id = accounts.sales_rep_id
JOIN orders
ON accounts.id = orders.account_id
  GROUP BY 1,2
ORDER BY total DESC ) t1
GROUP BY 1

2
SELECT SUM(orders.total_amt_usd) amt_usd, region.name region_name, COUNT(*) all_orders
FROM orders
JOIN accounts
ON orders.account_id = accounts.id
JOIN sales_reps 
ON accounts.sales_rep_id = sales_reps.id
JOIN region 
ON sales_reps.region_id = region.id
GROUP BY 2

3


4
SELECT channel, COUNT(*) amt_of_events
FROM web_events
(SELECT MAX(total_amt_usd), id
  FROM orders
  GROUP BY 2 ) sub
GROUP BY 1

5

SELECT accounts.name, orders.total_amt_usd
FROM accounts
JOIN orders
ON accounts.id = orders.account_id
GROUP BY 1,2
LIMIT 10


SELECT player_name,
       year,
       CASE WHEN state = 'CA' THEN 'yes'
            ELSE 'NULL' END AS is_a_senior
  FROM benn.college_football_players
  ORDER BY state = 'CA' DESC

  SELECT player_name,
         weight,
  CASE WHEN weight > 250 THEN 'nice'
          WHEN weight >250 AND weight <=250 THEN
          WHEN weight > 150 AND weight <= 90 THEN
          ELSE '175 or under' END AS weight_group
  FROM football_players

SELECT *,
CASE WHEN year IN ('SR','JR') THEN player_name
      ELSE NULL END as new_column
FROM benn.college_football_players



SELECT CASE WHEN year = 'FR' THEN 'FR'
            ELSE 'or not' END AS year_group
            FROM __
            GROUP BY CASE WHEN year = 'FR' THEN 'FR'
            ELSE 'or not' END

SELECT 
    CASE WHEN  state IN ('CA', 'OR', 'WA') THEN 'West Coast'  
    WHEN state IN ('TX') THEN 'Texas'
    ELSE 'Everywhere else' END AS States_Weight,
    COUNT(*) AS players
FROM benn.college_football_players
WHERE weight >=300
GROUP BY 1


SELECT 
      CASE WHEN  year IN ('FR','SO') THEN 'freshies' 
      ELSE 'elders' END AS new_table,
      SUM(weight)
FROM benn.college_football_players
WHERE state ='CA'
GROUP BY 1

WITH table1 AS (
    SELECT *
    FROM web_events), // new table selecting all from web events
    
    table2 AS (
      SELECT *
      FROM accounts) // new table selecting all from accounts

SELECT *
FROM table1
JOIN table2
ON table1.account_id1 = table2.id // joining table on PK and FK


Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.

WITH t1 AS (
  SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) AS total 
  FROM orders o
  JOIN accounts 
  ON o.account_id = accounts.id
  JOIN sales_reps s
  ON accounts.sales_rep_id = s.id
  JOIN region r
  ON s.region_id = r.id
  GROUP BY 1,2
  ) ,
  
t2 AS (
  SELECT region_name,  MAX(total) AS total
  FROM t1
  GROUP BY 1
) 

SELECT t1.rep_name, t1.region_name, t1.total
FROM t1
JOIN t2
ON t1.region_name = t2.region_name AND t1.total = t2.total


For the region with the largest sales total_amt_usd, how many total orders were placed?

WITH table1 AS (
      SELECT total_amt_usd 
      FROM orders),

      table2 AS (
      SELECT name
      FROM region)

SELECT COUNT(*), table1, table2
FROM table1
JOIN accounts
ON table1.account_id = accounts.id
JOIN sales_reps 
ON accounts.sales_rep_id = sales_reps.id
JOIN table2
ON = table2.id = sales_reps.region_id
GROUP BY 2,3

How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?

WITH table1 AS (
      SELECT SUM(o.total_amt_usd) AS total, a.name      AS brand, r.name region_name
      FROM orders o
      JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id 
JOIN region r
ON s.region_id = r.id
GROUP BY 2,3 )

SELECT MAX(total), region_name
FROM table1
GROUP BY 2



For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?

WITH table1 AS (
    SELECT name
    FROM accounts),

 table2 AS (
    SELECT total_amt_usd
    FROM orders),

 table3 AS (
    SELECT channel
    FROM web_events)

SELECT MAX(table2), table1, COUNT(*)
FROM table1
JOIN table2
ON table2.account_id = table1.id
JOIN table3
ON table3.account_id = table1.id

What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?

SUM(orders.total_amt_usd) AS total
WITH table1 AS (
    SELECT name
    FROM accounts),

 table2 AS (
    SELECT total_amt_usd
    FROM orders),

SELECT SUM(orders.total_amt_usd) AS total,
accounts.name 
FROM table1
JOIN table2
ON orders.account_id = accounts.salesman_id
ORDER BY total DESC
LIMIT 10

OR

SELECT SUM(orders.total_amt_usd) AS total,
accounts.name 
FROM orders
JOIN accounts
ON orders.account_id = accounts.id
GROUP BY 2
ORDER BY total DESC
LIMIT 10

What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.


WITH table1 AS (
    SELECT name
    FROM accounts),

 table2 AS (
    SELECT SUM(total_amt_usd)
    FROM orders),

SELECT AVG(table2) AS total,
accounts.name 
FROM table1
JOIN table2
ON orders.account_id = accounts.salesman_id
ORDER BY total DESC
LIMIT 10


SELECT RIGHT(website,3) AS digits , COUNT(*)
FROM accounts
GROUP BY 1

SELECT LEFT(name,1) AS name, COUNT(*) AS total
FROM accounts
GROUP BY 1
ORDER BY total DESC 


SELECT COUNT(*), name,
CASE WHEN LEFT(NAME,1) LIKE '#'THEN 'number'
   ELSE 'letter'  END AS amt
 FROM accounts
 GROUP BY 2

SELECT COUNT(*), name,
CASE WHEN LEFT(NAME,1) LIKE '[1-9]%'THEN 'number'
   ELSE 'letter'  END AS amt
 FROM accounts
 GROUP BY 2

 SELECT COUNT(*), name,
CASE WHEN LEFT(name,1) LIKE '[AEIOU]%' THEN 'vowel'
   END AS amt
 FROM accounts
 GROUP BY 2

To reference alphabet
'[a-z]%'

SELECT SUM(num) AS nums, SUM(letter) AS letters //creating new columns
FROM (
  SELECT name, CASE WHEN LEFT(name,1) IN ('0','1','2','3','4','5','6','7','8','9') THEN 1
  ELSE 0 END AS num, 
  CASE WHEN LEFT(name,1) IN ('0','1','2','3','4','5','6','7','8','9') THEN 0
  ELSE 1 END AS letter
  // very clever trick to go through the numbers and if not there give it a +1 and letters
  if it is there give it a +1 and add to numbers
  then tally up numbers and letters based off logic
  FROM accounts
  ) t1
 

   SELECT SUM(pro_vowel) AS pro_vowel, SUM(anti_vowel) AS anti_vowel
  FROM (
  SELECT name, CASE WHEN LEFT(name,1) IN ('A','E','I','O','U') THEN 1
  ELSE 0 END AS pro_vowel, 
  CASE WHEN LEFT(name,1) IN ('A','E','I','O','U') THEN 0
  ELSE 1 END AS anti_vowel
  FROM accounts
  ) t1


 SELECT primary_poc,
LEFT(primary_poc, POSITION (' ' IN primary_poc)) || '.' || RIGHT( primary_poc, LENGTH(primary_poc) - POSITION (' ' IN primary_poc)) || '@' || RIGHT(website,3) AS new_column 
FROM accounts


SELECT primary_poc,
LEFT(primary_poc, POSITION (' ' IN primary_poc) -1) || '.' || RIGHT( primary_poc, LENGTH(primary_poc) - POSITION (' ' IN primary_poc)) || '@' || RIGHT(website,3) AS new_column 
FROM accounts


SELECT *,
DATE_PART('month', TO_DATE(month,'month')) as clean_month,
CAST(year || DATE_PART('month', TO_DATE(month,'month')) || day AS date ) AS formatted_date or
(year || DATE_PART('month', TO_DATE(month,'month')) || day AS date ) ::date AS formatted_date

SELECT date, (SUBSTRING(DATE,7,4) || '-' ||
SUBSTRING(date,1,2) || '-' || SUBSTRING(date,4,2)) :: date AS new_date
FROM sf_crime_data
LIMIT 10

SELECT COUNT(primary_poc) reg_Count,
COUNT(COALESCE(primary_poc, 'No Poc')) new_count,



SELECT first_name, last_name // outer query selecting first and last name
FROM employees
WHERE salary > 
(SELECT salary
FROM employees
WHERE employee_id = 163 )  // inner query establish ammount of money employee 163 makes


2)
SELECT first_name, last_name, salary, department_id, job_id
FROM employees
WHERE department_id = //outer query saying to grab the following select criteria from the table below that = the department id above
(SELECT department_id
FROM employees
WHERE employee_id = 169) // inner query grabbing department id associated with employee id

3) 
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE salary > 
( SELECT MIN(salary)
FROM employees
)
GROUP BY 1,2,3
ORDER BY 3 

4)
SELECT employee_id, first_name, last_name
FROM employees
WHERE salary > 
( SELECT AVG(salary)
FROM employees
)
GROUP BY 1,2,3
ORDER BY 3 


5) 
SELECT first_name, last_name, employee_id, salary
FROM employees
WHERE manager_id = 
(
SELECT employee_id
FROM employees
WHERE first_name = 'Payam')

6)

SELECT d.department_name, e.first_name, e.employee_id, e.last_name
FROM departments d, employees  e
WHERE d.department_id = e.department_id 
AND d.department_name = 'Finance'
 ^^ very cool way to join tables in the FROM statement

 SELECT city_state
 POSITION(',' IN city_state) AS comma, // places what youre looking for first
 STRPOS(city_state, ',') AS substring, // places strin first then substring or what youre looking for

STRPOS and POSITION are case sensitive so A is different than a
 LOWER(city_state),
 UPPER(city_state)
 LEFT(city_state, POSITION(',' IN city_state)) AS comma,
 FROM data


SELECT primary_poc,
LEFT(primary_poc, POSITION(' ' IN primary_poc)) as first_name,
RIGHT (primary_poc, POSITION (' ' IN primary_poc)) as last_name
FROM accounts

SELECT name,
LEFT(name, POSITION(' ' IN name)) as first_name,
RIGHT(name, POSITION(' ' IN name)) as last_name
FROM sales_reps

SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1) 
// selecting to the left of the primary poc from the space minus 1 character
RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) as last_name
// taking from the right of the primary poc after the space calculating the length of that string and subtracting the string position of the space in the primary poc
FROM accounts

SELECT name,
LEFT (name, position(' ' IN name)) as first_name,
RIGHT (name, LENGTH(name) - position(' ' IN name)) last_name
FROM sales_reps

SELECT first_name, last_name,
CONCAT(first_name, ' ', last_name) AS fullname // creates a new column called fullname with 'Katie Jordan'
FROM
names

Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the first name of the primary_poc . last name primary_poc @ company name .com.

SELECT name,
LEFT(primary_poc, position(' ' IN primary_poc)) AS first_name,
RIGHT(primary_poc, LENGTH(primary_poc) - position(' ' IN primary_poc)) AS last_name,
CONCAT(first_name, '.' , last_name ,'@', name, '.com') AS new_name
FROM accounts

WITH t1 AS (
  SELECT LEFT(primary_poc, POSITION(' 'IN primary_poc)) first_name,
 RIGHT(primary_poc, LENGTH(primary_poc) - POSITION(' ' IN primary_poc)) last_name,
 name
 FROM accounts )
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', name, '.com') AS new_name
FROM t1;

WITH t1 AS (
 SELECT LEFT(primary_poc,     STRPOS(primary_poc, ' ') -1 ) first_name,  RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
 FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', name, '.com')
FROM t1;


SELECT REPLACE (name, ' ','')
FROM sales_reps // removes extra space

-- We would also like to create an initial password, which they will change after their first log in. The first password will be the first letter of the primary_poc's first name (lowercase), then the last letter of their first name (lowercase), the first letter of their last name (lowercase), the last letter of their last name (lowercase), the number of letters in their first name, the number of letters in their last name, and then the name of the company they are working with, all capitalized with no spaces.

WITH t1 AS (
  SELECT LEFT(primary_poc,     STRPOS(primary_poc, ' ') -1 ) first_name,  
  RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name,
  primary_poc,
  LENGTH(first_name),
  LENGTH(last_name),
  name
FROM accounts)



WITH t1 AS (SELECT LEFT(primary_poc,     STRPOS(primary_poc, ' ') -1 ) first_name,  RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name,
            primary_poc,name
FROM accounts),

WITH t2 AS (
  SELECT LEFT(first_name,1) AS first_letter,
  RIGHT(first_name,1) AS last_letter,
  LEFT(last_name,1) AS lastname_letter,
  RIGHT(last_name,1) as lastnamelast_letter,
  LENGTH(first_name) first_name_length,
  LENGTH(last_name)last_name_length,
  name,
  primary_poc,
  LOWER(first_letter), LOWER(last_name)
  FROM accounts,t1
)

SELECT CONCAT(first_letter + last_letter)
FROM t1,t2

SELECT LEFT(first_name,1) AS first_letter,
RIGHT(first_name,1) AS last_letter,
LEFT(last_name,1) AS lastname_letter,
RIGHT(last_name,1) as lastnamelast_letter,
LENGTH(first_name) first_name_length,
LENGTH(last_name)last_name_length,
name,
primary_poc,
LOWER(first_letter), LOWER(last_name)
  
FROM t1
//pick up here

break them into first and last names
then take the 1st letter off the first name
last letter off the last
SELECT RIGHT(primary_poc,1) AS last_letter of last name

Cast

SELECT DATE_PART('month', TO_DATE(month, 'month')) AS clean_month, //converting 'January to 1' //
year || '-' || DATE_PART('month', TO_DATE(month,'month')) || day AS concatenated_date,
CAST(year || '-' || DATE_PART('month', TO_DATE(month,'month')) || '-' day AS date)

OR shorthand
(year || '-' || DATE_PART('month', TO_DATE(month,'month')) || '-' day)::date AS formatted_date
FROM 

Cast is very useful for turning strings into numbers or dates

dates are yyyy-mm-dd


SELECT * 
FROM sf_crime_data
LIMIT 10

SELECT substring('sql tutorial', 1, 3) AS exactstring
FROM accounts

returns SQL

put year first
then montht
then day 
as new_date

WITH t1 AS (SELECT date,SUBSTRING(date, 1,2) as month,
SUBSTRING(date, 4,2) as day,
SUBSTRING(date,7,4) as years
FROM sf_crime_data
LIMIT 10)
SELECT years,month,day,
years || '-' || month || '-' || day AS new_Date
FROM t1

SELECT date orig_date, (SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date, 4, 2)) new_date
FROM sf_crime_data;

SELECT date AS original_date

WITH t1 AS (SELECT date,SUBSTRING(date, 1,2) as month,
SUBSTRING(date, 4,2) as day,
SUBSTRING(date,7,4) as years,
            date
FROM sf_crime_data
LIMIT 10)
SELECT years,month,day,date
(years || '-' || month || '-' || day)::date AS new_Date
FROM t1

SUBSTRING(date,1,2) || '-' || SUBSTRING(date(4,2)

 

  SELECT COUNT(primary_poc) AS reg,
  COUNT(COALESCE(primary_poc, 'NO POC')) AS primary_poc_modified
  FROM accounts

  COALESCE - returns the first non null value in a list

 SELECT * 
  FROM accounts


SELECT date orig_date, (SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) || '-' || 
  SUBSTR(date, 4, 2))::DATE new_date
FROM sf_crime_data;

SELECT COALESCE(a.id, a.id) filled_id,a.id, a.name, a.website, a.lat, a.long, a.primary_poc  COALESCE(o.account_id, a.id) account_id, a.id, o.id,o.account_id o.occurred_at, o.standard_qty, o.gloss_qty, o.poster_qty, o.total, o.standard_amt_usd, o.gloss_amt_usd, o.poster_amt_usd, o.total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

SELECT COALESCE(a.id,a.id) modified_id, a.id, a.name, a.website,a.lat, a.long, a.primary_poc COALESCE(o.account_id, a.id) as modified, a.id, o.id, o.account_id, o.occurred_at, o.standard_qty
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

Case
SELECT id,name,department_name
FROM student s
JOIN department d
ON s.dept_id = cast(d.dept_id as smallint) // changing the dept id which is text to a small int so that it matches the dept_id

Hello, replace statement
SELECT upper(replace(dept_name, 'Information Technology', 'IT')) as dept_cleaned,
COUNT(dept_name) as student_count
FROM student_details
GROUP BY 1

Cleaning Data Notes
LEFT(string, number of characters)
Inner most functions will be evaluated first

TRIM function
takes 3 arguments, leading, trailing, ending
TRIM(both '()' FROM location)


WITH t1 AS (SELECT location, 
 LEFT(location, position (',' IN location) -1) as new_lat, 
 RIGHT(location, LENGTH(location) - position (',' IN location)) as new_long
 FROM tutorial.sf_crime_incidents_2014_01)
SELECT REPLACE(new_lat, '(', ''), REPLACE(new_long, ')', ''), location
FROM t1
 LIMIT 10
 
Trim is an effective way to cut '(', ')' Too
SELECT location,
TRIM(leading '(' FROM LEFT(location, POSITION(',' IN location) -1)) AS lattitude,
TRIM(trailing ')' FROM RIGHT (location, LENGTH(location) - POSITION(',' IN location))) AS long
  FROM tutorial.sf_crime_incidents_2014_01
 

SELECT SUBSTRING(date,1,2) || '-' || SUBSTRING(date,4,2) || '-' || SUBSTRING (date, 7,4) AS new_col
FROM tutorial.sf_crime_incidents_2014_01
LIMIT 4

SELECT UPPER(LEFT(category,1)) || LOWER(SUBSTRING(category,2,50)), category
FROM tutorial.sf_crime_incidents_2014_01
LIMIT 4


SELECT category, UPPER(LEFT(category,1)) || LOWER(RIGHT(category, LENGTH(category) - 1))
FROM tutorial.sf_crime_incidents_2014_01
LIMIT 4

Subqueries -
Inner query must run on its own, once the inner query runs, the outer query will run using resuls from the inner query as its table

SELECT LEFT(sub.date, 2) AS cleaned_month, //grabs the month
       sub.day_of_week, //grabs day of week from below table
       AVG(sub.incidents) AS average_incidents //average incidents from below table
  FROM (

SELECT day_of_week,
               date,
               COUNT(incidnt_num) AS incidents
          FROM tutorial.sf_crime_incidents_2014_01
         GROUP BY 1,2
         ) sub
         
         GROUP BY 1,2
         ORDER BY 1

         SELECT AVG(incidents) AS avg_incidents, LEFT(sub.date,2) AS month, COUNT(sub.category)
FROM 
     (SELECT category, COUNT(incidnt_num) AS incidents, date
     FROM tutorial.sf_crime_incidents_cleandate
     GROUP BY 1,3) sub
GROUP BY 2
ORDER BY month

SELECT AVG(sub.incidents), sub.category
FROM
(SELECT EXTRACT(month FROM cleaned_date) AS cleaned_month,category, COUNT(category) as incidents
FROM tutorial.sf_crime_incidents_cleandate
GROUP BY 1,2) sub
GROUP BY 2
ORDER BY 2

    
SELECT incidents.*, sub.count AS total_incidents
FROM tutorial.sf_crime_incidents_2014_01 AS incidents
JOIN
(SELECT category,COUNT(category)
FROM tutorial.sf_crime_incidents_2014_01
GROUP BY 1
ORDER BY 2
LIMIT 3) AS sub
ON incidents.category = sub.category
LIMIT 3


Window functions

SELECT standard_qty,
DATE_TRUNC('month', occured_at) AS month,
SUM(standard_qty) OVER (PARTITION BY DATE_TRUNC('month', occured_at) ORDER BY occurred_at) AS running_total
FROM orders

SELECT standard_qty, SUM(standard_qty) OVER (ORDER BY occurred_at) AS running_total

SELECT standard_amt_usd, 
DATE_TRUNC('year', occurred_at) AS clean_year,
SUM(standard_amt_usd) OVER (PARTITION BY DATE_TRUNC('year', occurred_at) ORDER BY occurred_at) AS running_total
FROM orders

SELECT id, account_id,
occured_at,
ROW_NUMBER() OVER(PARTITION BY account_id ORDER BY occurred_at) AS row_num

// row gives different n

DATE_TRUNC('month', occurred_at) as month,
RANK() OVER (PARTITION BY DATE_TRUNC('month', occurred_at) ORDER BY occurred_at) AS row_num

dense rank accounts for all rows

SELECT id, account_id, total,
RANK() OVER (PARTITION BY account_id ORDER BY total DESC) AS total_rank
FROM orders 
// ranking account id with most orders (total)

The order by clause is one of 2 clauses integral to window functions. The order and partition refer to what is defined as 'the window' - the ordered subset of data the calculations are made. Removing order by just leaves an unordered partition.

Leaving the order by out is equivalent to  'ordering' in a way that all rows in the partition are 'equal' to each other. You can get the same effect by adding the order by clause like this: 'order by 0' or 'order by null'

SELECT id, account_id, standard_qty
SUM(standard_qty) OVER main_window AS standard_qty,
MIN(standard_qty) OVER main_window AS min_quantity
FROM orders
WINDOW main_window AS (PARTITION BY account_id ORDER BY DATE_TRUNC('month', occurred_at))


SELECT id,
       account_id,
       DATE_TRUNC('year',occurred_at) AS year,
       DENSE_RANK() OVER main_window AS dense_rank,
       total_amt_usd,
       SUM(total_amt_usd) OVER main_window AS sum_total_amt_usd,
       COUNT(total_amt_usd) OVER main_window AS count_total_amt_usd,
       AVG(total_amt_usd) OVER main_window AS avg_total_amt_usd,
       MIN(total_amt_usd) OVER main_window AS min_total_amt_usd,
       MAX(total_amt_usd) OVER main_window AS max_total_amt_usd
FROM orders
WINDOW main_window AS (PARTITION BY account_id ORDER BY DATE_TRUNC ('year', occurred_at)) 

WINDOW window_name
/ replace partition by with window_name everywhere

SELECT account_id, standard_sum,
LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag
LEAD(standard_sum) OVER (ORDER BY standard_sum) AS lead 
standard_sum - LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag_difference
LEAD(standard_sum) OVER (ORDER BY standard_sum) AS lead_difference
FROM (
SELECT account_id,
SUM(standard_qty) AS standard_num
FROM orders
ORDER BY 1
)sub

// lag starts at null because there are no previous rows to pull. pull sfrom the column before
// lag is pulling the previous row from standard_sum

LAG 

SELECT account_id,
standard_sum,
LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag
standard_sum - LAG(standard_sum) OVER (ORDER BY standard_sum) as lag_diff

// lag difference is pulling the difference between standard sum & lag
so if the standard_sum is 0 and the lag is 79 the lag_diff is 79

LEAD
// lead return the value from the following row

LEAD(standard_sum) OVER (ORDER BY standard_sum) AS lead
if the standard sum is 0 in the first row but 79 in the second row than the lead is 79, if the second row is 79 and the third row is 102 the lead is 102
LEAD(standard_sum) OVER (ORDER BY standard_sum) - standard_sum AS lead_diff

if the standard sum is 0 in the first row but 79 in the second row than the lead is 79, if the second row is 79 and the third row is 102 the lead is 102

if the started sum is 0 in the first row but 79 in the second row the LEAD and LEAD DIFF are 79, if the second row is 102 the lead difference is 23 because 102-79

Lag and lead are ideal for comparing adjacents rows or rows that are offset by a certain number


SELECT occurred_at,
       total_sales_usd,
       LEAD(totalsales_sum) OVER (ORDER BY totalsales_sum) AS lead,
       LEAD(totalsales_sum) OVER (ORDER BY totalsales_sum) - totalsales_sum AS lead_difference
FROM (
SELECT occurred_at,
       SUM(total_sales_usd) AS totalsales_sum
  FROM orders 
 GROUP BY 1
 ) sub


SELECT id, account_id, occurred_at, standard_qty
NTILE(5) OVER (ORDER BY standard_qty)
FROM orders
ORDER BY standard_qty DESC

SELECT account_id, occurred_at, standard_qty
NTILE(4) OVER (ORDER BY standard_qty) AS standard_quartile
FROM orders
ORDER BY standard_qty DESC


1)
SELECT account_id, occurred_at, standard_qty,
NTILE(4) OVER (ORDER BY standard_qty) AS standard_quartile
FROM orders
ORDER BY standard_qty DESC

SELECT account_id,
occurred_at,
standard_qty,
NTILE(4) OVER (PARTITION BY account_id ORDER BY standard_qty) AS standard_quartile
FROM orders


2)SELECT account_id, occurred_at,gloss_amt_usd
  SUM(gloss_amt_usd), 
  NTILE(2) OVER PARTIT(ORDER BY gloss_amt_usd) AS gloss_half
FROM orders
GROUP BY 1,2,3

SELECT account_id, 
occurred_at, 
gloss_qty,
NTILE(2) OVER (PARTITION BY account_id ORDER BY gloss_qty) AS gloss_percentile
FROM orders
ORDER BY 1 desc

3)
SELECT total_amt_usd, account_id, occurred_at,
SUM(total_amt_usd),
NTILE(100) OVER (ORDER BY total_amt_usd) AS total_percentile
FROM orders

SELECT total_amt_usd, account_id, occurred_at,
SUM(total_amt_usd),
NTILE(100) OVER (PARTITION BY account_id ORDER BY total_amt_usd) AS total_percentile
FROM orders



SELECT account_id, standard_sum,
LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag
LEAD(standard_sum) OVER (ORDER BY standard_sum) AS lead 
standard_sum - LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag_difference
LEAD(standard_sum) OVER (ORDER BY standard_sum) AS lead_difference
FROM (
SELECT account_id,
SUM(standard_qty) AS standard_num
FROM orders
ORDER BY 1
)sub

SELECT COUNT(*), name,
CASE WHEN LEFT(name,1) LIKE '[A-Z]%' THEN 'letter' ELSE 'number' END as letter_or_number
FROM accounts
GROUP BY 2

SELECT COUNT(*) FROM stg_trans;
SELECT COUNT(*) FROM DTM_FACT_TRANS;
SELECT COUNT(*) FROM stg_trans;
TRUNCATE TABLE DTM_FACT_TRANS;
--select * from stg_trans;
SELECT * FROM DTM_FACT_TRANS ORDER BY tran_id;

SELECT COUNT(DISTINCT store_id) FROM DTM_FACT_TRANS;
SELECT SUM(total), sum(revenue),EXTRACT(YEAR FROM created_date) FROM dtm_fact_trans GROUP BY EXTRACT(YEAR FROM created_date);

SELECT order_channel, SUM(use_coupon) FROM dtm_fact_trans GROUP BY order_channel;

SELECT EXTRACT(YEAR FROM created_date), EXTRACT(MONTH FROM created_date), COUNT(DISTINCT cu_id)
FROM dtm_fact_trans GROUP BY EXTRACT(MONTH FROM created_date), EXTRACT(YEAR FROM created_date)
ORDER BY 2, 1;

SELECT SUM(coupon_amount), SUM(revenue), SUM(coupon_amount) + SUM(revenue) AS sum_tot, SUM(sales) FROM dtm_fact_trans;

SELECT EXTRACT(YEAR FROM created_date), EXTRACT(MONTH FROM created_date), AVG(qty)
FROM dtm_fact_trans GROUP BY EXTRACT(MONTH FROM created_date), EXTRACT(YEAR FROM created_date)
ORDER BY 1, 2;

SELECT order_channel, ROUND(AVG(delivery_fee)), SUM(delivery_fee) FROM dtm_fact_trans GROUP BY order_channel;

SELECT AVG(price), SUM(price) FROM dtm_order;
select COUNT(*) from stg_order;
SELECT price FROM dtm_order;

SELECT SUM(use_coupon) FROM dtm_fact_trans;

SELECT EXTRACT(YEAR FROM created_date) AS year, EXTRACT(MONTH FROM created_date) AS month, ROUND(AVG(qty))
FROM dtm_fact_trans
GROUP BY EXTRACT(YEAR FROM created_date), EXTRACT(MONTH FROM created_date)
ORDER BY 1, 2;

SELECT EXTRACT(YEAR FROM created_date) AS year, EXTRACT(MONTH FROM created_date) AS month, SUM(qty)
FROM dtm_fact_trans
GROUP BY EXTRACT(YEAR FROM created_date), EXTRACT(MONTH FROM created_date)
ORDER BY 1, 2;

SELECT store_id, SUM(qty)
FROM dtm_fact_trans
GROUP BY store_id
ORDER BY 1;

-- Average daily quantity of a store
WITH cte AS (
    SELECT 
        store_id, 
        EXTRACT(YEAR FROM created_date),
        EXTRACT(MONTH FROM created_date),
        TRUNC(created_date) AS cdate, 
        AVG(qty) AS avg_daily 
    FROM dtm_fact_trans
    GROUP BY store_id, EXTRACT(YEAR FROM created_date), EXTRACT(MONTH FROM created_date), TRUNC(created_date)
    ORDER BY 1, 2, 3, 4
)
SELECT store_id, SUM(avg_daily)
FROM cte
GROUP BY store_id
ORDER BY store_id;
--


-- Average daily sale of a year
WITH cte AS (
    SELECT 
        EXTRACT(YEAR FROM created_date) AS fy,
        EXTRACT(MONTH FROM created_date),
        TRUNC(created_date), 
        SUM(sales) AS cnt_tran_daily 
    FROM dtm_fact_trans
    GROUP BY EXTRACT(YEAR FROM created_date), EXTRACT(MONTH FROM created_date), TRUNC(created_date)
    ORDER BY 1, 2, 3, 4
)
SELECT fy, AVG(cnt_tran_daily) AS ads
FROM cte
GROUP BY fy
ORDER BY fy;

-- main ADS
WITH cte AS (
    SELECT 
        TRUNC(created_date, 'DD') AS dy, 
        SUM(sales) AS sales_daily,
        SUM(revenue) AS revenue_daily
    FROM dtm_fact_trans
    GROUP BY TRUNC(created_date, 'DD')
    ORDER BY 1
)
SELECT EXTRACT(YEAR FROM dy), ROUND(SUM(sales_daily) / COUNT(DISTINCT dy), 1)  AS sds, ROUND(AVG(sales_daily), 1) AS ads, MIN(sales_daily), MAX(sales_daily)
FROM cte
GROUP BY EXTRACT(YEAR FROM dy)
ORDER BY 1;
-- 69,195,128,219.2
--116,275,203,726
--180,369,093,315.1
--204,862,856,000

SELECT EXTRACT(YEAR FROM created_date), SUM(sales) / COUNT(DISTINCT created_date) 
FROM dtm_fact_trans
GROUP BY EXTRACT(YEAR FROM created_date)
ORDER BY 1;

WITH cte AS (
    SELECT 
        TRUNC(created_date, 'DD') AS dy, 
        SUM(sales) AS sales_daily
    FROM dtm_fact_trans
    GROUP BY TRUNC(created_date, 'DD')
    ORDER BY 1
)
--SELECT TRUNC(dy, 'MM'), ROUND(SUM(sales_daily)) AS ads
SELECT EXTRACT(YEAR FROM dy), EXTRACT(MONTH FROM dy), ROUND(AVG(sales_daily)) AS ads
FROM cte
GROUP BY EXTRACT(YEAR FROM dy), EXTRACT(MONTH FROM dy)
ORDER BY 1;
--35,842,326,774.2
--35,842,326,774
--1,111,112,130,000
--
--

-- main ADTC
WITH cte AS (
    SELECT 
        TRUNC(created_date, 'DD') AS dy, 
        COUNT(tran_id) AS cnt_tran_daily 
    FROM dtm_fact_trans
    GROUP BY TRUNC(created_date, 'DD')
    ORDER BY 1
)
SELECT EXTRACT(YEAR FROM dy), AVG(cnt_tran_daily) AS ads, MAX(cnt_tran_daily), MIN(cnt_tran_daily)
FROM cte
GROUP BY EXTRACT(YEAR FROM dy)
ORDER BY 1;


SELECT tran_id, TRUNC(created_date, 'DD') FROM dtm_fact_trans;
SELECT COUNT(tran_id) FROM dtm_fact_trans WHERE TRUNC(created_date, 'DD') = '01-JAN-17';
SELECT * FROM dtm_fact_trans WHERE EXTRACT(DATE FROM created_date) = '01-JAN-17';
--
-- average daily qty of a store
WITH cte AS (
    SELECT 
        store_id,
        TRUNC(created_date, 'DD') AS dy, 
        SUM(qty) AS qty_daily 
    FROM dtm_fact_trans
    GROUP BY store_id, TRUNC(created_date, 'DD')
    ORDER BY 1, 2
)
SELECT store_id, ROUND(AVG(qty_daily)) AS adq, MAX(qty_daily), MIN(qty_daily)
--SELECT COUNT(*) 
FROM cte
GROUP BY store_id
ORDER BY 1;

SELECT count(distinct store_id) FROM stg_store;
---
SELECT * FROM dtm_fact_trans;
SELECT EXTRACT(YEAR FROM created_date), SUM(sales), SUM(revenue), SUM(sales)-SUM(revenue) AS diff
FROM dtm_fact_trans
GROUP BY EXTRACT(YEAR FROM created_date)
ORDER BY 1;

-- Average daily sale of a year
WITH cte AS (
    SELECT 
        EXTRACT(YEAR FROM created_date) AS fy,
        EXTRACT(MONTH FROM created_date),
        TRUNC(created_date), 
        COUNT(tran_id) AS cnt_tran_daily 
    FROM dtm_fact_trans
    GROUP BY EXTRACT(YEAR FROM created_date), EXTRACT(MONTH FROM created_date), TRUNC(created_date)
    ORDER BY 1, 2, 3, 4
)
SELECT fy, AVG(cnt_tran_daily) AS ads
FROM cte
GROUP BY fy
ORDER BY fy;

SELECT EXTRACT(YEAR FROM created_date) AS fy, SUM(sales) / 365
FROM dtm_fact_trans
GROUP BY EXTRACT(YEAR FROM created_date) 
ORDER BY fy;
--

--
CREATE TABLE YOY (
    sdate date,
    volume_ty number(15),
    revenue_ty number(15),
    volume_LY number(15),
    revenue_LY number(15)
);
--
SELECT TRUNC(created_date, 'MM') AS SalesDate, COUNT(tran_id) AS Volume, SUM(revenue) AS Revenue
FROM dtm_fact_trans
GROUP BY TRUNC(created_date, 'MM');

SELECT TRUNC(created_date, 'MM') AS SalesDate, COUNT(tran_id) AS VolumeLY, SUM(revenue) as RevenueLY
From dtm_fact_trans
GROUP BY TRUNC(created_date, 'MM');

WITH this_year AS (
    SELECT TRUNC(created_date, 'MM') AS sdate, COUNT(tran_id) AS Volume, SUM(revenue) AS Revenue
    FROM dtm_fact_trans
    GROUP BY TRUNC(created_date, 'MM')
),
last_year AS (
    SELECT TRUNC(created_date, 'MM') AS sdate, COUNT(tran_id) AS VolumeLY, SUM(revenue) as RevenueLY
    From dtm_fact_trans
    GROUP BY TRUNC(created_date, 'MM')
)
SELECT this_year.sdate, this_year.Volume, last_year.VolumeLY, this_year.Revenue, last_year.RevenueLY
FROM this_year 
INNER JOIN last_year
ON this_year.sdate = ADD_MONTHS(last_year.sdate, 12);

TRUNCATE TABLE YOY;
INSERT INTO YOY
SELECT this_year.sdate, this_year.Volume, this_year.Revenue, last_year.VolumeLY, last_year.RevenueLY
FROM (
    SELECT TRUNC(created_date, 'MM') AS sdate, COUNT(tran_id) AS Volume, SUM(revenue) AS Revenue
    FROM dtm_fact_trans
    GROUP BY TRUNC(created_date, 'MM')
) this_year
INNER JOIN (
    SELECT TRUNC(created_date, 'MM') AS sdate, COUNT(tran_id) AS VolumeLY, SUM(revenue) as RevenueLY
    From dtm_fact_trans
    GROUP BY TRUNC(created_date, 'MM')
) last_year
ON this_year.sdate = ADD_MONTHS(last_year.sdate, 12);

SELECT * FROM YOY;
SELECT EXTRACT(YEAR FROM sdate), SUM(volume_ty), SUM(revenue_ty), SUM(volume_ly), SUM(revenue_ly)
FROM YOY
GROUP BY EXTRACT(YEAR FROM sdate)
ORDER BY 1;

INSERT INTO YOY --(SalesDate, Volume, Revenue, VolumeLY, RevenueLY) 
SELECT sr.sale_date, sr.Volume, sr.Revenue, srly.VolumeLY, srly.RevenueLY
FROM(SELECT TRUNC(created_date, 'MM') as sale_date,
        COUNT(tran_id) as Volume,
        SUM(revenue) as Revenue
    FROM dtm_fact_trans
    GROUP BY TRUNC(created_date, 'MM')
) sr
INNER JOIN (
  SELECT 
    TRUNC(created_date, 'MM') as sale_date,
    COUNT(tran_id) as VolumeLY,
    SUM(revenue) as RevenueLY
  FROM dtm_fact_trans
  GROUP BY TRUNC(created_date, 'MM')
) srly
ON sr.sale_date = ADD_MONTHS(srly.sale_date, 12);
--

SELECT EXTRACT(YEAR FROM created_date), SUM(revenue)
FROM dtm_fact_trans
GROUP BY EXTRACT(YEAR FROM created_date)
ORDER BY 1;
--25,237,743,220,000


--

WITH deli AS (
    SELECT de.tran_id AS tran_id, sh.shipper_id AS shipper_id, sh.fullname AS shipper_name, ch.channel_name AS channel, ch.fee_value, ch.fee_unit
    FROM stg_delivery de 
    JOIN stg_shipper sh ON de.shipper_id = sh.shipper_id
    JOIN stg_channel ch ON sh.chan_id = ch.chan_id
), ord AS (
    SELECT tran_id AS tran_id, SUM(qty) AS qty, SUM(subtotal) AS total
    FROM stg_order GROUP BY tran_id
), dtm AS (
    SELECT tr.tran_id, tr.cu_id, tr.store_id, tr.created_date, ord.qty, ord.total, deli.shipper_name, deli.channel, deli.fee_unit, deli.fee_value,
        CASE 
          WHEN deli.fee_unit = 'Curency' THEN deli.fee_value
          WHEN deli.fee_unit = 'Percentage' THEN deli.fee_value * ord.total / 100
          WHEN deli.fee_unit = 'Auto' AND deli.fee_value > 100 THEN deli.fee_value
          WHEN deli.fee_unit = 'Auto' AND deli.fee_value < 1 THEN deli.fee_value * ord.total
          ELSE deli.fee_value * ord.total / 100
        END AS deli_amount
    FROM stg_trans tr
    JOIN ord ON tr.tran_id = ord.tran_id
    JOIN deli ON tr.tran_id = deli.tran_id
    JOIN stg_coupon cou ON tr.tran_id = cou.tran_id
)
SELECT COUNT(*) FROM dtm;


WITH deli AS (
    SELECT de.tran_id AS tran_id, sh.shipper_id AS shipper_id, sh.fullname AS shipper_name, ch.channel_name AS channel, ch.fee_value, ch.fee_unit
    FROM stg_delivery de 
    JOIN stg_shipper sh ON de.shipper_id = sh.shipper_id
    JOIN stg_channel ch ON sh.chan_id = ch.chan_id
), ord AS (
    SELECT tran_id AS tran_id, SUM(qty) AS qty, SUM(subtotal) AS total
    FROM stg_order GROUP BY tran_id
), dtm AS (
    SELECT tr.tran_id, tr.cu_id, tr.store_id, tr.created_date, ord.qty, ord.total, deli.shipper_name, deli.channel, deli.fee_unit AS fee_unit, deli.fee_value,
        CASE 
          WHEN deli.fee_unit = 'Curency' THEN deli.fee_value
          WHEN deli.fee_unit = 'Percentage' THEN deli.fee_value * ord.total / 100
          WHEN deli.fee_unit = 'Auto' AND deli.fee_value > 100 THEN deli.fee_value
          WHEN deli.fee_unit = 'Auto' AND deli.fee_value < 1 THEN deli.fee_value * ord.total
          ELSE deli.fee_value * ord.total / 100
        END AS deli_amount,
        cou.coupon_type, cou.coupon_value,
        CASE 
          WHEN cou.COUPON_TYPE = 'Currency' THEN cou.COUPON_VALUE 
          WHEN cou.COUPON_TYPE = 'Percentage' THEN  ord.total * cou.COUPON_VALUE / 100
          WHEN cou.COUPON_TYPE = 'Auto' AND cou.COUPON_VALUE > 100 THEN cou.COUPON_VALUE 
          WHEN cou.COUPON_TYPE = 'Auto' AND cou.COUPON_VALUE < 1 THEN ord.total * cou.COUPON_VALUE
          ELSE ord.total * cou.COUPON_VALUE / 100
        END AS coupon_amount
    FROM stg_trans tr
    JOIN ord ON tr.tran_id = ord.tran_id
    JOIN deli ON tr.tran_id = deli.tran_id
    JOIN stg_coupon cou ON tr.tran_id = cou.tran_id
)
SELECT AVG(deli_amount), channel FROM dtm GROUP BY channel;



---
-- AVG delivery fee by channel
SELECT order_channel, ROUND(AVG(delivery_fee))
FROM dtm_fact_trans
WHERE order_channel IS NOT NULL
GROUP BY order_channel;

--
-- Store's daily volume/revenue/sales quantity
WITH cte AS (
    SELECT store_id, TRUNC(created_date, 'DD'), COUNT(tran_id) AS volume, SUM(revenue) AS revenue, SUM(qty) AS qty
    FROM dtm_fact_trans
    GROUP BY store_id, TRUNC(created_date, 'DD')
    ORDER BY 1, 2
)
SELECT store_id, ROUND(AVG(volume), 1), ROUND(AVG(revenue), 1), ROUND(AVG(qty), 1)
FROM cte
GROUP BY store_id;
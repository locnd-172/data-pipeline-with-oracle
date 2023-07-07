--DROP TABLE STG_CATEGORY;
CREATE TABLE STG_CATEGORY(
  cate_id number primary key,
  cate_name nvarchar2(30),
  description nvarchar2(255)
);
SELECT * FROM STG_CATEGORY;
----------

--DROP TABLE STG_CHANNEL;
TRUNCATE TABLE stg_channel;
CREATE TABLE STG_CHANNEL (
  chan_id number primary key,
  channel_name nvarchar2(50),
  fee_value number(12,3),
  fee_unit varchar2(10)
);
SELECT * FROM STG_CHANNEL;
----------
--DROP TABLE STG_COUPON;
TRUNCATE TABLE STG_COUPON;
CREATE TABLE STG_COUPON (
  tran_id number,
  coupon_id number,
  description nvarchar2(255),
  qr_code varchar(20),
  bill_min_amount number,
  max_discount number,
  coupon_type varchar2(10),
  coupon_value number(12,1)
);
SELECT COUNT(*) FROM STG_COUPON;
----------
DROP TABLE STG_CUSTOMER;
TRUNCATE TABLE STG_CUSTOMER;
SELECT COUNT(*) FROM STG_CUSTOMER;
CREATE TABLE STG_CUSTOMER (
  cu_id number primary key,
  fullname nvarchar2(50),
  email varchar(50),
  phone varchar(20),
  address nvarchar2(500),
  gender varchar2(6), 
  dob date,
  created_date date
);

SELECT * FROM STG_CUSTOMER;
----------
DROP TABLE STG_DELIVERY;

TRUNCATE TABLE stg_delivery;
CREATE TABLE STG_DELIVERY (
  tran_id number,
  shipper_id number,
  address nvarchar2(500),
  phone varchar(20)
);
SELECT COUNT(*) FROM stg_delivery;
----------
DROP TABLE STG_ORDER;
SELECT COUNT(*) FROM stg_order;
TRUNCATE TABLE stg_order;
CREATE TABLE STG_ORDER (
  tran_id number,
  item number,
  prod_id number,
  qty number,
  price number,
  subtotal number
);
----------
DROP TABLE STG_PRODUCT;

CREATE TABLE STG_PRODUCT (
  prod_id number primary key,
  name nvarchar2(50),
  model nvarchar2(500),
  processor nvarchar2(500),
  ram_hdd nvarchar2(200),
  vga nvarchar2(200),
  display nvarchar2(200),
  optical_drive nvarchar2(200),
  fax_nic_wl nvarchar2(500),
  weight_battery nvarchar2(200),
  cate_id number,
  price number
);
SELECT COUNT(*) FROM STG_PRODUCT;
----------
DROP TABLE STG_SHIPPER;
SELECT * FROM stg_shipper;
TRUNCATE TABLE stg_shipper;
CREATE TABLE STG_SHIPPER (
  chan_id number,
  shipper_id number primary key,
  fullname nvarchar2(50),
  phone varchar(20)
)
----------
DROP TABLE STG_STORE;
SELECT * FROM STG_STORE;
CREATE TABLE STG_STORE (
  store_id number primary key,
  address nvarchar2(500),
  opened_date timestamp,
  closed_date timestamp,
  status varchar2(10)
);
----------
DROP TABLE STG_TRANS;
TRUNCATE TABLE STG_TRANS;
CREATE TABLE STG_TRANS (
  tran_id number primary key,
  cu_id number,
  store_id number,
  created_date timestamp,
--  status nvarchar2(20),
  order_channel_id number,
  loaded_date date
);
SELECT COUNT(*) FROM STG_TRANS;
SELECT * FROM STG_TRANS;
SELECT * FROM STG_TRANS WHERE ROWNUM <= 100 ORDER BY tran_id DESC;
----------

DROP TABLE FACT_TRANS;
TRUNCATE TABLE FACT_TRANS;
CREATE TABLE FACT_TRANS (
    tran_id number,
    cu_id number,
    store_id number,
    order_channel_id number,
    created_date timestamp,
    qty number,
    total number,
    loaded_date date
);

SELECT COUNT(*) FROM FACT_TRANS;
SELECT * FROM FACT_TRANS WHERE ROWNUM <= 20 ORDER BY tran_id;

SELECT * FROM stg_channel;

SELECT * FROM stg_order WHERE tran_id = 3390855;
----------

SELECT COUNT(*) FROM stg_category;
SELECT COUNT(*) FROM stg_channel;
SELECT COUNT(*) FROM stg_coupon;
SELECT COUNT(*) FROM stg_customer;
SELECT COUNT(*) FROM stg_delivery;
SELECT COUNT(*) FROM stg_order;
SELECT COUNT(*) FROM stg_product;
SELECT COUNT(*) FROM stg_shipper;
SELECT COUNT(*) FROM stg_store;
SELECT COUNT(*) FROM stg_trans;

SELECT sum(total) FROM fact_trans GROUP BY store_id ORDER BY 1;
SELECT DISTINCT store_id FROM fact_trans;


SELECT COUNT(DISTINCT tran_id) FROM fact_trans GROUP BY store_id;

SELECT SUM(total) / 12 FROM fact_trans;

SELECT * FROM fact_trans;

----------

DROP TABLE DTM_FACT_TRANS;
TRUNCATE TABLE DTM_FACT_TRANS;
CREATE TABLE DTM_FACT_TRANS (
    tran_id number,
    cu_id number,
    fullname nvarchar2(50),
    gender varchar2(6), 
    dob date,
    store_id number,
    created_date timestamp,
    qty number,
    sales number,
    order_channel nvarchar2(50),
    shipper nvarchar2(100),
    delivery_fee number(12, 3),
    use_coupon number,
    coupon_id number,
    coupon_amount number(12, 3),
    revenue number(12, 3)
);

DROP TABLE dtm_order;
CREATE TABLE dtm_order (
    tran_id number,
    prod_id number,
    prod_name nvarchar2(50),
    cate_name nvarchar2(50),
    qty number,
    price number,
    subtotal number
);
SELECT COUNT(*) FROM dtm_order;
select * from dtm_order;
SELECT COUNT(*) FROM stg_order;
SELECT * FROM stg_order WHERE prod_id = 1;
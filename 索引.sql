--索引

CREATE TABLE customers(
customer_id NUMBER(8,0) NOT NULL,
join_date DATE NOT NULL,
customer_status VARCHAR2(8) NOT NULL,
customer_name VARCHAR2(20) NOT NULL,
creditrating VARCHAR2(10)
);

CREATE TABLE orders(
order_id NUMBER(8),
order_date DATE,
order_status VARCHAR2(8),
order_amount NUMBER(8,2),
customer_id NUMBER(8)
);

CREATE TABLE order_items(
order_item_id NUMBER(8),
order_id NUMBER(8),
product_id NUMBER(8)
);

CREATE TABLE products(
product_id NUMBER(8),
product_description VARCHAR2(20),
product_status VARCHAR2(8),
price NUMBER(10,2),
price_date DATE,
stock_count NUMBER(8)

);


--创建复合B*树索引
CREATE INDEX cust_name_i ON customers(customer_name, customer_status);

--低级数列上建立位图索引
CREATE BITMAP INDEX creditrating_i ON customers(creditrating);


--查询表的特性
SELECT index_name, column_name, index_type, uniqueness FROM user_indexes 
       NATURAL JOIN User_Ind_Columns 
       WHERE table_name='CUSTOMERS';







--insert
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;

SELECT prod_seq.nextval FROM dual;
INSERT INTO products VALUES(prod_seq.nextval, '12c sql', 'ACTIVE', 60, SYSDATE, 20);
INSERT INTO products VALUES(prod_seq.nextval, '12c sql all', 'ACTIVE', 100, SYSDATE, 40);

SELECT * FROM customers; 

INSERT INTO customers(customer_id,join_date, customer_status, customer_name, creditrating)
VALUES(cust_seq.nextval, SYSDATE, 'ACTIVE', '张三'， 'A');
INSERT INTO customers(customer_id,join_date, customer_status, customer_name, creditrating)
VALUES(cust_seq.nextval, SYSDATE, 'ACTIVE', '李四'， 'B');

INSERT INTO orders(order_id, order_date, order_status, order_amount, customer_id) 
VALUES(order_seq.nextval, SYSDATE, 'COMPLETE', 3, 3);

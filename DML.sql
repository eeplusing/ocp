/*
一．什么是事务  
事务是应用程序中一系列严密的操作，所有操作必须成功完成，否则在每个操作中所作的所有更改都会被撤消。也就是事务具有原子性，
一个事务中的一系列的操作要么全部成功，要么一个都不做。  
事务的结束有两种，当事务中的所以步骤全部成功执行时，事务提交。
如果其中一个步骤失败，将发生回滚操作，撤消撤消之前到事务开始时的所以操作。  
二．事务的 ACID  
事务具有四个特征：原子性（ Atomicity ）、一致性（ Consistency ）、隔离性（ Isolation ）和持续性（ Durability ）。
这四个特性简称为 ACID 特性。  
1 、原子性  
事务是数据库的逻辑工作单位，事务中所有部分必须都完成或都不完成  
2 、一致性  
事务执行的结果必须是使数据库从一个一致性状态变到另一个一致性状态。因此当数据库只包含成功事务提交的结果时，
就说数据库处于一致性状态。
如果数据库系统运行中发生故障，有些事务尚未完成就被迫中断，这些未完成事务对数据库所做的修改有一部分已写入物理数据库，
这时数据库就处于一种不正确的状态，或者说是不一致的状态。  
3 、隔离性  
一个事务的执行不能干扰其它事务。即一个事务内部的操作及使用的数据仅对执行该事务的会话有效，
对其它并发事务的会话是隔离的，并发执行的各个事务之间不能互相干扰。  
4 、持续性  
也称永久性，指一个事务一旦提交，它对数据库中的数据的改变就应该是永久性的。接下来的其它操作或故障不应该对其执行结果有任何影响。  
数据库系统必须维护事务的以下特性 ( 简称 ACID) ：  
*/

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

--delete
DELETE FROM products t WHERE t.product_id='3';

DELETE FROM products;

--insert update delete可回滚；truncate drop为ddl不可回滚

--truncate ddl
--截断表
TRUNCATE TABLE tablename;
--删除数据及表结构
DROP TABLE tablename;






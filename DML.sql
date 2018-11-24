/*
һ��ʲô������  
������Ӧ�ó�����һϵ�����ܵĲ��������в�������ɹ���ɣ�������ÿ�����������������и��Ķ��ᱻ������Ҳ�����������ԭ���ԣ�
һ�������е�һϵ�еĲ���Ҫôȫ���ɹ���Ҫôһ����������  
����Ľ��������֣��������е����Բ���ȫ���ɹ�ִ��ʱ�������ύ��
�������һ������ʧ�ܣ��������ع���������������֮ǰ������ʼʱ�����Բ�����  
��������� ACID  
��������ĸ�������ԭ���ԣ� Atomicity ����һ���ԣ� Consistency ���������ԣ� Isolation ���ͳ����ԣ� Durability ����
���ĸ����Լ��Ϊ ACID ���ԡ�  
1 ��ԭ����  
���������ݿ���߼�������λ�����������в��ֱ��붼��ɻ򶼲����  
2 ��һ����  
����ִ�еĽ��������ʹ���ݿ��һ��һ����״̬�䵽��һ��һ����״̬����˵����ݿ�ֻ�����ɹ������ύ�Ľ��ʱ��
��˵���ݿ⴦��һ����״̬��
������ݿ�ϵͳ�����з������ϣ���Щ������δ��ɾͱ����жϣ���Щδ�����������ݿ��������޸���һ������д���������ݿ⣬
��ʱ���ݿ�ʹ���һ�ֲ���ȷ��״̬������˵�ǲ�һ�µ�״̬��  
3 ��������  
һ�������ִ�в��ܸ����������񡣼�һ�������ڲ��Ĳ�����ʹ�õ����ݽ���ִ�и�����ĻỰ��Ч��
��������������ĻỰ�Ǹ���ģ�����ִ�еĸ�������֮�䲻�ܻ�����š�  
4 ��������  
Ҳ�������ԣ�ָһ������һ���ύ���������ݿ��е����ݵĸı��Ӧ���������Եġ���������������������ϲ�Ӧ�ö���ִ�н�����κ�Ӱ�졣  
���ݿ�ϵͳ����ά��������������� ( ��� ACID) ��  
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
VALUES(cust_seq.nextval, SYSDATE, 'ACTIVE', '����'�� 'A');
INSERT INTO customers(customer_id,join_date, customer_status, customer_name, creditrating)
VALUES(cust_seq.nextval, SYSDATE, 'ACTIVE', '����'�� 'B');

INSERT INTO orders(order_id, order_date, order_status, order_amount, customer_id) 
VALUES(order_seq.nextval, SYSDATE, 'COMPLETE', 3, 3);

--delete
DELETE FROM products t WHERE t.product_id='3';

DELETE FROM products;

--insert update delete�ɻع���truncate dropΪddl���ɻع�

--truncate ddl
--�ضϱ�
TRUNCATE TABLE tablename;
--ɾ�����ݼ���ṹ
DROP TABLE tablename;

--���ձ�������ο���ṹ������
CREATE TABLE empl AS SELECT * FROM employees WHERE 1=2;
--����ѯ����������
INSERT INTO empl (employee_id,last_name,email,hire_date,job_id,salary)
(SELECT employee_id,last_name,email,hire_date,job_id,salary FROM employees);
SELECT * FROM empl;
DROP TABLE empl;

--MERGE����DML��ʾ
--�������б�����copy����
CREATE TABLE new_empl AS SELECT * FROM employees;
CREATE TABLE new_empl2 AS SELECT * FROM employees;

SELECT COUNT(*) FROM new_empl;
SELECT COUNT(*) FROM new_empl2; 

UPDATE new_empl2 n SET n.salary=10 WHERE n.employee_id=100; 

DELETE FROM new_empl WHERE employee_id > 200;

MERGE INTO new_empl e USING new_empl2 n 
ON(e.employee_id=n.employee_id)
WHEN MATCHED THEN
  UPDATE SET e.salary=n.salary
WHEN NOT MATCHED THEN
  INSERT(employee_id,last_name,salary,email,hire_date,job_id)
  VALUES(n.employee_id,n.last_name,n.salary,n.email,n.hire_date,n.job_id); 

SELECT * FROM new_empl;
SELECT * FROM new_empl2;
DROP TABLE new_empl;
DROP TABLE new_empl2;


--��������Ծ���
--�Ự1
CREATE TABLE t1 AS SELECT * FROM all_users;
SELECT COUNT(*) FROM t1;
--�Ự2
SELECT COUNT(*) FROM t1;

--�Ự1
DELETE FROM t1;
SELECT COUNT(*) FROM t1;
--�Ự2
SELECT COUNT(*) FROM t1;

--�Ự1
ROLLBACK;
SELECT COUNT(*) FROM t1;
--�Ự2
SELECT COUNT(*) FROM t1;

--�Ự1
DELETE FROM t1;
SELECT COUNT(*) FROM t1;
--�Ự2
SELECT COUNT(*) FROM t1;

--�Ự1
CREATE VIEW v1 AS SELECT * FROM t1;--ddl����ִ�������commit
SELECT COUNT(*) FROM t1;
--�Ự2
SELECT COUNT(*) FROM t1;

--�Ự1
ROLLBACK;
SELECT COUNT(*) FROM t1;
--�Ự2
SELECT COUNT(*) FROM t1;

DROP TABLE t1;
DROP VIEW v1;







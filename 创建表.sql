--创建表
CREATE TABLE EMPS(
EMPNO NUMBER,
ENAME VARCHAR2(25),
SALARY NUMBER,
DEPTNO NUMBER(4, 0)
);

--将查询结果插入表
INSERT INTO EMPS 
SELECT employee_id, last_name, salary, department_id FROM EMPLOYEES;

--上面过程可简化为
CREATE TABLE EMPS AS 
SELECT employee_id, last_name, salary, department_id FROM EMPLOYEES;

--添加列
ALTER TABLE EMPS ADD (hired DATE);

--删除列
ALTER TABLE EMPS DROP COLUMN email;

--修改列
ALTER TABLE EMPS MODIFY(hired DATE DEFAULT SYSDATE);



--------------------------------------------------------
--临时表:包含所有会话都可以访问的定义，其中的行是插入行的会话专用的，临时表的好处是：正对其执行SQL的速度远比永久表快
--------------------------------------------------------
CREATE GLOBAL TEMPORARY TABLE temp_emps ON COMMIT PRESERVE ROWS AS 
SELECT * FROM employees WHERE 1=2;

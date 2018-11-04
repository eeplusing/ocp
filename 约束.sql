--约束
--UNIQUE
--NOT NULL
--PRIMARY KEY
--FOREIGN KEY
--CHECK
DROP TABLE dept;

CREATE TABLE dept(
deptno NUMBER(2,0) CONSTRAINT dept_depno_pk PRIMARY KEY,CONSTRAINT dept_deptno_ck CHECK(deptno BETWEEN 10 AND 90),
dname VARCHAR2(20) CONSTRAINT dept_dname_nn NOT NULL

);
DROP TABLE emp;
CREATE TABLE emp(
empno NUMBER(4,0) CONSTRAINT emp_empno_pk PRIMARY KEY,
ename VARCHAR2(20) CONSTRAINT emp_ename_nn NOT NULL,
mgr NUMBER(4,0) CONSTRAINT emp_mgr_fk REFERENCES emp(empno),
dob DATE,
hiredate DATE,
deptno NUMBER(2,0) CONSTRAINT emp_deptno_fk REFERENCES dept(deptno) ON DELETE SET NULL,
email VARCHAR2(30) CONSTRAINT emp_email_uk1 UNIQUE,
CONSTRAINT emp_hiredate_ck CHECK(hiredate >= dob + 365*16),
CONSTRAINT emp_email_ck CHECK(INSTR(email,'@')>0 AND (INSTR(email,'.')>0))

);

--约束状态，任何时候每个约束都处于请用或禁用状态，验证或非验证状态，状态的切换回影响所有会话
--理想状态是ENABLE VALIDATE,在上传大量数据至表时可置为DISABLE NOVALIDATE可能非常有用
--如下将数据归档表时
ALTER TABLE sales_archive MODIFY CONSTRAINT sa_nnl DISABLE NOVALIDATE;
INSERT INTO sales_archive 
       SELECT * FROM sales_current;

ALTER TABLE sales_archive MODIFY CONSTRAINT sa_nnl ENABLE NOVALIDATE;
UPDATE sales_archive SET channel='NOT KNOWN' WHERE channel IS NULL;
ALTER TABLE sales_archive MODIFY CONSTRAINT sa_nnl ENABLE VALIDATE;

--检查约束，创建约束时默认的是在执行语句时检查约束（IMMEDIATE 约束），切换可延迟结束与会话有关，但始终会应用于所有会话
SET CONSTRAINT sa_nnl DEFERRED;--deferred在提交事务是检查约束
INSERT INTO sales_archive 
       SELECT * FROM sales_current;
UPDATE sales_archive ser chanel='NOT KNOWN' WHERE channel IS NULL;
COMMIT;
SET CONSTRAINT sa_nnl IMMEDIATE;






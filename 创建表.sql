--������
CREATE TABLE EMPS(
EMPNO NUMBER,
ENAME VARCHAR2(25),
SALARY NUMBER,
DEPTNO NUMBER(4, 0)
);

--����ѯ��������
INSERT INTO EMPS 
SELECT employee_id, last_name, salary, department_id FROM EMPLOYEES;

--������̿ɼ�Ϊ
CREATE TABLE EMPS AS 
SELECT employee_id, last_name, salary, department_id FROM EMPLOYEES;

--�����
ALTER TABLE EMPS ADD (hired DATE);

--ɾ����
ALTER TABLE EMPS DROP COLUMN email;

--�޸���
ALTER TABLE EMPS MODIFY(hired DATE DEFAULT SYSDATE);



--------------------------------------------------------
--��ʱ��:�������лỰ�����Է��ʵĶ��壬���е����ǲ����еĻỰר�õģ���ʱ��ĺô��ǣ�������ִ��SQL���ٶ�Զ�����ñ��
--------------------------------------------------------
CREATE GLOBAL TEMPORARY TABLE temp_emps ON COMMIT PRESERVE ROWS AS 
SELECT * FROM employees WHERE 1=2;

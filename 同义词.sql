--ͬ��ʣ��κ�sql����ͨ��ʵ�����ƺ�ͬ��ʷ��ʸö���
/*
 ͬ������ã���ͬ��ʿ��Բ��ÿ����Ǹ�ģʽӵ����ͼ�ͱ��������ÿ��Ǳ�פ�����Ǹ����ݿ���
 */
 SELECT * FROM hr.employees@orcl1;

CREATE PUBLIC SYNONYM emp_synonym FOR hr.employees@orcl1;
--���ϴ�������ͬ��ʣ���ô�����û���������������䣬�˴������û�����ӵ�з��ʵײ�����Ȩ�ޣ����ܳɹ�ʹ�û���ͬ��ʵ�����
--�������ṩ�������޹��ԡ�λ��͸���ԣ������ڲ��޸Ĵ������������������ض�λ�����ͼ

--����ͬ���
CREATE SYNONYM emp_s FOR emp_anon_v;
CREATE SYNONYM dept_s FOR dept_anon_v;
CREATE SYNONYM dsum_s FOR dep_sum_v;

--�鿴ͬ���
describe emp_s;--��sqlplus��

--��dml��ʵ�ʱ���һ��
SELECT * FROM dsum_s;
INSERT INTO dept_s VALUES(99,'Temp Dept',1800);
INSERT INTO emp_s VALUES(SYSDATE,'AC_MGR',10000,0,99);
UPDATE emp_s SET salary=salary*1.1;
ROLLBACK;
SELECT MAX(salaries / staff) FROM dsum_s;

--ɾ����ͼ
DROP VIEW emp_anon_v;
DROP VIEW dept_anon_v;

--��ѯ������ɾ����ͼ�ĸ�����ͼ
SELECT * FROM dep_sum_v;
--���Ա��뱻�ƻ�����ͼ
ALTER VIEW dep_sum_v COMPILE;
--ɾ����ͼ
DROP VIEW dep_sum_v;

--��ѯ��ɾ����ͼ��ͬ���
SELECT * FROM emp_s;

--���±��뱻�ƻ���ͬ���
ALTER SYNONYM emp_s COMPILE;

--ɾ��ͬ���
DROP SYNONYM emp_s;
DROP SYNONYM dept_s;
DROP SYNONYM dsum_s;










--����
--�Ự1
SELECT * FROM regions;
--�Ự2
SELECT * FROM regions;
--�Ự1
INSERT INTO regions VALUES(100,'UK');
--�Ự2
INSERT INTO regions VALUES(101,'GB');
--�Ự1
COMMIT;
SELECT * FROM regions;
--�Ự2
SELECT * FROM regions;
--�Ự1
ROLLBACK;
SELECT * FROM regions;
--�Ự2
ROLLBACK;
SELECT * FROM regions;


--���ز�ѯ
ALTER SESSION SET nls_date_format='dd-mm-yy hh24:mi:ss';
SELECT SYSDATE FROM dual;
DELETE FROM regions WHERE region_id=100;
--�鿴regions19-11-2018 21:14:20ʱ�̵����ݣ�region=100�����Ǵӳ������м���������
SELECT * FROM regions AS OF TIMESTAMP  to_timestamp('19-11-2018 21:14:20','dd-mm-yy hh24:mi:ss');

--���ز�ѯ��Ӧ��
--��ѯ���ݿ�����ǰĳ��ʱ�̵�״̬
SELECT * FROM hr.employees AS OF TIMESTAMP(SYSTIMESTAMP - 10/1440);

--ɾ������������ִ�У���ϣ��������ɾ�����в�ر���,��2����ǰɾ�����в������
INSERT INTO regions(
       SELECT * FROM regions AS OF TIMESTAMP(SYSTIMESTAMP - 2/1440) MINUS SELECT * FROM regions
);


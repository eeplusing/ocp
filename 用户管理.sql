--�����û�
CREATE USER scott IDENTIFIED BY scott;

--�鿴�û�
SELECT * FROM all_users;

SELECT * FROM dba_users;


--�鿴��ռ�
SELECT * FROM user_tablespaces;

SELECT * FROM dba_tablespaces;

--��ѯʹ�ù��ı�ռ�
SELECT DISTINCT tablespace_name FROM user_all_tables;

SELECT DISTINCT tablespace_name FROM dba_all_tables;

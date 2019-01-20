--�û�������Ψһ�����Ȳ�����30��ֻ�ܰ�����ĸ����ĸ���ִ�Сд���Զ�ת��Ϊ��д��ʹ��˫���ŵĳ��⣩�����֡���Ԫ���»��ߣ����Ҳ���ʹ������
--�����û�
--�û����Զ�ת��ΪJOHN
CREATE USER john IDENTIFIED BY pa55w0rd;
--�û���Ϊjohn
CREATE USER "john" IDENTIFIED BY pa55w0rd;
--ʹ��˫���űܿ��ַ�����
CREATE USER "john%#" IDENTIFIED BY pa55w0rd;
--ʹ��˫���űܿ������ֹ���
CREATE USER "table" IDENTIFIED BY pa55w0rd;

--�޸�Ĭ�ϱ�ռ䣬���ڴ������ݿ�ʱδָ��Ĭ�ϱ�ռ䣬��SYSTEM����ΪĬ�ϱ�ռ䣬һ�㲻Ҫ��SYSTEM��ΪĬ�ϵı�ռ�
ALTER DATABASE DEFAULT TABLESPACE tablespace_name;

--����ռ����û�����ռ�õĿռ���
SELECT default_tablespace, temporary_tablespace FROM dba_users WHERE username='HR';
--�޸����
ALTER USER john QUOTA 10m ON USERS;
ALTER USER john QUOTA 10m ON example;
--�鿴�û��ڸ���ռ��е����
SELECT tablespace_name,bytes,max_bytes FROM dba_ts_quotas WHERE username='HR';

SELECT property_name,property_value FROM database_properties WHERE property_name LIKE '%TABLESPACE%';

--�޸��û�����ʱ��ռ�
ALTER USER username TEMPORARY TABLESPACE tablespace_name;

--�û���״̬���򿪡�����LOCKED������EXPIRED���������ڣ�����ʾ�ڼ���޸��˻����룩����ʱ����LOCKED(TIMED)
ALTER USER username ACCOUNT LOCKED;
ALTER USER username ACCOUNT UNLOCK;
--ǿ���û��޸Ŀ���
ALTER USER username PASSWORD EXPIRE;
--��ѯӵ��sysdba��sysoperȨ�޵��û�
SELECT * FROM v$pwfile_users;
--�޸��û�������
ALTER USER username IDENTIFIED BY password;

--oracle�����֤�ķ���
--����ϵͳ�Ϳ����ļ������֤����sys
--���������֤����Ϊ���õķ�ʽ
--�ⲿ�����֤������kerberos��radius,�ⲿ����ϵͳ��֤Ҳ������һ��
--�ⲿ����ϵͳ����֤����
SELECT VALUE FROM v$parameter WHERE NAME='os_authent_prefix';
CREATE USER ops$osuser IDENTIFIED EXTERNALLY;
GRANT CREATE SESSION TO ops$osuser;


--�����û�
CREATE USER alois IDENTIFIED BY aloisDEFAULT TABLESPACE example PASSWORD EXPIRE;
CREATE USER afra IDENTIFIED BY oracle DEFAULT TABLESPACE example QUOTA UNLIMITED ON example;
CREATE USER anja IDENTIFIED BY oracle;

--��Ȩ�ͳ���Ȩ�ޣ�GRANT,REVOKE
/*����ϵͳȨ��*/
GRANT 
CREATE SESSION,
RESTRICTED SESSION,
ALTER DATABASE,
ALTER SYSTEM,
CREATE TABLESPACE,ALTER TABLESPACE,DROP TABLESPACE,
CREATE TABLE,--��������ɾ��������������select��dml������������ġ�ɾ������
GRANT ANY OBJECT PRIVILEGE,--������Ȩ�˽��䱾��ӵ�еĶ���Ķ���Ȩ���������ˣ������������Լ�
DROP ANY TABLE,--����Ȩ�˿���ɾ���κα�
INSERT ANY TABLE,
UPDATE ANY TABLE,
DELETE ANY TABLE,
SELECT ANY TABLE
TO username;

/*����Ȩ��*/
GRANT SELECT,--����ͼ�����С�ͬ���
INSERT,--����ͼ��ͬ���
UPDATE,--����ͼ��ͬ���
DELETE,--����ͼ��ͬ���
ALTER,--����ͼ������
EXECUTE --���̡�����������ͬ���
ON schema.object TO username;

CREATE USER scott IDENTIFIED BY scott;
GRANT SELECT ON hr.regions TO scott;
GRANT UPDATE (salary) ON hr.employees TO scott;
GRANT ALL ON hr.regions TO scott;


GRANT 
CREATE SESSION,
ALTER SESSION,
CREATE TABLE,
CREATE VIEW,
CREATE SYNONYM,
CREATE CLUSTER,
CREATE DATABASE LINK,
CREATE SEQUENCE,
CREATE TRIGGER,
CREATE TYPE,
CREATE PROCEDURE,
CREATE OPERATOR
TO username;

--��systemȨ�޵�¼
GRANT CREATE TABLE TO scott WITH ADMIN OPTION;

--����Ȩ�޴�����Ȩ��
GRANT SELECT ON hr.employees TO scott WITH GRANT OPTION;

/*Ȩ�޹������*/
CREATE USER alois IDENTIFIED BY alois;
GRANT CREATE SESSION TO alois;
GRANT CREATE TABLE TO alois;
ALTER USER alois QUOTA 1m ON USERS;
--��Ȩ������
CREATE USER afra IDENTIFIED BY afra;
GRANT ALL ON t2 TO afra;
GRANT SELECT ON t1 TO afra;
--system��¼�鿴�������Ȩ���
SELECT table_name,grantee,privilege,grantor,grantable FROM dba_tab_privs t WHERE owner='ALOIS' AND table_name IN('T1','T2');
--����Ȩ��
REVOKE ALL ON t1 FROM afra;
REVOKE ALL ON t2 FROM afra;

/*�����ɫ*/
CREATE ROLE hr_junior;
GRANT CREATE SESSION TO hr_junior;
GRANT SELECT ON hr.employees TO hr_junior;

CREATE ROLE hr_senior;
GRANT INSERT,UPDATE,DELETE ON hr.employees TO hr_senior;

CREATE ROLE hr_manager;
GRANT hr_senior TO hr_manager WITH ADMIN OPTION;
GRANT ALL ON hr.employees TO hr_manager;

--Ԥ����Ľ�ɫCONNECT,RESOURCE,DBA,SELECT_CATALOG_ROLE,SCHEDULER_ADMIN,PUBLIC
GRANT SELECT ON hr.regions TO PUBLIC;--�����û�����Ȩ��ѯhr.regions��

--�ڴ洢���������ý�ɫ
CREATE ROLE rolename IDENTIFIED USING procedure_name;

/*��ɫ����ʾ��*/
CREATE USER anja IDENTIFIED BY anja;
CREATE ROLE usr_role;
CREATE ROLE mgr_role;

GRANT CREATE SESSION TO usr_role;
GRANT SELECT ON alois.t1 TO usr_role;
GRANT usr_role TO mgr_role WITH ADMIN OPTION;
GRANT ALL ON alois.t1 TO mgr_role;

GRANT mgr_role TO afra;

GRANT usr_role TO anja;

GRANT CONNECT TO anja;
ALTER USER anja DEFAULT ROLE CONNECT; --anja�Ͽ������������Ӻ����Ч
--�鿴��ɫʹ�����
SELECT * FROM dba_role_privs WHERE granted_role IN('USR_ROLE','MGR_ROLE');

SELECT grantee,owner,table_name,privilege,grantable FROM dba_tab_privs WHERE grantee IN('USR_ROLE','MGR_ROLE')
UNION ALL
SELECT grantee,to_char(NULL),to_char(NULL),privilege, admin_option FROM dba_sys_privs WHERE grantee IN('USR_ROLE','MGR_ROLE')
ORDER BY grantee;

--��ѯ�����ļ�
SELECT username,profile FROM dba_users;
SELECT * FROM dba_profiles WHERE profile='DEFAULT';
/*
1 DEFAULT COMPOSITE_LIMIT KERNEL  UNLIMITED NO  NO  NO
8 DEFAULT CONNECT_TIME  KERNEL  UNLIMITED NO  NO  NO
4 DEFAULT CPU_PER_CALL  KERNEL  UNLIMITED NO  NO  NO
3 DEFAULT CPU_PER_SESSION KERNEL  UNLIMITED NO  NO  NO
10  DEFAULT FAILED_LOGIN_ATTEMPTS PASSWORD  10  NO  NO  NO
7 DEFAULT IDLE_TIME KERNEL  UNLIMITED NO  NO  NO
17  DEFAULT INACTIVE_ACCOUNT_TIME PASSWORD  UNLIMITED NO  NO  NO
6 DEFAULT LOGICAL_READS_PER_CALL  KERNEL  UNLIMITED NO  NO  NO
5 DEFAULT LOGICAL_READS_PER_SESSION KERNEL  UNLIMITED NO  NO  NO
16  DEFAULT PASSWORD_GRACE_TIME PASSWORD  7 NO  NO  NO
11  DEFAULT PASSWORD_LIFE_TIME  PASSWORD  UNLIMITED NO  NO  NO
15  DEFAULT PASSWORD_LOCK_TIME  PASSWORD  1 NO  NO  NO
13  DEFAULT PASSWORD_REUSE_MAX  PASSWORD  UNLIMITED NO  NO  NO
12  DEFAULT PASSWORD_REUSE_TIME PASSWORD  UNLIMITED NO  NO  NO
14  DEFAULT PASSWORD_VERIFY_FUNCTION  PASSWORD  NULL  NO  NO  NO
9 DEFAULT PRIVATE_SGA KERNEL  UNLIMITED NO  NO  NO
2 DEFAULT SESSIONS_PER_USER KERNEL  UNLIMITED NO  NO  NO

*/

--�����ͷ��������ļ�����sys�û���¼
select * from dba_profiles where resource_name='PASSWORD_VERIFY_FUNCTION';

--���������������
CREATE PROFILE two_wrong LIMIT FAILED_LOGIN_ATTEMPTS 2 PASSWORD_LOCK_TIME 10/1440;
--�û����������ļ�
ALTER USER alois PROFILE two_wrong;

SELECT account_status FROM dba_users WHERE username='ALOIS';
ALTER USER alois ACCOUNT UNLOCK;
SELECT account_status FROM dba_users WHERE username='ALOIS';
--ɾ�������ļ�
DROP PROFILE two_wrong CASCADE;
ALTER PROFILE DEFAULT LIMIT PASSWORD_VERIFY_FUNCTION NULL;
DROP ROLE usr_role;
DROP ROLE mgr_role;
DROP USER alois CASCADE;
DROP USER anja;
DROP USER afra;



























































--用户名必须唯一，长度不超过30，只能包含字母（字母区分大小写但自动转换为大写，使用双引号的除外）、数字、美元和下划线，并且不能使保留字
--创建用户
--用户名自动转换为JOHN
CREATE USER john IDENTIFIED BY pa55w0rd;
--用户名为john
CREATE USER "john" IDENTIFIED BY pa55w0rd;
--使用双引号避开字符规则
CREATE USER "john%#" IDENTIFIED BY pa55w0rd;
--使用双引号避开保留字规则
CREATE USER "table" IDENTIFIED BY pa55w0rd;

--修改默认表空间，若在创建数据库时未指定默认表空间，则将SYSTEM设置为默认表空间，一般不要将SYSTEM作为默认的表空间
ALTER DATABASE DEFAULT TABLESPACE tablespace_name;

--配额，表空间中用户允许占用的空间量
SELECT default_tablespace, temporary_tablespace FROM dba_users WHERE username='HR';
--修改配额
ALTER USER john QUOTA 10m ON USERS;
ALTER USER john QUOTA 10m ON example;
--查看用户在各表空间中的配额
SELECT tablespace_name,bytes,max_bytes FROM dba_ts_quotas WHERE username='HR';

SELECT property_name,property_value FROM database_properties WHERE property_name LIKE '%TABLESPACE%';

--修改用户的临时表空间
ALTER USER username TEMPORARY TABLESPACE tablespace_name;

--用户的状态，打开、锁定LOCKED、过期EXPIRED、正常过期（在提示期间可修改账户密码）、超时锁定LOCKED(TIMED)
ALTER USER username ACCOUNT LOCKED;
ALTER USER username ACCOUNT UNLOCK;
--强制用户修改口令
ALTER USER username PASSWORD EXPIRE;
--查询拥有sysdba和sysoper权限的用户
SELECT * FROM v$pwfile_users;
--修改用户名密码
ALTER USER username IDENTIFIED BY password;

--oracle身份验证的方法
--操作系统和口令文件身份验证，如sys
--口令身份验证，最为常用的方式
--外部身份验证，例如kerberos、radius,外部操作系统认证也属于这一种
--外部操作系统的认证举例
SELECT VALUE FROM v$parameter WHERE NAME='os_authent_prefix';
CREATE USER ops$osuser IDENTIFIED EXTERNALLY;
GRANT CREATE SESSION TO ops$osuser;


--创建用户
CREATE USER alois IDENTIFIED BY aloisDEFAULT TABLESPACE example PASSWORD EXPIRE;
CREATE USER afra IDENTIFIED BY oracle DEFAULT TABLESPACE example QUOTA UNLIMITED ON example;
CREATE USER anja IDENTIFIED BY oracle;

--授权和撤销权限，GRANT,REVOKE
/*常用系统权限*/
GRANT 
CREATE SESSION,
RESTRICTED SESSION,
ALTER DATABASE,
ALTER SYSTEM,
CREATE TABLESPACE,ALTER TABLESPACE,DROP TABLESPACE,
CREATE TABLE,--包括更改删除表，在其上运行select和dml命令，创建、更改、删除索引
GRANT ANY OBJECT PRIVILEGE,--允许被授权人将其本身不拥有的对象的对象权限授予他人，但不能授予自己
DROP ANY TABLE,--被授权人可以删除任何表
INSERT ANY TABLE,
UPDATE ANY TABLE,
DELETE ANY TABLE,
SELECT ANY TABLE
TO username;

/*对象权限*/
GRANT SELECT,--表、视图、序列、同义词
INSERT,--表、视图、同义词
UPDATE,--表、视图、同义词
DELETE,--表、视图、同义词
ALTER,--表、视图、序列
EXECUTE --过程、函数、包、同义词
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

--以system权限登录
GRANT CREATE TABLE TO scott WITH ADMIN OPTION;

--授予权限传播的权利
GRANT SELECT ON hr.employees TO scott WITH GRANT OPTION;

/*权限管理举例*/
CREATE USER alois IDENTIFIED BY alois;
GRANT CREATE SESSION TO alois;
GRANT CREATE TABLE TO alois;
ALTER USER alois QUOTA 1m ON USERS;
--授权给他人
CREATE USER afra IDENTIFIED BY afra;
GRANT ALL ON t2 TO afra;
GRANT SELECT ON t1 TO afra;
--system登录查看对象的授权情况
SELECT table_name,grantee,privilege,grantor,grantable FROM dba_tab_privs t WHERE owner='ALOIS' AND table_name IN('T1','T2');
--撤销权限
REVOKE ALL ON t1 FROM afra;
REVOKE ALL ON t2 FROM afra;

/*管理角色*/
CREATE ROLE hr_junior;
GRANT CREATE SESSION TO hr_junior;
GRANT SELECT ON hr.employees TO hr_junior;

CREATE ROLE hr_senior;
GRANT INSERT,UPDATE,DELETE ON hr.employees TO hr_senior;

CREATE ROLE hr_manager;
GRANT hr_senior TO hr_manager WITH ADMIN OPTION;
GRANT ALL ON hr.employees TO hr_manager;

--预定义的角色CONNECT,RESOURCE,DBA,SELECT_CATALOG_ROLE,SCHEDULER_ADMIN,PUBLIC
GRANT SELECT ON hr.regions TO PUBLIC;--所有用户都有权查询hr.regions表

--在存储过程中启用角色
CREATE ROLE rolename IDENTIFIED USING procedure_name;

/*角色管理示例*/
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
ALTER USER anja DEFAULT ROLE CONNECT; --anja断开连接重新连接后才生效
--查看角色使用情况
SELECT * FROM dba_role_privs WHERE granted_role IN('USR_ROLE','MGR_ROLE');

SELECT grantee,owner,table_name,privilege,grantable FROM dba_tab_privs WHERE grantee IN('USR_ROLE','MGR_ROLE')
UNION ALL
SELECT grantee,to_char(NULL),to_char(NULL),privilege, admin_option FROM dba_sys_privs WHERE grantee IN('USR_ROLE','MGR_ROLE')
ORDER BY grantee;

--查询配置文件
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

--创建和分配配置文件，以sys用户登录
select * from dba_profiles where resource_name='PASSWORD_VERIFY_FUNCTION';

--密码错误两次锁定
CREATE PROFILE two_wrong LIMIT FAILED_LOGIN_ATTEMPTS 2 PASSWORD_LOCK_TIME 10/1440;
--用户关联配置文件
ALTER USER alois PROFILE two_wrong;

SELECT account_status FROM dba_users WHERE username='ALOIS';
ALTER USER alois ACCOUNT UNLOCK;
SELECT account_status FROM dba_users WHERE username='ALOIS';
--删除配置文件
DROP PROFILE two_wrong CASCADE;
ALTER PROFILE DEFAULT LIMIT PASSWORD_VERIFY_FUNCTION NULL;
DROP ROLE usr_role;
DROP ROLE mgr_role;
DROP USER alois CASCADE;
DROP USER anja;
DROP USER afra;



























































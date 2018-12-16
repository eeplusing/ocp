--创建用户
CREATE USER ocpdbadmin IDENTIFIED BY ocpdb123;

--修改用户密码
ALTER USER ocpdbadmin IDENTIFIED BY ocpdbadmin123;

--查看当前用户对应的profile 和密码周期
SELECT * FROM dba_profiles WHERE PROFILE='DEFAULT' AND resource_name='PASSWORD_LIFE_TIME';

--将用户的密码周期设置为无限：
ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;

--查看用户状态
SELECT * FROM  dba_users t WHERE t.username='HR';

--解锁用户
ALTER USER hr ACCOUNT UNLOCK;

--锁定用户
ALTER USER hr ACCOUNT LOCK;

--账户解锁和修改密码
alter user system identified by manager account unlock;

--删除用户
DROP USER ocpdbadmin cascade;


--1.查看所有用户：
SELECT * FROM  dba_users;
SELECT * FROM  all_users;
SELECT * FROM  user_users;
  
SELECT * FROM  all_users t WHERE t.USERNAME IN('SYS','OCPDBA') ;
SELECT * FROM  dba_users t WHERE t.USERNAME IN('SYS','OCPDBA');


--2.查看用户或角色系统权限(直接赋值给用户或角色的系统权限)：
SELECT * FROM  dba_sys_privs;
SELECT * FROM  user_sys_privs;
 
--3.查看角色(只能查看登陆用户拥有的角色)所包含的权限
SELECT * FROM   role_sys_privs;

--4.查看用户对象权限：
SELECT * FROM   dba_tab_privs;
SELECT * FROM   all_tab_privs;
SELECT * FROM   user_tab_privs;

--5.查看所有角色：
SELECT * FROM   dba_roles;

--6.查看用户或角色所拥有的角色：
SELECT * FROM   dba_role_privs;
SELECT * FROM   user_role_privs;
 
--7.查看哪些用户有sysdba或sysoper系统权限(查询时需要相应权限)
SELECT * FROM  V$PWFILE_USERS;
--------------------- 


   
--查看表空间
SELECT * FROM  user_tablespaces;

SELECT * FROM  dba_tablespaces;

--查询使用过的表空间
SELECT DISTINCT tablespace_name FROM user_all_tables;

SELECT DISTINCT tablespace_name FROM dba_all_tables;



--查看被授予sysdba权限的用户
SELECT USERNAME FROM V$PWFILE_USERS WHERE SYSDBA='TRUE';

--sqlplus下使用
--查看当前登录用户
SHOW USER;
show parameter PASSWORD;

--开启了Oracle Database Vault 以后，dba的权限将大大受限，除了dba自己相关的东西可以查，基本不可以访问其他object的权限
--create user，alter user，这些基本操作也都不能通过dba用户执行了

--查看是否开启Oracle Database Vault，TRUE开启，FALSE关闭
SELECT * FROM  v$option WHERE parameter LIKE '%Oracle Database Vault%';
--11g与12c不同，12c关闭方法如下:
/*
SQL>conn ocpdba/Oracle123@orcl1;
已连接。

SQL> exec dbms_macadm.disable_dv;
PL/SQL 过程已成功完成。
 
SQL> conn sys/Oracle123 as sysdba
已连接。

SQL> shutdown immediate
数据库已经关闭。
已经卸载数据库。
ORACLE 例程已经关闭。

SQL> startup
ORACLE 例程已经启动。
 
Total System Global Area 1426063360 bytes
Fixed Size                  2924400 bytes
Variable Size             872415376 bytes
Database Buffers          536870912 bytes
Redo Buffers               13852672 bytes
数据库装载完毕。
数据库已经打开。
*/

--若执行shutdown immediate 报错如
SQL> shutdown immediate;
ORA-00106: 无法在连接到调度程序时启动/关闭数据库
/*
查看tnsnames.ora

MYTEST =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = *********)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = SHARED)
      (SERVICE_NAME = MYTEST)
    )
  )

将共享模式修改成专有模式

MYTEST =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = *********)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = MYTEST)
    )
  )

*/

--再次查看Oracle Database Vault状态
SQL> SELECT * FROM V$OPTION WHERE PARAMETER = 'Oracle Database Vault';
 
PARAMETER                      VALUE                              CON_ID
------------------------------ ------------------------------ ----------
Oracle Database Vault          FALSE                                   0




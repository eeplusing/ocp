--oracle实例管理
--DATABASE express  http://localhost:5500/em
--查看express的端口
SELECT dbms_xdb_config.getHTTPPort FROM dual;
--创建端express侦听端口,默认5500
EXEC dbms_xdb_config.setHTTPPort(5050);  

--查看参数
--查看当前实例中当前生效的值
SELECT NAME, VALUE FROM v$parameter ORDER BY NAME;
--差看spfile文件中的存储的值
SELECT NAME, VALUE FROM v$spparameter ORDER BY NAME;
--查询不同的配置
SELECT NAME, VALUE FROM v$parameter MINUS SELECT NAME, VALUE FROM v$spparameter;

--查询基本参数
SELECT NAME, VALUE FROM v$parameter WHERE isbasic='TRUE' ORDER BY NAME;
SELECT s.NAME, s.VALUE FROM v$spparameter s JOIN  v$parameter p ON s.name=p.name WHERE isbasic='TRUE' ORDER BY NAME;

--更改参数
SELECT p.value in_effect, s.value in_file FROM v$parameter p JOIN v$spparameter s ON p.name=s.name 
WHERE p.name='db_file_multiblock_read_count';

SQL> ALTER SYSTEM SET db_file_multiblock_read_count=16 SCOPE=MEMORY;
System altered

SQL> ALTER SYSTEM SET db_file_multiblock_read_count=64 SCOPE=SPFILE;
System altered
--16	64

--不知名范围默认的是BOTH，应用于运行的实例和spfile
SQL> ALTER SYSTEM RESET db_file_multiblock_read_count;
System altered
--16 null	

--修改静态参数需要重启实例
SELECT VALUE FROM v$parameter WHERE NAME='processes';
SQL> alter system set processes=200 scope=spfile;
System altered

--修改optimizer_mode参数,仅修改实例范围参数不需要重启
SELECT VALUE FROM v$parameter WHERE NAME='optimizer_mode';
ALTER SYSTEM SET optimizer_mode=RULE SCOPE='optimizer_mode';
SQL> ALTER SYSTEM RESET optimizer_mode scope=memory;
System altered


--以操作系统身份登录
sqlplus / AS SYSDBA
--只启动实例
startup nomount
--加载数据库
ALTER DATABASE MOUNT;
--打开数据库
ALTER DATABASE OPEN;
--查看数据库状态
SELECT open_mode FROM v$database;

--报警日志文件位置
SELECT VALUE FROM v$parameter WHERE NAME='diagnostic_dest';
SELECT VALUE FROM v$parameter WHERE NAME='db_name';
SELECT VALUE FROM v$parameter WHERE NAME='instance_name';
SELECT VALUE FROM v$parameter WHERE NAME='background_dump_dest';
SELECT VALUE FROM v$parameter WHERE NAME='user_dump_dest';
--DDL日志
SELECT VALUE FROM v$parameter WHERE NAME='enable_ddl_logging';
--查询控制文件位置
SELECT VALUE FROM v$parameter WHERE NAME='control_files';


SQL> describe v$instance;
Name             Type         Nullable Default Comments 
---------------- ------------ -------- ------- -------- 
INSTANCE_NUMBER  NUMBER       Y                         
INSTANCE_NAME    VARCHAR2(16) Y                         
HOST_NAME        VARCHAR2(64) Y                         
VERSION          VARCHAR2(17) Y                         
STARTUP_TIME     DATE         Y                         
STATUS           VARCHAR2(12) Y                         
PARALLEL         VARCHAR2(3)  Y                         
THREAD#          NUMBER       Y                         
ARCHIVER         VARCHAR2(7)  Y                         
LOG_SWITCH_WAIT  VARCHAR2(15) Y                         
LOGINS           VARCHAR2(10) Y                         
SHUTDOWN_PENDING VARCHAR2(3)  Y                         
DATABASE_STATUS  VARCHAR2(17) Y                         
INSTANCE_ROLE    VARCHAR2(18) Y                         
ACTIVE_STATE     VARCHAR2(9)  Y                         
BLOCKED          VARCHAR2(3)  Y                         
CON_ID           NUMBER       Y                         
INSTANCE_MODE    VARCHAR2(11) Y                         
EDITION          VARCHAR2(7)  Y                         
FAMILY           VARCHAR2(80) Y                         
DATABASE_TYPE    VARCHAR2(15) Y 


--动态性能视图
SELECT owner, object_name, object_type FROM dba_objects WHERE object_name LIKE 'V%INSTANCE';
--始终可以使用的视图，即使在NOMOUNT模式下
SELECT * FROM V$INSTANCE;
SELECT * FROM V$SYSSTAT;
--在加载了数据库的情况下才允许查询
SELECT * FROM V$DATABASE;
SELECT * FROM V$DATAFILE;

--查询构成数据库的数据文件和表空间
SELECT t.name,d.name,d.bytes FROM v$tablespace t JOIN v$datafile d ON t.ts#=d.ts# ORDER BY t.name;
--从数据字典查询上述信息
SELECT t.TABLESPACE_NAME, d.FILE_NAME, d.BYTES FROM dba_tablespaces t JOIN dba_data_files d 
ON t.TABLESPACE_NAME=d.TABLESPACE_NAME ORDER BY tablespace_name;


















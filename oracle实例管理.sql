--oracleʵ������
--DATABASE express  http://localhost:5500/em
--�鿴express�Ķ˿�
SELECT dbms_xdb_config.getHTTPPort FROM dual;
--������express�����˿�,Ĭ��5500
EXEC dbms_xdb_config.setHTTPPort(5050);  

--�鿴����
--�鿴��ǰʵ���е�ǰ��Ч��ֵ
SELECT NAME, VALUE FROM v$parameter ORDER BY NAME;
--�spfile�ļ��еĴ洢��ֵ
SELECT NAME, VALUE FROM v$spparameter ORDER BY NAME;
--��ѯ��ͬ������
SELECT NAME, VALUE FROM v$parameter MINUS SELECT NAME, VALUE FROM v$spparameter;

--��ѯ��������
SELECT NAME, VALUE FROM v$parameter WHERE isbasic='TRUE' ORDER BY NAME;
SELECT s.NAME, s.VALUE FROM v$spparameter s JOIN  v$parameter p ON s.name=p.name WHERE isbasic='TRUE' ORDER BY NAME;

--���Ĳ���
SELECT p.value in_effect, s.value in_file FROM v$parameter p JOIN v$spparameter s ON p.name=s.name 
WHERE p.name='db_file_multiblock_read_count';

SQL> ALTER SYSTEM SET db_file_multiblock_read_count=16 SCOPE=MEMORY;
System altered

SQL> ALTER SYSTEM SET db_file_multiblock_read_count=64 SCOPE=SPFILE;
System altered
--16	64

--��֪����ΧĬ�ϵ���BOTH��Ӧ�������е�ʵ����spfile
SQL> ALTER SYSTEM RESET db_file_multiblock_read_count;
System altered
--16 null	

--�޸ľ�̬������Ҫ����ʵ��
SELECT VALUE FROM v$parameter WHERE NAME='processes';
SQL> alter system set processes=200 scope=spfile;
System altered

--�޸�optimizer_mode����,���޸�ʵ����Χ��������Ҫ����
SELECT VALUE FROM v$parameter WHERE NAME='optimizer_mode';
ALTER SYSTEM SET optimizer_mode=RULE SCOPE='optimizer_mode';
SQL> ALTER SYSTEM RESET optimizer_mode scope=memory;
System altered


--�Բ���ϵͳ��ݵ�¼
sqlplus / AS SYSDBA
--ֻ����ʵ��
startup nomount
--�������ݿ�
ALTER DATABASE MOUNT;
--�����ݿ�
ALTER DATABASE OPEN;
--�鿴���ݿ�״̬
SELECT open_mode FROM v$database;

--������־�ļ�λ��
SELECT VALUE FROM v$parameter WHERE NAME='diagnostic_dest';
SELECT VALUE FROM v$parameter WHERE NAME='db_name';
SELECT VALUE FROM v$parameter WHERE NAME='instance_name';
SELECT VALUE FROM v$parameter WHERE NAME='background_dump_dest';
SELECT VALUE FROM v$parameter WHERE NAME='user_dump_dest';
--DDL��־
SELECT VALUE FROM v$parameter WHERE NAME='enable_ddl_logging';
--��ѯ�����ļ�λ��
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


--��̬������ͼ
SELECT owner, object_name, object_type FROM dba_objects WHERE object_name LIKE 'V%INSTANCE';
--ʼ�տ���ʹ�õ���ͼ����ʹ��NOMOUNTģʽ��
SELECT * FROM V$INSTANCE;
SELECT * FROM V$SYSSTAT;
--�ڼ��������ݿ������²������ѯ
SELECT * FROM V$DATABASE;
SELECT * FROM V$DATAFILE;

--��ѯ�������ݿ�������ļ��ͱ�ռ�
SELECT t.name,d.name,d.bytes FROM v$tablespace t JOIN v$datafile d ON t.ts#=d.ts# ORDER BY t.name;
--�������ֵ��ѯ������Ϣ
SELECT t.TABLESPACE_NAME, d.FILE_NAME, d.BYTES FROM dba_tablespaces t JOIN dba_data_files d 
ON t.TABLESPACE_NAME=d.TABLESPACE_NAME ORDER BY tablespace_name;


















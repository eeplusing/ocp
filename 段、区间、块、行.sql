--�Ρ����䡢�顢��
--��ѯ������ ��system��¼
SELECT segment_type, COUNT(1) FROM dba_segments GROUP BY segment_type ORDER BY segment_type;

SELECT NAME FROM v$controlfile;

SELECT member, bytes FROM v$logfile JOIN v$log USING (group#);

--�鿴��ռ估������������ļ�
SELECT tablespace_name, t.contents, d.file_name AS "�����ļ�" FROM dba_tablespaces t JOIN dba_data_files d USING(tablespace_name);
SELECT t.name, d.name, d.bytes FROM v$tablespace t JOIN v$datafile d USING(ts#) 
--�鿴��ʱ��ռ估������������ļ�
SELECT tablespace_name, t.contents, d.file_name AS "�����ļ�" FROM dba_tablespaces t JOIN dba_temp_files d USING(tablespace_name);
SELECT t.name, d.name, d.bytes FROM v$tablespace t JOIN v$tempfile d USING(ts#)

SELECT t.name, d.name, d.bytes FROM v$tablespace t JOIN v$datafile d USING(ts#) 
UNION ALL
SELECT t.name, d.name, d.bytes FROM v$tablespace t JOIN v$tempfile d USING(ts#); 

SELECT tablespace_name, t.contents, d.file_name, d.bytes FROM dba_tablespaces t JOIN dba_data_files d USING(tablespace_name) 
UNION ALL
SELECT tablespace_name, t.contents, d.file_name, d.bytes FROM dba_tablespaces t JOIN dba_temp_files d USING(tablespace_name); 

--�鿴��������洢λ��
CREATE TABLE system.mytable AS SELECT * FROM all_objects;
SELECT tablespace_name FROM dba_tables WHERE owner='SYSTEM' AND table_name='MYTABLE';
SELECT tablespace_name, segment_type FROM dba_segments WHERE owner='SYSTEM' AND segment_name='MYTABLE';
SELECT file_name, extent_id, block_id FROM dba_data_files JOIN dba_extents USING(file_id) WHERE owner='SYSTEM' AND segment_name='MYTABLE';

ALTER TABLE system.mytable MOVE tablespace SYSAUX;

DROP TABLE system.mytable;

--������ռ�
--SMALLFILE��Ĭ��ֵ���滻ֵBIGFILE
CREATE SMALLFILE TABLESPACE "TESTTABLESPACE" 
 DATAFILE '/u01/app/oracle/oradata/orcltesttablesapce01.dbf'
 SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE 200M
 LOGGING
 DEFAULT NOCOMPRESS NO INMEMORY
 ONLINE
 EXTENT MANAGEMENT LOCAL AUTOALLOCATE
 SEGMENT SPACE MANAGEMENT AUTO;
 
 --��ռ����ʾ��
 CREATE tablespace newtbs 
 DATAFILE '/u01/app/oracle/oradata/ORCL1/datafile/newtbs_01.dbf' SIZE 10M
 EXTENT MANAGEMENT LOCAL AUTOALLOCATE
 SEGMENT SPACE MANAGEMENT AUTO;
 
 CREATE TABLE newtab(c1 DATE) TABLESPACE newtbs_new;
 
 SELECT extent_id,bytes FROM dba_extents WHERE owner='SYSTEM' AND segment_name='NEWTAB';
 --���ı�ռ�
 ALTER TABLE newtab ALLOCATE EXTENT;
 --ʹ��ռ��ѻ�
 ALTER TABLESPACE newtbs OFFLINE;
 --��ռ��ѻ�������ɾ����
 DELETE newtab;
 DROP newtab;
 --ʹ��ռ�����
 ALTER TABLESPACE newtbs ONLINE;
 --����ռ���Ϊֻ��
 ALTER TABLESPACE newtbs READ ONLY;
 DELETE newtab;
 DROP newtab;
 --����ռ���Ϊ��д
 ALTER TABLESPACE newtbs READ WRITE;
 --��������ռ�
 ALTER TABLESPACE newtbs RENAME TO newtbs_new;
 SELECT extent_id,bytes FROM dba_extents WHERE owner='SYSTEM' AND segment_name='NEWTAB';
 DROP TABLESPACE newtbs_new INCLUDING contents AND datafiles;
--���µ�����ռ��С
ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/orcltesttablesapce01.dbf' RESIZE 10M;
--���ռ���������ļ�
ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/orcltesttablesapce02.dbf' RESIZE 2g;
--����Զ���չ�Ӿ�
ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/orcltesttablesapce03.dbf' AUTOEXTEND ON NEXT 100M MAXSIZE 4g;

 --ɾ����ռ�
 DROP TABLESPACE newtbs INCLUDING contents AND datafiles;
 
 --��ѯ��ռ�
 --�鿴��������Ƿ�Ϊ���ع���
 SELECT tablespace_name, extent_management FROM dba_tablespaces;
 --�鿴��ռ��Ƿ���ʹ���ֶ�����
 SELECT tablespace_name, segment_space_management FROM dba_tablespaces;
 
 --���ı�ռ����� /u01/app/oracle/oradata/ORCL1/datafile/
 ALTER SYSTEM SET db_create_file_dest='/u01/app/oracle/oradata';
 CREATE TABLESPACE omftbs;
 SELECT file_name,bytes,autoextensible,maxbytes,increment_by FROM dba_data_files WHERE tablespace_name='OMFTBS';
 ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/ORCL1/datafile/o1_mf_omftbs_g2myjyg7_.dbf' RESIZE 500M;
 ALTER DATABASE DATAFILE '/u01/app/oracle/oradata/ORCL1/datafile/o1_mf_omftbs_g2myjyg7_.dbf' AUTOEXTEND ON NEXT 100M MAXSIZE 2G;
 --ɾ����ռ�
 DROP TABLESPACE omftbs INCLUDING CONTENTS AND DATAFILES;
 
 --ʹ���ֶ��οռ��������ռ�
 CREATE TABLESPACE manualsegs SEGMENT SPACE MANAGEMENT MANUAL;
 SELECT segment_space_management FROM dba_tablespaces WHERE tablespace_name='MANUALSEGS';
 CREATE TABLE mantab(c1 NUMBER) TABLESPACE manualsegs;
 CREATE INDEX mantabi ON mantab(c1) TABLESPACE manualsegs;
 --ʹ���Զ��οռ��������ռ�
 CREATE TABLESPACE autosegs;
 ALTER TABLE mantab MOVE TABLESPACE autosegs;
 ALTER INDEX mantabi REBUILD ONLINE TABLESPACE autosegs;
 SELECT * FROM dba_segments WHERE segment_name LIKE 'MANTAB%';
 --ʹ���±�ռ��滻�ͱ�ռ�
 DROP TABLESPACE manualsegs INCLUDING CONTENTS AND DATAFILES;
 --��������ռ�
 ALTER TABLESPACE autosegs RENAME TO manualsegs;
 --��ձ�ռ� ɾ���ǿձ�ռ䱨��
 DROP TABLESPACE manualsegs;
 DROP TABLESPACE manualsegs INCLUDING CONTENTS AND DATAFILES;
 
 -------------------------------------------------------------------------------
 ----�ռ���3�������Ϲ�����ռ䡢�Ρ���
 SELECT table_name,segment_created FROM user_tables;
 SELECT index_name,segment_created FROM user_indexes;
 SELECT segment_name, segment_type FROM user_segments;
 
 --����οռ�ʾ��
CREATE USER ex7 IDENTIFIED BY ex7;
GRANT DBA TO ex7;
SQL> connect ex7/ex7
SQL> show parameter deferred_segment_creation
NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
deferred_segment_creation            boolean     TRUE
SQL> alter session set deferred_segment_creation=true;
Session altered

CREATE TABLE ex7a(c1 VARCHAR2(10));
--�ӳٴ�����
CREATE TABLE ex7b(c1 VARCHAR2(10)) SEGMENT creation DEFERRED;
CREATE TABLE ex7c(c1 VARCHAR2(10)) SEGMENT creation IMMEDIATE;

CREATE INDEX ex7ai ON ex7a(c1);
CREATE INDEX ex7bi ON ex7b(c1);
CREATE INDEX ex7ci ON ex7c(c1);
 
SELECT segment_name FROM user_segments;
SELECT table_name, segment_created FROM user_tables;
SELECT index_name, segment_created FROM user_indexes;
 
INSERT INTO ex7a VALUES('a1'); 
INSERT INTO ex7b VALUES('b1');
--�ٴβ�ѯ���Ƿ񴴽�
SELECT segment_name FROM user_segments;
SELECT table_name, segment_created FROM user_tables;
SELECT index_name, segment_created FROM user_indexes;

--����ʹ��ѹ���ı�,ѹ����3����ʽ���������ʽѹ��
--������ѹ��
CREATE TABLE testtable COMPRESS;
--�߼���ѹ��
CREATE TABLE testtable1 ROW STORE COMPRESS ADVANCED;

--�ڻỰ�������ÿɻָ��ռ���䣬����60s���ش��������ʧ��
ALTER SESSION ENABLE RESUMABLE TIMEOUT 60;
ALTER SYSTEM SET resumable_timeout=60;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

--Oracle��ϵ�ṹ
--oracle��������ʵ�������ݿ�����ʵ����ɣ�ʵ�������ڴ�ṹ�ͽ�����ɣ����ݿ��ɴ����ϵ��ļ���ɡ�
--oracle db�������ϴ�����洢����ȫ�������߼��洢������Ա�����Ĵ洢�ṹ��ֱ����ϵͳ����Ա����������ṹ��أ����ߵĹ�ϵ�ɿ����ļ��������ֵ��еĽṹά����
 
--����oracle���ݿ�������ļ��������ļ�������������־�ļ��������ļ�  /u01/app/oracle/oradata/dbinstancename/controlfile/��datafile/ ��onlinelog/ 

--��system�û���¼
--��ʵ������NO
SELECT parallel FROM v$instance;
--���ݿ�δ�ܱ�������UNPROTECTED
SELECT protection_level FROM v$database;
--�Ƿ���������,û���÷��ؿ�
SELECT * FROM dba_streams_administrator;
--��ѯ���ݿ������ṹ�ļ���
--���ݿ��ļ�
SELECT name,bytes FROM v$datafile;
--��ʱ�ļ�
SELECT name,bytes FROM v$tempfile;
--��־�ļ�
SELECT MEMBER FROM v$logfile;
--�����ļ�
SELECT * FROM v$controlfile;

--show sga;������ʾSGA��Ϣ
--��ѯSGA�����ǰ�������С������
SELECT component,current_size,min_size,max_size FROM v$sga_dynamic_components;
--��ѯ��ΪPGA�����˶����ڴ�
SELECT NAME,VALUE FROM v$pgastat WHERE NAME IN('maximum PGA allocated','total PGA allocated');






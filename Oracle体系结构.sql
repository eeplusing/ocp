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

--��ѯoracleʵ�������еĽ���
SELECT * FROM v$bgprocess v WHERE paddr <> '00' ORDER BY name;
/*
000000006AB4DDB8  1 AQPC  AQ Process Coord  0   0
000000006AB47A58  1 ARC0  Archival Process 0  0   0
000000006AB49B78  1 ARC1  Archival Process 1  0   0
000000006AB4AC08  1 ARC2  Archival Process 2  0   0
000000006AB4BC98  1 ARC3  Archival Process 3  0   0
000000006AB5D628  1 CJQ0  Job Queue Coordinator 0   0
000000006AB32F18  1 CKPT  checkpoint  0   0
000000006AB21588  1 CLMN  process cleanup 0   0
000000006AB2BB28  1 DBRM  DataBase Resource Manager 0   0
000000006AB30DF8  1 DBW0  db writer process 0 0   0
000000006AB2FD68  1 DIA0  diagnosibility process 0  0   0
000000006AB26858  2 DIAG  diagnosibility process  0   0
000000006AB3D4B8  1 FENC  IOServer fence monitor  448   0
000000006AB24738  1 GEN0  generic0  0   0
000000006AB278E8  1 GEN1  generic1  0   0
000000006AB33FA8  1 LG00    0 SLAVE 0
000000006AB360C8  1 LG01    0 SLAVE 0
000000006AB31E88  1 LGWR  Redo etc. 0   0
000000006AB3A308  1 LREG  Listener Registration 0   0
000000006AB257C8  1 MMAN  Memory Manager  0   0
000000006AB3D4B8  2 MMNL  Manageability Monitor Process 2 0   0
000000006AB3E548  1 MMON  Manageability Monitor Process 0   0
000000006AB29A08  1 OFSD  Oracle File Server BG 0   0
000000006AB2ECD8  1 PMAN  process manager 0   0
000000006AB204F8  1 PMON  process cleanup 0   0
000000006AB22618  1 PSP0  process spawner 0 0   0
000000006AB3C428  1 PXMN  PX Monitor  0   0
000000006AB5F748  1 Q002    0 SLAVE 0
000000006AB607D8  1 Q003    0 SLAVE 0
000000006AB43818  4 QM02    0 SLAVE 0
000000006AB381E8  1 RECO  distributed recovery  0   0
000000006AB28978  1 SCMN    0 SLAVE 0
000000006AB2AA98  1 SCMN    0 SLAVE 0
000000006AB37158  1 SMCO  Space Manager Process 0   0
000000006AB35038  1 SMON  System Monitor Process  0   0
000000006AB2DC48  1 SVCB  services background monitor 0   0
000000006AB416F8  1 TMON  Transport Monitor 0   0
000000006AB469C8  1 TT00    0 SLAVE 0
000000006AB48AE8  1 TT01    0 SLAVE 0
000000006AB4CD28  1 TT02    0 SLAVE 0
000000006AB2CBB8  1 VKRM  Virtual sKeduler for Resource Manager 0   0
000000006AB236A8  1 VKTM  Virtual Keeper of TiMe process  0   0
000000006AB3B398  1 W001    0 SLAVE 0
000000006AB5E6B8  28  W004    0 SLAVE 0
000000006AB4EE48  106 W005    0 SLAVE 0
000000006AB61868  30  W006    0 SLAVE 0
000000006AB64A18  5 W007    0 SLAVE 0
 */

SELECT program, paddr FROM v$session ORDER BY program;
SELECT program, addr FROM v$process ORDER BY program;

--ͨ��ϵͳ����鿴���̱仯
--#ps -ef|grep LOCAL|wc -l

--��Ĭ�ϱ�ռ��д�����
CREATE TABLE tab34(c1 VARCHAR2(10)) SEGMENT creation IMMEDIATE;
--��ѯ�����ڵı�ռ䡢�����С���������ڵ��ļ���š����俪ʼ���ļ���
SELECT tablespace_name, bytes, file_id, block_id, extent_id, ex.* FROM dba_extents ex WHERE owner='SYSTEM' AND segment_name='TAB34';

--���������ļ���
SELECT NAME FROM v$datafile WHERE FILE#=&file_id;
--������������ڵ��ļ��е�λ��
SELECT block_size * &block_id FROM Dba_Tablespaces WHERE tablespace_name='&tablesapce_name';
 


















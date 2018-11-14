--��system�û���¼db
--��ѯ���ݿ�ʹ�ó����λ��ǻع���
SELECT v.VALUE, v.* FROM v$parameter v WHERE v.NAME='undo_management';

--������value!=AUTO ���������������ʵ��
ALTER SYSTEM SET undo_management=AUTO SCOPE=SPFILE;

--��ѯ�Ѿ������ĳ�����ռ估����ʹ�õ����ĸ�������ռ�
SELECT tablespace_name FROM dba_tablespaces WHERE CONTENTS='UNDO';
SELECT VALUE FROM v$parameter WHERE NAME='undo_tablespace';

--��ѯ����ʹ�õĳ����μ����С
SELECT tablespace_name, segment_name, segment_id, status FROM dba_rollback_segs;
SELECT usn, rssize FROM v$rollstat;

--�鿴���ݽ��������ĳ���������
ALTER SESSION SET nls_date_format='dd-mm-yy hh24:mi:ss';

SELECT begin_time, end_time, (
       undoblks * (SELECT VALUE FROM v$parameter WHERE NAME='db_block_size')
) undo_bytes FROM v$undostat;








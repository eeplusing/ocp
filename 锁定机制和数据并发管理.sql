--�������ƺ����ݲ�������
--��������
  --�м�������������һ�з�ֹ�����Ự�Ը��и��£��������Ự���Խ��ж�ȡ��������ָ����¼�������������ĵ�һ���Ự��õ����������
              --��������Ըü�¼����д���ʵĻỰ����ȴ����Ըü�¼���ж����ʵĻỰ�����������У��������漰�������ݵ�ʹ�ã�
              --�Ӷ���֤���Ự���ῴ���κ�δ���ύ�ı������
  --����������ִ��DDL����ʱ����Ҫʹ���漰�����ϵ���������ֻ�������ָ���������DML��������������ϵ��������ͱ��ϵĹ������������
              --���ܻ��ִ��DDL�������������
--��������
  --�м������������������ڱ��������壬��Ϊ����һ�е�ΨһĿ�ľ��ǻ���޸ĸ����������������
  --�����������ڱ��Ϸ��ù�������Ŀ���Ƿ�ֹ�����Ự��ȡ�ñ�����������������Ѿ����ڹ�������������޷��ٻ������������
    
--����DML������ٶ���Ҫ����������Ӱ���¼�ϵ�����������Ӱ���¼���ڱ��ϵĹ��������������ܹ���ֹ�����Ự��Ԥָ�����У�
--���������Է��������Ựʹ��DDL�޸ı�Ķ��塣 


--�Ŷӻ���
--���Ŷ�
SELECT * FROM tablename FOR UPDATE NO WAIT; 
--�Ŷ�һ��ʱ��(200��λ��)
SELECT * FROM tablename FOR UPDATE WAIT<200>;
--�Ŷӣ�ָ����ȡ����
SELECT * FROM tablename WHERE tid=primarykeyvalue FOR UPDATE;
--�Ŷӣ���ȡδ�������Ự��������
SELECT * FROM TABLE WHERE tid > primarykeyvalue FOR UPDATE SKIP LOCKED;

--����������� ��Ҫʹ��ӵ��v$session��ͼȨ�޵��û�
SELECT waiter.username "Blocked session", waiter.SID, blocker.username "Blocking session", 
blocker.sid, blocker.SERIAL# FROM v$session waiter JOIN v$session blocker ON(waiter.BLOCKING_SESSION=blocker.sid);

--��ѯ��־trace��Ϣ
SELECT * FROM v$diag_info WHERE NAME='Diag Trace';

--less alert_orcl1.log
--2018-11-22T23:24:40.424369+08:00
--ORA-00060: Deadlock detected. See Note 60.1 at My Oracle Support for Troubleshooting ORA-60 Errors. More info in file /u01/app/oracle/diag/rdbms/orcl1/orcl1/trace/orcl1_s000_3771.trc.
--less /u01/app/oracle/diag/rdbms/orcl1/orcl1/trace/orcl1_s000_3771.trc
/*
2018-11-22 23:24:39.197*:ksq.c@12954:ksqdld_hdr_dump(): 
DEADLOCK DETECTED ( ORA-00060 )
See Note 60.1 at My Oracle Support for Troubleshooting ORA-60 Errors

[Transaction Deadlock]
 
The following deadlock is not an ORACLE error. It is a
deadlock due to user error in the design of an application
or from issuing incorrect ad-hoc SQL. The following
information may aid in determining the deadlock:
 
Deadlock graph:
                                          ------------Blocker(s)-----------  ------------Waiter(s)------------
Resource Name                             process session holds waits serial  process session holds waits serial
TX-0006001E-000003E9-00000000-00000000         33     142     X        31924      26     147           X   4162
TX-00020015-000003E5-00000000-00000000         26     147     X         4162      33     142           X  31924
*/

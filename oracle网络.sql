--oracle��·
--����oracle net�������� 
--��ȷ�Ĳ���
C:\Users\admin>tnsping orcl1
TNS Ping Utility for 64-bit Windows: Version 11.2.0.1.0 - Production on 31-12��-2018 11:21:47
Copyright (c) 1997, 2010, Oracle.  All rights reserved.
��ʹ�õĲ����ļ�:
C:\app\admin\product\11.2.0\client_1\network\admin\sqlnet.ora
��ʹ�� TNSNAMES ����������������
�������� (DESCRIPTION = (ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.1.103)(PORT = 1521))) (CONNECT_DATA = (SERVICE_NAME = orcl1.eplusing.com)))
OK (20 ����)

--����Ĳ���
C:\Users\admin>tnsping orcl
TNS Ping Utility for 64-bit Windows: Version 11.2.0.1.0 - Production on 31-12��-2018 11:22:16
Copyright (c) 1997, 2010, Oracle.  All rights reserved.
��ʹ�õĲ����ļ�:
C:\app\admin\product\11.2.0\client_1\network\admin\sqlnet.ora
TNS-03505: �޷���������

--�������ݿ�����
SQL> create database link dblink connect to system identified by Oracle123 using 'orcl1.eplusing.com';
Database link created






--��ѯ��������
SELECT t.object_type, COUNT(t.object_type) FROM dba_objects t GROUP BY t.object_type; 

--12c����
SELECT t.object_type, COUNT(t.object_type) FROM cdb_objects t GROUP BY t.object_type; 

--��ǰģʽ�ж�Ӧ�������͵Ķ�������
SELECT object_type, COUNT(object_type) FROM user_objects GROUP BY object_type;
--��ǰ�û��з���Ȩ�޵Ķ�������
SELECT object_type, COUNT(object_type) FROM all_objects GROUP BY object_type;
--ȷ��˭ӵ�е�ǰģʽ�ܹ������Ķ���
SELECT DISTINCT owner FROM all_objects;

describe employees;


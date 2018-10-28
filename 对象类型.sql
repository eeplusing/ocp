
--查询对象类型
SELECT t.object_type, COUNT(t.object_type) FROM dba_objects t GROUP BY t.object_type; 

--12c新增
SELECT t.object_type, COUNT(t.object_type) FROM cdb_objects t GROUP BY t.object_type; 

--当前模式中对应各种类型的对象数量
SELECT object_type, COUNT(object_type) FROM user_objects GROUP BY object_type;
--当前用户有访问权限的对象数量
SELECT object_type, COUNT(object_type) FROM all_objects GROUP BY object_type;
--确定谁拥有当前模式能够看到的对象
SELECT DISTINCT owner FROM all_objects;

describe employees;


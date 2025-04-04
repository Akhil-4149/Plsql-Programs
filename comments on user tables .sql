select * from user_tables;
select * from user_indexes;

select * from dba_procedures where object_name like '%AK%'
SELECT * FROM DBA_TRIGGERS

SELECT OBJECT_NAME, OBJECT_TYPE FROM DBA_OBJECTS WHERE 
OBJECT_TYPE IN ('TABLE') ORDER BY ;

SELECT * FROM DBA_OBJECTS
COMMENT ON TABLE EMP IS 'This akhilesh employee'
COMMENT ON COLUMN emp.emp_id IS 'This column stores user unique addresses.';

SELECT * FROM USER_TAB_COMMENTS WHERE TABLE_NAME = 'YOUR_TABLE_NAME';


SELECT * FROM DBA_TAB_COMMENTS WHERE TABLE_NAME = 'EMP';
SELECT * FROM USER_COL_COMMENTS WHERE TABLE_NAME = 'EMP';

SELECT * FROM dba_tables  WHERE TABLE_NAME ='EMP' ;

SELECT * FROM user_objects WHERE OBJECT_TYPE ='TABLE' AND OBJECT_NAME ='EMP';

SELECT * FROM user_clu_columns WHERE TABLE_NAME = 'EMP'



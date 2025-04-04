CREATE OR REPLACE PROCEDURE pract1 (eid IN emp.emp_id%TYPE)
AS
    ename emp1.emp1_name%TYPE;
BEGIN
    -- Use COUNT(*) to check if the record exists before running SELECT

SELECT /*+ INDEX(emp1 emp1_id_idx) */ emp1_name 
INTO ename FROM emp1 WHERE emp1_id = eid;


    -- Display output
    DBMS_OUTPUT.PUT_LINE('Name is: ' || ename);

EXCEPTION
    -- Handle NO_DATA_FOUND Exception
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('Eid does not exist.');

    -- Handle TOO_MANY_ROWS Exception in case of duplicate records
--    WHEN TOO_MANY_ROWS THEN 
--        DBMS_OUTPUT.PUT_LINE('Error: More than one record found for the given Eid.');

    -- Handle Other Unexpected Errors
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Unexpected Error: ' || SQLERRM);
END pract1;
/


exec pract1(101)
------------------------------------------------------------------------
create index  emp1_id_idx on emp1 (emp1_id);

desc emp1;

SELECT column_name, data_type, data_length, nullable
FROM user_tab_columns
WHERE table_name = 'EMP1';

SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE table_name = 'EMP1';

SELECT index_name, column_name
FROM user_ind_columns
WHERE table_name = 'EMP1';






exec pract1 (101)





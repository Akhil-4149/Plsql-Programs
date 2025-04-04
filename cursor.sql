--CURSOR NORMAL LOOP--- orow by row 

SET SERVEROUTPUT ON;

DECLARE
    CURSOR c1 (
        eid IN NUMBER
    ) IS
    SELECT
        emp_name,
        emp_salary
    FROM
        emp
    WHERE
        emp_id = eid;

    ename   emp.emp_name%TYPE;
    esalary emp.emp_salary%TYPE;
    eid     NUMBER := 104; -- Example parameter (min salary)
BEGIN
    OPEN c1(eid); -- Passing the parameter to the cursor
    LOOP
        FETCH c1 INTO
            ename,
            esalary;
        EXIT WHEN c1%notfound;
        dbms_output.put_line('NAME IS - '
                             || ename
                             || ' SALARY IS - '
                             || esalary);
    END LOOP;

    CLOSE c1;
END;
/
SET SERVEROUTPUT ON;



---------------------------------------
declare 
cursor c1  is select emp_name,emp_salary from emp;
ename emp.emp_name%type;
esAlary emp.emp_salary%type;

BEGIN
  OPEN c1;
  LOOP
    FETCH c1 INTO ename, esalary;
    EXIT WHEN c1%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('NAME IS -' || ename || ' SALARY IS -' || esalary);
  END LOOP;
  CLOSE c1;
END;

/
--------------------------------------------------------------
---FOR LOOP

DECLARE 
CURSOR C1 IS SELECT * FROM EMP;
R EMP%ROWTYPE;
BEGIN
OPEN C1;
LOOP
FETCH c1 INTO R;
EXIT WHEN C1%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('EMP_NAME IS ' || R.EMP_NAME);
END LOOP;
CLOSE C1;
END;


------------------------------------------------------------

---FOR LOOP

DECLARE 

CURSOR C1 IS SELECT * FROM EMP;

BEGIN
FOR I IN C1 
LOOP
DBMS_OUTPUT.PUT_LINE('EMP_NAME IS ' || I.EMP_NAME);
END LOOP;
END;


-------------------------------------------------------------

DECLARE 
CURSOR C1 IS SELECT * FROM EMP;

BEGIN
FOR I IN C1 
LOOP
UPDATE EMP SET EMP_SALARY=EMP_SALARY+1000;
DBMS_OUTPUT.PUT_LINE('EMP_NAME IS ' || I.EMP_SALARY);
END LOOP;
END;

--SELECT * FROM EMPPP

------------------------------implicit cursor --------------------

DECLARE 

V EMP.emp_id%TYPE;

BEGIN
V :=&emp_id;
DELETE FROM EMP WHERE EMP_ID=V;

IF SQL%FOUND THEN
DBMS_OUTPUT.PUT_LINE ('RECORD IS DELETED');
ELSE 
DBMS_OUTPUT.PUT_LINE ('NO SUCH EMP');
END IF ;

DBMS_OUTPUT.PUT_LINE ('Row Count: ' || SQL%ROWCOUNT);
--COMMIT;
END;


SELECT * FROM EMP;


--------------------------------------------------------------------------------
--PARMITERIZED CURSOR 

DECLARE
    -- Declare a parameterized cursor
    CURSOR emp_cursor (EMP_dept_id1 NUMBER) IS 
        SELECT emp_id, EMP_name, EMP_salary 
        FROM emp 
        WHERE EMP_dept_id = EMP_dept_id1;
    
    -- Declare a variable to hold the cursor row
    v_emp emp_cursor%ROWTYPE;

BEGIN
    -- Open the cursor with department ID 10
    OPEN emp_cursor(9);
    
    LOOP
        FETCH emp_cursor INTO v_emp;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        -- Print employee details
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_emp.emp_id || ', Name: ' || v_emp.EMP_name || ', Salary: ' || v_emp.EMP_salary);
    END LOOP;
    
    -- Close the cursor
    CLOSE emp_cursor;
END;
/


--------------------------------------------------------------------------------

---REF CURSOR THERE IS 2 TYPES
--WEAK REF CURSOR 
--STRONG CURSOR



DECLARE
    -- Declare a parameterized cursor
    CURSOR emp_cursor (EMP_dept_id1 NUMBER) IS 
        SELECT emp_id, EMP_name, EMP_salary 
        FROM emp 
        WHERE EMP_dept_id = EMP_dept_id1;
    
    -- Declare a variable to hold the cursor row
    v_emp emp_cursor%ROWTYPE;

BEGIN
    -- Open the cursor with department ID 10
    
     DBMS_OUTPUT.PUT_LINE('CURSOR 1');
    OPEN emp_cursor(9);
    
    LOOP
        FETCH emp_cursor INTO v_emp;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        -- Print employee details
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_emp.emp_id || ', Name: ' || v_emp.EMP_name || ', Salary: ' || v_emp.EMP_salary);
    END LOOP;
    
    -- Close the cursor
    CLOSE emp_cursor;


DBMS_OUTPUT.PUT_LINE('CURSOR 2');
    OPEN emp_cursor(8);
    
    LOOP
        FETCH emp_cursor INTO v_emp;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        -- Print employee details
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_emp.emp_id || ', Name: ' || v_emp.EMP_name || ', Salary: ' || v_emp.EMP_salary);
    END LOOP;
    
    -- Close the cursor
    CLOSE emp_cursor;

END;
/


SELECT * FROM EMP;
SELECT * FROM depart;

-----------------------------------------------------------

DECLARE 
TYPE  REF_CURSOR IS REF CURSOR ;
C1 REF_CURSOR;
ENAME EMP.EMP_NAME%TYPE;

ESAL EMP.EMP_SALARY%TYPE;

BEGIN

DBMS_OUTPUT.PUT_LINE('-----tHIS IS CURSOR 1-----');
OPEN  C1 FOR SELECT EMP_NAME,EMP_SALARY FROM EMP;
LOOP
FETCH C1 INTO ENAME,ESAL;
EXIT WHEN C1%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('EMPLOYEE_NAME-'||ENAME || ' '|| 'EMPLYOEE_SALARY-'||ESAL);
END LOOP;
CLOSE c1; 

DBMS_OUTPUT.PUT_LINE('-----tHIS IS CURSOR 2-----');
OPEN  C1 FOR SELECT EMP_NAME,EMP_SALARY FROM EMP;
LOOP
FETCH C1 INTO ENAME,ESAL;
EXIT WHEN C1%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('EMPLOYEE_NAME-'||ENAME || ' '|| 'EMPLYOEE_SALARY-'||ESAL);
END LOOP;
CLOSE c1; 

END;


----------------------------------REF CURSOR USE IN FUNCTION-----------------------
-- Declare the function with a REF CURSOR as the return type
CREATE OR REPLACE FUNCTION get_employee_details
  RETURN SYS_REFCURSOR
IS
  -- Declare a variable to hold the REF CURSOR
  emp_cursor SYS_REFCURSOR;
BEGIN
  -- Open the cursor with a query to fetch employee details
  OPEN emp_cursor FOR
    SELECT employee_id, first_name, last_name, department_id
    FROM employees
    WHERE department_id = 10;  -- Example filter for department_id = 10

  -- Return the REF CURSOR
  RETURN emp_cursor;
END get_employee_details;
/


----------------------REF CUSOR IN PROCEDURE--------------------------------------------


-- Declare the procedure with a REF CURSOR as an OUT parameter
CREATE OR REPLACE PROCEDURE get_employee_details
  (p_department_id IN NUMBER, -- Input parameter for filtering by department
   p_emp_cursor OUT SYS_REFCURSOR) -- Output parameter to return the REF CURSOR
IS
BEGIN
  -- Open the cursor with a query to fetch employee details based on department_id
  OPEN p_emp_cursor FOR
    SELECT employee_id, first_name, last_name, department_id
    FROM employees
    WHERE department_id = p_department_id;
END get_employee_details;
/



----------------EXECUTION PART FOR PROCEDURE ------------------------------------

DECLARE
  -- Declare a variable to hold the REF CURSOR
  emp_ref_cursor SYS_REFCURSOR;
  -- Declare variables to hold the data fetched from the cursor
  v_employee_id employees.employee_id%TYPE;
  v_first_name employees.first_name%TYPE;
  v_last_name employees.last_name%TYPE;
  v_department_id employees.department_id%TYPE;
BEGIN
  -- Call the procedure to get the REF CURSOR for department_id = 10
  get_employee_details(10, emp_ref_cursor);

  -- Loop through the result set
  LOOP
    FETCH emp_ref_cursor INTO v_employee_id, v_first_name, v_last_name, v_department_id;
    EXIT WHEN emp_ref_cursor%NOTFOUND;
    
    -- Output the employee details
    DBMS_OUTPUT.PUT_LINE('ID: ' || v_employee_id || ', Name: ' || v_first_name || ' ' || v_last_name || ', Dept: ' || v_department_id);
  END LOOP;

  -- Close the cursor
  CLOSE emp_ref_cursor;
END;
/



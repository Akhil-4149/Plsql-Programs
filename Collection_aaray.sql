
/*
1?? Associative Array (Index-by Table)
? Unbounded (can grow dynamically)
? Indexed by PLS_INTEGER or VARCHAR2
? Stored in PL/SQL memory (not in the database)
*/


DECLARE
    TYPE emp_array IS TABLE OF VARCHAR2(50) INDEX BY PLS_INTEGER; 
    emp_names emp_array;
BEGIN
    -- Assign values to the collection
    emp_names(1) := 'John';
    emp_names(2) := 'Alice';
    emp_names(3) := 'Bob';

    -- Print values
    DBMS_OUTPUT.PUT_LINE(emp_names(1)); -- Output: John
END;
/


/*
2?? VARRAY (Variable-Size Array)
? Fixed-size collection (Max size defined at creation)
? Stored in database (optional)

? Declaration and Usage:
*/


DECLARE
    TYPE emp_varray IS VARRAY(5) OF VARCHAR2(50); 
    emp_names emp_varray := emp_varray();
BEGIN
    -- Assign values
    emp_names.EXTEND(3); 
    emp_names(1) := 'John';
    emp_names(2) := 'Alice';
    emp_names(3) := 'Bob';

    -- Print values
    DBMS_OUTPUT.PUT_LINE(emp_names(2)); -- Output: Alice
END;
/


/*
3?? Nested Table
? Can grow dynamically (Unlike VARRAY, No fixed size)
? Stored in the database as a column type

? Declaration and Usage:
*/


DECLARE
    TYPE emp_table IS TABLE OF VARCHAR2(50); 
    emp_names emp_table := emp_table();
BEGIN
    -- Assign values
    emp_names.EXTEND(3); 
    emp_names(1) := 'John';
    emp_names(2) := 'Alice';
    emp_names(3) := 'Bob';

    -- Print values
    DBMS_OUTPUT.PUT_LINE(emp_names(3)); -- Output: Bob
END;
/


/*

Feature	   Associative Array	         VARRAY  	Nested Table
Size	    Dynamic	                      Fixed	         Dynamic
Indexing	PLS_INTEGER / VARCHAR2	    Sequential	     Sequential
Stored in DB?	  No	                    Yes(optional)	 Yes
Expandable?	     Yes	                No (Fixed Size)	  Yes
Best for	Lookup tables	          Small fixed-size         lists	Large datasets

*/



CREATE OR REPLACE PROCEDURE insert_and_return_employees (
    emp_list OUT SYS.ODCIVARCHAR2LIST  -- Output parameter (Collection)
) 
IS
    -- Define a Nested Table Type
    TYPE emp_table IS TABLE OF VARCHAR2(50);
    emp_names emp_table := emp_table('John', 'Alice', 'Bob');  -- Collection initialization
BEGIN
    -- Insert data into employees table
    FOR i IN 1..emp_names.COUNT LOOP
        INSERT INTO employees (emp_id, emp_name) VALUES (i, emp_names(i));
    END LOOP;

    -- Return the collection
    emp_list := emp_names;

    -- Commit the changes
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Employees Inserted and Returned.');
END;
/


























DECLARE
    v_emp employees%ROWTYPE;  -- Declares a variable with the structure of "employees" table
BEGIN
    SELECT * INTO v_emp FROM employees WHERE emp_id = 101;
    DBMS_OUTPUT.PUT_LINE('ID: ' || v_emp.emp_id || ', Name: ' || v_emp.emp_name);
END;
/

-----------------------------------------------------------------------------------------------


DECLARE
    -- Step 1: Define a collection type that holds entire rows
    TYPE emp_table_type IS TABLE OF employees%ROWTYPE;
    
    -- Step 2: Declare a collection variable
    emp_list emp_table_type;
BEGIN
    -- Step 3: Fetch all employees of a department into the collection using BULK COLLECT
    SELECT * BULK COLLECT INTO emp_list FROM employees WHERE department_id = 10;

    -- Step 4: Loop through the collection and print employee details
    FOR i IN emp_list.FIRST .. emp_list.LAST LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || emp_list(i).emp_id || ', Name: ' || emp_list(i).emp_name);
    END LOOP;
END;
/




-----------------------------------------------------------------------------------------------

DECLARE
    -- Step 1: Define a VARRAY type to store a fixed number of employee rows
    TYPE emp_varray_type IS VARRAY(5) OF employees%ROWTYPE;

    -- Step 2: Declare a VARRAY variable
    emp_list emp_varray_type;
BEGIN
    -- Step 3: Fetch up to 5 employees from department 10 into the VARRAY
    SELECT * BULK COLLECT INTO emp_list FROM employees WHERE department_id = 10 AND ROWNUM <= 5;

    -- Step 4: Loop through the VARRAY and print employee details
    FOR i IN 1 .. emp_list.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || emp_list(i).emp_id || ', Name: ' || emp_list(i).emp_name);
    END LOOP;
END;
/

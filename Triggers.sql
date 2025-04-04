CREATE OR REPLACE TRIGGER trigger_name
{ BEFORE | AFTER | INSTEAD OF } 
{ INSERT | UPDATE | DELETE }
ON table_name
[ FOR EACH ROW ]
BEGIN
  -- Trigger logic here (PL/SQL code)
END;


-----------------------------------------------------------------

------------------system level trigger ---------------


CREATE OR REPLACE TRIGGER after_logon_trigger
AFTER LOGON ON DATABASE
DECLARE
BEGIN
   INSERT INTO login_audit (user_name, logon_time)
   VALUES (USER, SYSDATE);
END;



CREATE OR REPLACE TRIGGER after_db_open_trigger
AFTER DATABASE OPEN
BEGIN
   DBMS_OUTPUT.PUT_LINE('Database has been opened!');
   -- Additional tasks like setting up specific configurations or initializing settings can be done here.
END;




--------------------------------------------------------------------------

--------user db object triggers

CREATE OR REPLACE TRIGGER before_insert_emp_trigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
   -- Automatically assign a default department if no department is specified
   IF :NEW.department_id IS NULL THEN
      :NEW.department_id := 100; -- Assign default department
   END IF;
END;

-----------------------------------------------------------
CREATE OR REPLACE TRIGGER after_update_emp_trigger
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
   -- Log the update action into an audit table
   INSERT INTO employee_audit (action, emp_id, old_salary, new_salary, action_time)
   VALUES ('UPDATE', :OLD.emp_id, :OLD.salary, :NEW.salary, SYSDATE);
END;


-----------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER after_delete_emp_trigger
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
   -- Log the deletion in an audit table
   INSERT INTO employee_audit (action, emp_id, emp_name, action_time)
   VALUES ('DELETE', :OLD.emp_id, :OLD.emp_name, SYSDATE);
   
   -- Optionally, remove related data in other tables (e.g., department_employees)
   DELETE FROM department_employees WHERE emp_id = :OLD.emp_id;
END;

--------------------------------------------------------------------------------


CREATE OR REPLACE TRIGGER before_salary_update_trigger
BEFORE UPDATE OF salary ON employees
FOR EACH ROW
BEGIN
   IF :NEW.salary < :OLD.salary THEN
      RAISE_APPLICATION_ERROR(-20001, 'Salary cannot be decreased.');
   END IF;
END;

--------------------------------------------------------------------------------------------------

/* Compound Triggers
In some cases, you may need to create a compound trigger, 
which allows you to combine different actions for different events(like BEFORE and AFTER) 
into one trigger. This is helpful for managing complex logic and preventing issues like mutating table errors.

*/

CREATE OR REPLACE TRIGGER compound_trigger
FOR INSERT OR UPDATE ON employees
COMPOUND TRIGGER
   -- Declaration section
   v_salary_change NUMBER;

   -- BEFORE INSERT
   BEFORE INSERT ON employees
   FOR EACH ROW
   BEGIN
      :NEW.creation_date := SYSDATE;  -- Set creation date for new employees
   END BEFORE INSERT;

   -- BEFORE UPDATE
   BEFORE UPDATE ON employees
   FOR EACH ROW
   BEGIN
      v_salary_change := :NEW.salary - :OLD.salary;
      IF v_salary_change > 0 THEN
         DBMS_OUTPUT.PUT_LINE('Salary increased by ' || v_salary_change);
      END IF;
   END BEFORE UPDATE;

   -- AFTER INSERT
   AFTER INSERT ON employees
   FOR EACH ROW
   BEGIN
      DBMS_OUTPUT.PUT_LINE('New employee added: ' || :NEW.emp_name);
   END AFTER INSERT;

END compound_trigger;



/*
INSTEAD OF Triggers
An INSTEAD OF trigger is typically used with views. This type of trigger 
defines the actions that should occur instead of performing the default DML 
operation (INSERT, UPDATE, DELETE). Instead of directly 
modifying the underlying table, you can use INSTEAD OF triggers to control how the operation affects the data.
*/




CREATE OR REPLACE TRIGGER instead_of_insert_trigger
INSTEAD OF INSERT ON employee_view
FOR EACH ROW
BEGIN
   -- Insert logic for the base table corresponding to the view
   INSERT INTO employees (emp_id, emp_name, salary)
   VALUES (:NEW.emp_id, :NEW.emp_name, :NEW.salary);
END;


/*
Global or Session-Level Triggers
*/

CREATE OR REPLACE TRIGGER before_session_start
BEFORE SESSION ON DATABASE
BEGIN
   DBMS_OUTPUT.PUT_LINE('A session is about to start.');
END;


------------------------------------------------------------
---Each Row triggers--

CREATE OR REPLACE TRIGGER emp_audit_trigger
AFTER INSERT OR UPDATE OR DELETE
ON employees
FOR EACH ROW
BEGIN
   IF INSERTING THEN
      INSERT INTO employee_audit (action, emp_id, emp_name, action_time)
      VALUES ('INSERT', :NEW.emp_id, :NEW.emp_name, SYSDATE);
   ELSIF UPDATING THEN
      INSERT INTO employee_audit (action, emp_id, emp_name, action_time)
      VALUES ('UPDATE', :NEW.emp_id, :NEW.emp_name, SYSDATE);
   ELSIF DELETING THEN
      INSERT INTO employee_audit (action, emp_id, emp_name, action_time)
      VALUES ('DELETE', :OLD.emp_id, :OLD.emp_name, SYSDATE);
   END IF;
END;



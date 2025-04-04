
----------------PACKAGE SPECIFICATION-----------------
CREATE OR REPLACE PACKAGE AK_PKG 
AS

PROCEDURE AK1(EID NUMBER );

FUNCTION AK2(EID NUMBER ) RETURN NUMBER ;

END AK_PKG;


-------------------PACKAGE BODY--------------------


CREATE OR REPLACE PACKAGE BODY AK_PKG
AS


PROCEDURE AK1(EID NUMBER )
AS
BEGIN
NULL;
END;

FUNCTION AK2(EID NUMBER ) RETURN NUMBER 
AS

BEGIN

RETURN NULL;

END ;

END AK_PKG;



------EXECUTION PART--

BEGIN
  emp_pkg.get_employee_details(101);
  DBMS_OUTPUT.PUT_LINE('Salary: ' || emp_pkg.get_employee_salary(101));
END;
/

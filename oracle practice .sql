CREATE TABLE EMP (
    EMP_ID NUMBER PRIMARY KEY,
    EMP_NAME VARCHAR2(50),
    EMP_SALARY NUMBER(10,2),
    EMP_DEPT_ID NUMBER,
    CONSTRAINT FK_DEPART FOREIGN KEY (EMP_DEPT_ID) REFERENCES DEPART(DEPT_ID)
);


INSERT INTO EMP VALUES (101, 'John Doe', 60000, 1);
INSERT INTO EMP VALUES (102, 'Jane Smith', 75000, 2);
INSERT INTO EMP VALUES (103, 'Alice Johnson', 50000, 3);
INSERT INTO EMP VALUES (104, 'Michael Brown', 82000, 4);
INSERT INTO EMP VALUES (105, 'Chris Evans', 67000, 5);
INSERT INTO EMP VALUES (106, 'Sophia Wilson', 55000, 6);
INSERT INTO EMP VALUES (107, 'David Lee', 90000, 7);
INSERT INTO EMP VALUES (108, 'Emma Watson', 72000, 8);
INSERT INTO EMP VALUES (109, 'Robert Downey', 95000, 9);
INSERT INTO EMP VALUES (110, 'Scarlett Johansson', 88000, 10);

COMMIT;

---------------------------------------------------

select * from EMP;
select * from EMP;
select * from EMP;
select * from depart;

select * from user_tables ;

select /*+full(e)*/* from user_tables e ;

select /*+first_row(20)*/* from user_tables e ;

select /*ordered*/* from user_tables e ;

drop table akh_temp;
insert into akh_temp
select * from user_table 


drop table akh_temp;
insert /*+append*/ into akh_temp
select * from user_table 

-------------------------------------------------------------------


---function practice 

create or replace function ak_fun(a int , b int)
return int
is
c int ;
begin
c:=a+b;
return c;
end ak_fun;
/

select ak_fun (10,3) from dual

-------------------------------------------------------------------------


create or replace function ak_fun(a int , b int)
return int
is
c int ;
begin
c:=a+b;
return c;
end ak_fun;
/

--select ak_fun (10,3) from dual

create or Replace PROCEDURE ak_pro 
as

begin
DBMS_OUTPUT.PUT_LINE('Hello Oracle user');
end;
/

--set SERVEROUTPUT on 
exec ak_pro


---------------------------------------------------------------


    CREATE OR REPLACE PROCEDURE ak_fun_proc(a INT, b INT)
    IS
        c INT;  -- Local variable to store the result
    BEGIN
        c := a + b;  -- Add the two input values
        DBMS_OUTPUT.PUT_LINE('The result is: ' || c);  -- Output the result
    END ak_fun_proc;
    /


BEGIN
    ak_fun_proc(10, 20);
END;
/


---------------------------------------------------------

------DYNAMIC PROCDEURE STRUCTURE---DBMS_ASSERT.ENQUOTE_NAME SQL INJECTION

CREATE OR REPLACE PROCEDURE ak_pro (
    TABLE_NAME IN VARCHAR2, 
    COL_NAME IN VARCHAR2
)
AS
    QUERY_LINE VARCHAR2(500);
    COUNT_ROW NUMBER;
BEGIN
    -- Construct the dynamic SQL query properly
    QUERY_LINE := 'SELECT COUNT(*) FROM ' || DBMS_ASSERT.ENQUOTE_NAME(TABLE_NAME) || 
                  ' GROUP BY ' || DBMS_ASSERT.ENQUOTE_NAME(COL_NAME);

    -- Execute the dynamic SQL
    EXECUTE IMMEDIATE QUERY_LINE INTO COUNT_ROW;

    -- Display output
    DBMS_OUTPUT.PUT_LINE('Hello Oracle user');
    DBMS_OUTPUT.PUT_LINE('Count: ' || COUNT_ROW);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found for given table and column.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
---------------------------------------------------------------------


CREATE OR REPLACE PROCEDURE ak_pro (
    TABLE_NAME IN VARCHAR2, 
    COL_NAME IN VARCHAR2
)
AS
    QUERY_LINE VARCHAR2(500);
    COUNT_ROW NUMBER;
BEGIN
    -- Unsafe dynamic SQL (no validation)
    QUERY_LINE := 'SELECT COUNT(*) FROM ' || TABLE_NAME || ' GROUP BY ' || COL_NAME;
    
    EXECUTE IMMEDIATE QUERY_LINE INTO COUNT_ROW;
    
    DBMS_OUTPUT.PUT_LINE('Count: ' || COUNT_ROW);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/



select * from emp

--AGGREGATE
select emp_name,sum(emp_salary) over (order by emp_id) as ne_sal  from emp;
--RANKING FUNCTION
select emp_name,EMP_SALARY,
ROW_NUMBER() over (order by EMP_SALARY DESC) as new_sal  
from emp;

select emp_name,EMP_SALARY,
PERCENT_RANK() over (order by EMP_SALARY DESC) as new_sal  
from emp;

--ANLYTICAL FUNCTION
 
select emp_name,EMP_SALARY,
LEAD(EMP_SALARY,0,0) over (PARTITION BY EMP_NAME order by EMP_SALARY DESC) as new_sal  
from emp;

select emp_name,EMP_SALARY,
LAG(EMP_SALARY,0,0) over (PARTITION BY EMP_NAME order by EMP_SALARY DESC) as new_sal  
from emp;


--FOR PIVOT
--CREATE TABLE sales_data (
--    Sales_ID NUMBER PRIMARY KEY,
--    Product VARCHAR2(50),
--    Year NUMBER,
--    Sales_Amount NUMBER
--);
--
--INSERT INTO sales_data VALUES (1, 'Laptop', 2022, 50000);
--INSERT INTO sales_data VALUES (2, 'Mobile', 2022, 30000);
--INSERT INTO sales_data VALUES (3, 'Tablet', 2022, 20000);
--INSERT INTO sales_data VALUES (4, 'Laptop', 2023, 60000);
--INSERT INTO sales_data VALUES (5, 'Mobile', 2023, 35000);
--INSERT INTO sales_data VALUES (6, 'Tablet', 2023, 25000);
--
--COMMIT;

SELECT * FROM 
(SELECT PRODUCT,YEAR,SALES_AMOUNT FROM SALES_DATA) SOURCE_TABLE
PIVOT
(SUM(SALES_AMOUNT) AS SSUM
FOR YEAR IN (2022 AS "y2022",2023 AS "Y2023"))

-------------------------------------------------------------------------------------
DROP TABLE sales_data
CREATE TABLE sales_data (
    Sales_ID NUMBER PRIMARY KEY,
    Product VARCHAR2(50),
    Year NUMBER,
    Region VARCHAR2(20),
    Sales_Amount NUMBER,
    Profit_Amount NUMBER
);

-- Insert Sample Data
INSERT INTO sales_data VALUES (1, 'Laptop', 2022, 'North', 50000, 8000);
INSERT INTO sales_data VALUES (2, 'Laptop', 2022, 'South', 45000, 7500);
INSERT INTO sales_data VALUES (3, 'Mobile', 2022, 'East', 30000, 5000);
INSERT INTO sales_data VALUES (4, 'Tablet', 2022, 'West', 20000, 3000);
INSERT INTO sales_data VALUES (5, 'Laptop', 2023, 'North', 60000, 9000);
INSERT INTO sales_data VALUES (6, 'Laptop', 2023, 'South', 55000, 8500);
INSERT INTO sales_data VALUES (7, 'Mobile', 2023, 'East', 35000, 6000);
INSERT INTO sales_data VALUES (8, 'Tablet', 2023, 'West', 25000, 4000);

COMMIT;

SELECT * FROM (
    SELECT 
        Product, Year, Region, Sales_Amount, Profit_Amount
    FROM sales_data
)
PIVOT (
    SUM(Sales_Amount) AS Sales, 
    SUM(Profit_Amount) AS Profit
    FOR (Year, Region) 
    IN (
        (2022, 'North') AS Y2022_North, 
        (2022, 'South') AS Y2022_South, 
        (2022, 'East') AS Y2022_East, 
        (2022, 'West') AS Y2022_West,
        (2023, 'North') AS Y2023_North, 
        (2023, 'South') AS Y2023_South, 
        (2023, 'East') AS Y2023_East, 
        (2023, 'West') AS Y2023_West
    )
);




--------------------------------------------------------------------------------------------------------






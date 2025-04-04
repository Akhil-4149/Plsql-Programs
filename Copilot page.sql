CREATE OR REPLACE FUNCTION get_employee_salary (p_employee_id IN NUMBER)
RETURN NUMBER
IS
    v_salary NUMBER;
BEGIN
    SELECT salary
    INTO v_salary
    FROM employees
    WHERE employee_id = p_employee_id;

    RETURN v_salary;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    WHEN OTHERS THEN
        RAISE;
END;
;

# q: we can RETURN multiple values from a function
# a: No, we can only return a single value from a function. However, we can return a collection of values, such as a record or a collection.

# function to calculate the salary of an employee in oracle plsql   

# types of collections in oracle plsql
# 1. Associative arrays
# 2. Nested tables
# 3. Varrays

# Associative arrays with example
# Associative arrays are also known as index-by tables. They are similar to arrays in other programming languages.
# An associative array is a collection of elements, each identified by a unique key.
# The key can be of any scalar data type, such as a number or a string.
# The elements of an associative array are stored in no particular order.
# The key-value pairs are stored in a hash table, which allows for fast access to the elements.

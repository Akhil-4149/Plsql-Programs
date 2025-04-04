-- 1. SYSDATE: Returns the current system date and time
SELECT SYSDATE FROM dual;

-- 2. CURRENT_DATE: Returns the current date in the session's time zone
SELECT CURRENT_DATE FROM dual;

-- 3. TO_DATE: Converts a string to a date using a specified format
SELECT TO_DATE('2025-02-04', 'YYYY-MM-DD') FROM dual;

-- 4. TO_CHAR: Converts a date to a string with a specified format
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM dual;

-- 5. ADD_MONTHS: Adds a specified number of months to a date
SELECT ADD_MONTHS(SYSDATE, 3) FROM dual;

-- 6. MONTHS_BETWEEN: Returns the number of months between two dates
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2024-01-01', 'YYYY-MM-DD')) FROM dual;

-- 7. NEXT_DAY: Returns the date of the next specified weekday after a given date
SELECT NEXT_DAY(SYSDATE, 'WEDNESDAY') FROM dual;

-- 8. LAST_DAY: Returns the last day of the month for a given date
SELECT LAST_DAY(SYSDATE) FROM dual;

-- 9. EXTRACT: Extracts specific parts (year, month, day, etc.) from a date or timestamp
SELECT EXTRACT(YEAR FROM SYSDATE) FROM dual;
SELECT EXTRACT(MONTH FROM SYSDATE) FROM dual;
SELECT EXTRACT(DAY FROM SYSDATE) FROM dual;

-- 10. TRUNC: Truncates a date to a specified unit (like year, month, day)
SELECT TRUNC(SYSDATE, 'MM') FROM dual; 
-- Truncates the current date to the first day of the month

-- 11. ROUND: Rounds a date to a specified unit (like nearest day, month, etc.)

SELECT ROUND(SYSDATE, 'YYYY') FROM dual;
-- Rounds the current date to the start of the current year

-- 12. CURRENT_TIMESTAMP: Returns the current date and time with time zone
SELECT CURRENT_TIMESTAMP FROM dual;

-- 13. DBTIMEZONE: Returns the time zone of the database
SELECT DBTIMEZONE FROM dual;

-- 14. SESSIONTIMEZONE: Returns the time zone of the session
SELECT SESSIONTIMEZONE FROM dual;




--Read without blocking transactions	? SET TRANSACTION READ ONLY;
SET TRANSACTION READ ONLY;

SELECT * FROM emp;

COMMIT;


-------------------------------------------------------
--Avoid waiting for locks during updates	? SELECT ... FOR UPDATE NOWAIT;
SELECT * FROM emp
WHERE emp_id = 103
FOR UPDATE NOWAIT;

-------------------------------------------
--Ensure only committed data is read	? SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

--Read past data without locking live transactions	? SELECT ... AS OF TIMESTAMP;
SELECT * FROM emp AS OF TIMESTAMP (SYSTIMESTAMP - INTERVAL '5' MINUTE);








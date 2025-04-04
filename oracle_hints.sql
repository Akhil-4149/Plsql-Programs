select * from emp;
select * from depart;
-- Query Optimization Hints
-- ORDERED: Forces join order in FROM clause. Use when the optimizer picks an inefficient join order.
SELECT /*+ ORDERED */ e.emp_name, d.dept_name FROM emp e, depart d WHERE e.emp_dept_id  = d.dept_id ;

-- LEADING: Specifies join order. Use to influence execution plan.
SELECT /*+ LEADING(e d) */ e.emp_name, d.dept_name FROM emp e, depart d WHERE e.emp_dept_id  = d.dept_id ;

-- Join Methods
-- USE_NL: Uses Nested Loop Join. Best for small datasets or indexed joins.
SELECT /*+ USE_NL(e d) */ e.emp_name, d.dept_name FROM emp e, depart d WHERE e.emp_dept_id  = d.dept_id ;

-- USE_HASH: Uses Hash Join. Best for large datasets without indexes.
SELECT /*+ USE_HASH(e d) */ e.emp_name, d.dept_name FROM emp e, depart d WHERE e.emp_dept_id  = d.dept_id ;

-- USE_MERGE: Uses Sort Merge Join. Best when both tables are sorted.
SELECT /*+ USE_MERGE(e d) */ e.emp_name, d.dept_name FROM emp e, depart d WHERE e.emp_dept_id  = d.dept_id ;

-- Access Paths
-- FULL: Forces Full Table Scan. Use when a full scan is more efficient.
SELECT /*+ FULL(emp) */ * FROM emp;

-- INDEX: Forces Index Scan. Use to override optimizer when index usage is better.
SELECT /*+ INDEX(emp emp_idx) */ emp_name FROM emp WHERE empno = 101;

-- INDEX_FFS: Uses Index Fast Full Scan. Use for retrieving large datasets efficiently.
SELECT /*+ INDEX_FFS(emp emp_idx) */ emp_name FROM emp WHERE empno = 101;

-- INDEX_ASC: Uses Index Scan in Ascending Order. Use for range queries.
SELECT /*+ INDEX_ASC(emp emp_idx) */ emp_name FROM emp WHERE empno = 101;

-- INDEX_DESC: Uses Index Scan in Descending Order. Use for retrieving latest records first.
SELECT /*+ INDEX_DESC(emp emp_idx) */ emp_name FROM emp WHERE empno = 101;


-- Parallel Execution
-- PARALLEL: Enables Parallel Query Execution. Use for faster query execution on large tables.
SELECT /*+ PARALLEL(emp 4) */ * FROM emp;
select * from emp;
-- NOPARALLEL: Disables Parallel Execution. Use when parallelism is causing overhead.
SELECT /*+ NOPARALLEL(emp) */ * FROM emp;


-- Query Transformations
-- NO_MERGE: Prevents Query Merging. Use when subqueries are better separately optimized.
SELECT /*+ NO_MERGE(emp) */ * FROM emp;

-- MERGE: Forces Query Merging. Use when optimizer fails to merge beneficial subqueries.
SELECT /*+ MERGE(emp) */ * FROM emp;

-- PUSH_PRED: Pushes Filter Predicates. Use to improve filter efficiency.
SELECT /*+ PUSH_PRED(emp) */ * FROM emp WHERE dept_id  = 10;

-- NO_PUSH_PRED: Prevents Predicate Push. Use when predicate push affects performance negatively.
SELECT /*+ NO_PUSH_PRED(emp) */ * FROM emp WHERE dept_id  = 10;


-- Optimization Mode Hints
-- ALL_ROWS: Optimizes for throughput (batch processing). Use for reporting queries.
SELECT /*+ ALL_ROWS */ * FROM emp;

select * from emp;
-- FIRST_ROWS: Optimizes for first n rows. Use for interactive queries.
SELECT /*+ FIRST_ROWS(10) */ * FROM emp;

-- RULE: Uses Rule-Based Optimizer (Deprecated). Avoid using as CBO is preferred.
    SELECT /*+ RULE */ * FROM emp;


-- DML Hints
-- APPEND: Uses Direct-Path Insert (Bypasses Redo Logs). Use for bulk inserts.
INSERT /*+ APPEND */ INTO emp SELECT * FROM emp_backup;

-- PARALLEL: Enables Parallel DML. Use for faster inserts.
INSERT /*+ PARALLEL(emp 4) */ INTO emp SELECT * FROM emp_backup;

-- NOLOGGING: Disables Redo Logging. Use to improve performance but with risk of data loss.
INSERT /*+ APPEND NOLOGGING */ INTO emp SELECT * FROM emp_backup;

-- DRIVING_SITE: Executes Query at Remote Site. Use to reduce network overhead in distributed queries.
SELECT /*+ DRIVING_SITE(emp) */ * FROM emp@remote_db;


-- Miscellaneous Hints
-- DYNAMIC_SAMPLING: Controls Dynamic Statistics Sampling. Use to improve cardinality estimates.
SELECT /*+ DYNAMIC_SAMPLING(4) */ * FROM emp;

-- RESULT_CACHE: Caches Query Results. Use for frequently accessed static data.
SELECT /*+ RESULT_CACHE */ emp_name FROM emp WHERE dept_id  = 10;

-- CARDINALITY: Specifies Expected Number of Rows. Use when optimizer misestimates row counts.
SELECT /*+ CARDINALITY(emp 1000) */ * FROM emp;




EXPLAIN PLAN FOR 

SELECT * FROM emp WHERE Emp_Name = 'John Doe';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);




---------------------------------------------------------------------


explain plan for 

select * from emp;

SELECT * FROM table(dbms_xplan.display)
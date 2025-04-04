--1. Tables Related to Schema and Tables
--
--- USER_TABLES
--  Description: Lists all tables owned by the current user.
--  Use: To get information about the tables created by the user.
--  Query:
  -- Get all table names from the current user's schema
  SELECT table_name FROM user_tables;

--- USER_TAB_COLUMNS
--  Description: Contains details about columns in tables owned by the current user.
--  Use: To retrieve column names, data types, and other column-specific details.
--  Query:
  -- Get details about columns in a specific table
  SELECT column_name, data_type, data_length, nullable 
  FROM user_tab_columns 
  --WHERE table_name = 'YOUR_TABLE_NAME';  -- Replace with actual table name

--- USER_CONS_COLUMNS
--  Description: Contains information about the columns that are part of the constraints (Primary Key, Foreign Key, etc.) on user-owned tables.
--  Use: To view columns involved in constraints.
--  Query:
  -- Get columns involved in constraints for a specific table
  SELECT constraint_name, column_name 
  FROM user_cons_columns 
  --WHERE table_name = 'YOUR_TABLE_NAME';  -- Replace with actual table name

--2. Indexes and Constraints
--
--- USER_INDEXES
--  Description: Lists the indexes created on tables owned by the current user.
--  Use: To retrieve information about the indexes on user tables.
--  Query:
  -- Get index names, associated tables, and uniqueness of indexes
  SELECT index_name, table_name, uniqueness 
  FROM user_indexes 
  --WHERE table_name = 'YOUR_TABLE_NAME';  -- Replace with actual table name

--- USER_CONSTRAINTS
--  Description: Lists all constraints (e.g., Primary Key, Foreign Key) on tables owned by the current user.
--  Use: To check constraints on user-owned tables.
--  Query:
  -- Get all constraints and their types for a specific table
  SELECT constraint_name, constraint_type 
  FROM user_constraints 
 --WHERE table_name = 'YOUR_TABLE_NAME';  -- Replace with actual table name

--3. Triggers
--
--- USER_TRIGGERS
--  Description: Lists triggers defined on tables owned by the current user.
--  Use: To get details about triggers associated with a user’s tables.
--  Query:
  -- Get details of triggers, triggering event, and status for a specific table
  SELECT trigger_name, triggering_event, status 
  FROM user_triggers 
  --WHERE table_name = 'YOUR_TABLE_NAME';  -- Replace with actual table name

--4. Table Space and Storage Details
--
--- USER_TABLESPACES
--  Description: Lists all tablespaces available to the current user.
--  Use: To get details about the tablespaces accessible by the user.
--  Query:
  -- Get names of all tablespaces available to the user
  SELECT tablespace_name FROM user_tablespaces;

--- USER_SEGMENTS
--  Description: Provides information about storage allocation for segments (tables, indexes, etc.) owned by the user.
--  Use: To get storage details for a specific table or index.
--  Query:
  -- Get storage information for a specific segment (table or index)
  SELECT segment_name, segment_type, tablespace_name, bytes 
  FROM user_segments 
  --WHERE segment_name = 'YOUR_TABLE_NAME';  -- Replace with actual table name

--5. Views and Object Dependencies
--
--- USER_VIEWS
--  Description: Lists all views owned by the current user.
--  Use: To retrieve information about views created by the user.
--  Query:
  -- Get names of all views owned by the current user
  SELECT view_name FROM user_views;

--- USER_DEPENDENCIES
--  Description: Provides dependencies between objects (tables, views, etc.) owned by the current user.
--  Use: To check for dependencies between user-created objects (e.g., views on a table).
--  Query:
  -- Get dependencies between objects in the user's schema
  SELECT name, type, referenced_name, referenced_type 
  FROM user_dependencies 
  WHERE owner = 'YOUR_USER_NAME';  -- Replace with actual user name

--6. Foreign Key Relationships
--
--- USER_TAB_PRIVS
--  Description: Lists all table privileges granted to the current user.
--  Use: To view table-level access granted to the user.
--  Query:
  -- Get all table privileges granted to the current user
  SELECT * FROM user_tab_privs --where table_name ='EMP';

--- USER_FKEYS (for Foreign Keys)
--  Description: Displays foreign key constraints on tables.
--  Use: To check which tables have foreign key relationships with the current table.
--  Query:
  -- Get foreign key constraints related to a specific table
  SELECT constraint_name, table_name, column_name 
  FROM user_cons_columns 
  WHERE table_name = 'YOUR_TABLE_NAME' 
  AND constraint_name IN 
  (SELECT constraint_name FROM user_constraints WHERE constraint_type = 'R');  -- Foreign Key constraint type

--7. Database Users and Roles
--
--- USER_ROLE_PRIVS
--  Description: Lists the roles granted to the current user.
--  Use: To retrieve the roles that the user has been granted.
--  Query:
  -- Get all roles granted to the current user
  SELECT granted_role FROM user_role_privs;

--8. Sessions and Performance
--
--- V$SESSION
--  Description: Displays information about current database sessions.
--  Use: To monitor active sessions and their status.
--  Query:
  -- Get details of active database sessions
  SELECT session_id, username, status FROM v$session;

--- V$SQL
--  Description: Lists currently executing SQL statements.
--  Use: To monitor and troubleshoot active queries and statements.
--  Query:
  -- Get details of currently executing SQL queries
  SELECT sql_id, sql_text FROM v$sql WHERE status = 'EXECUTING';
 
 -------------------PERFORMANCE RELETED -------------------------------------
 
  
--  
--  1. Session Information
--
--- V$SESSION
--  Description: Displays information about current database sessions.
--  Use: To monitor active sessions and their status.
--  Query:
  -- Get session details like session ID, username, and status to monitor active sessions
  SELECT session_id, username, status 
  FROM v$session;
  
  SELECT * FROM v$session

--2. SQL Statements Execution
--
--- V$SQL
--  Description: Lists currently executing SQL statements.
--  Use: To monitor and troubleshoot active queries and statements.
--  Query:
  -- Get details of the currently executing SQL statements including SQL_ID and SQL_TEXT
  SELECT sql_id, sql_text 
  FROM v$sql 
  WHERE status = 'EXECUTING';  -- Show only executing queries

--3. System Wait Events
--
--- V$SYSTEM_EVENT
--  Description: Displays system-level wait events.
--  Use: To check what the system is waiting on, which can indicate performance bottlenecks.
--  Query:
  -- Get system-wide wait events to analyze resource contention or waits
  SELECT event, total_waits, time_waited 
  FROM v$system_event;

--4. Top SQL Queries by Resource Usage
--
--- V$SQLAREA
--  Description: Provides an overview of the SQL statements executed in the database.
--  Use: To identify which SQL queries are consuming the most resources.
--  Query:
  -- Get the top SQL queries sorted by total buffer gets to identify heavy resource usage
  SELECT sql_id, execution_count, buffer_gets, disk_reads 
  FROM v$sqlarea 
  ORDER BY buffer_gets DESC;

--5. Instance Performance
--
--- V$INSTANCE
--  Description: Displays instance-level performance information.
--  Use: To check the current status of the database instance and its performance.
--  Query:
  -- Get details about the instance such as status and database role
  SELECT instance_name, status, database_status 
  FROM v$instance;

--6. Buffer Cache Hit Ratio
--
--- V$BUFFER_POOL
--  Description: Provides information about the buffer pool, which holds data blocks in memory.
--  Use: To monitor buffer cache efficiency and performance.
--  Query:
  -- Get buffer pool statistics including buffer cache hit ratio
  SELECT name, value 
  FROM v$buffer_pool 
  WHERE name = 'DEFAULT';

--7. Waits for Database Locks
--
--- V$LOCK
--  Description: Lists all locks currently held in the database.
--  Use: To identify blocking sessions or resource contention.
--  Query:
--  -- Get information about locks in the database that might be blocking resources
  SELECT session_id, type, lmode, request,blocking_session 
  FROM v$lock 
  WHERE blocking_session > 0;

--8. Disk I/O Performance
--
--- V$FILESTAT
--  Description: Provides information about I/O statistics for each file in the database.
--  Use: To monitor I/O performance on the disk.
--  Query:
  -- Get disk I/O statistics for files in the database, including reads and writes
  SELECT file_id, name, reads, writes, reads + writes AS total_io 
  FROM v$filestat;

--9. Memory Usage
--
--- V$SGASTAT
--  Description: Displays the shared global area (SGA) statistics, which can help monitor memory usage.
--  Use: To check memory consumption by different SGA components.
--  Query:
  -- Get statistics about shared memory usage in the database
  SELECT name, value 
  FROM v$sgastat 
  WHERE name LIKE '%free%';  -- Filter for free memory statistics

--10. Long Running Queries

--- V$ACTIVE_SESSION_HISTORY
--  Description: Provides information on active sessions and their SQL execution history.
--  Use: To identify long-running queries and troubleshoot performance issues.
--  Query:
  -- Get active session history to identify long-running queries
  SELECT session_id, sql_id, sql_text, wait_event 
  FROM v$active_session_history 
  WHERE session_id IN (SELECT session_id FROM v$session WHERE status = 'ACTIVE')
  AND rownum <= 10;  -- Get top 10 long-running queries

--11. Session Waits

--- V$SESSION_WAIT
--  Description: Displays wait events for active sessions.
--  Use: To monitor wait times and troubleshoot performance issues.
--  Query:
  -- Get wait events for sessions currently waiting on resources
  SELECT session_id, event, wait_time, time_waited 
  FROM v$session_wait 
  WHERE wait_time > 0;  -- Only show sessions currently waiting


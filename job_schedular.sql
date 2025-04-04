begin
dbms_scheduler.create_job 
(
job_name =>'my_job',
job_type =>'PLSQL_BLOCK',
job_ACTION =>'code',
start_date=>SYSTIMESTAMP, 
repeat_interval =>'freq=secondly : inertval=5',
end_date => null,
enabled=>true,
comments=>'my first job'
);
end;


---moniter job

select * from all_scheduler_running_jobs;


select * from dba_scheduler_jobs;

select * from dba_scheduler_job_log
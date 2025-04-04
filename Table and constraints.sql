drop table sample_table;
create table sample_table (name varchar2(10) not null,
id int primary key,
age int CHECK(age <=18 and age >=100),
salary NUMBER(10,2) CHECK (salary >= 0),
user_id varchar2(10) unique,
dept_id NUMBER ,
CONSTRAINT product_id_fk
    FOREIGN KEY (id) REFERENCES emp(emp_id)
    ,join_date date default sysdate
    
)

----------------------------------------------------------------------------------------

create SEQUENCE ak_seq
start with 101 INCREMENT by 1;

SELECT ak_seq.NEXTVAL FROM dual;
SELECT ak_seq.currval FROM dual;

INSERT INTO aemp (emp_id, emp_name)
VALUES (ak_seq.NEXTVAL, 'akhilesh');

select * from aemp;

create table aemp as
select * from emp where 1<>1

---------------------------------------------------------------------



create index sam_index on sample_table (dept_id);

select * from sample_table;

select * from sample_table;


COMMENT ON TABLE EMP IS 'This akhilesh employee';
comment on table emp is 'Assign to Pranali';

COMMENT ON COLUMN sample_table.salary IS 'This column stores Null values as well.';
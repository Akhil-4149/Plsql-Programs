create or Replace function  akhilesh_function
RETURN VARCHAR2 
is 
A VARCHAR2(100);
begin
 
 A:='Hello Akhoolesh';
 
 RETURN a;
end akhilesh_function ;
/


--select akhilesh_function from dual


create or replace function ak_func(var1 int ,var2 int )
return int 
is 

lv_st1 int ;

begin

return lv_st1;

end ak_func;
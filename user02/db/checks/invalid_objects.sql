
------------------------------------------------------
--  Checking Invalid objects                        --
------------------------------------------------------

@&print -b 'Checking Invalid objects:'
 
------------------------------------------------------
--  Show invalid objects                            --
------------------------------------------------------
set feedback off
set serveroutput on
VAR v_invalid_count number;
exec :v_invalid_count := 0;

begin
 dbms_output.put_line (rpad('OBJECT NAME',30) || ' : ' || 'OBJECT TYPE');
 dbms_output.put_line (rpad('-----------',30) || ' : ' || '-----------');
 for i in (select * from user_objects t where t.STATUS != 'VALID' order by object_type)
   loop
     dbms_output.put_line (rpad(i.object_name,30) || ' : ' || i.object_type);
	 :v_invalid_count := :v_invalid_count + 1;
   end loop;
 dbms_output.put_line(chr(10) || :v_invalid_count || ' invalid objects were found.' || chr(10));
end;
/

undefine EXIT_STATUS
column ERROR_CODE new_value EXIT_STATUS

set termout off
select decode(:v_invalid_count,0,'SUCCESS','FAILURE') as ERROR_CODE from dual;
set termout on

@&print -c 'Exit status: &EXIT_STATUS'

exit &EXIT_STATUS

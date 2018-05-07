@./define.sql

@&print -b 'Clean user objects: schema &SCHEMA_NAME'

set termout on
SET SERVEROUTPUT on
set feedback off

begin
  for i in (select distinct OBJECT_NAME, OBJECT_TYPE from user_objects)
    loop
      begin
        dbms_output.put_line (rpad(i.OBJECT_NAME,30) || ' - ' || rpad(i.OBJECT_TYPE,30) || ': dropped');
        execute immediate 'DROP ' || i.OBJECT_TYPE || ' ' || i.OBJECT_NAME;
      exception
        when others then
        dbms_output.put_line (rpad(i.OBJECT_NAME,30) || ' - ' || rpad(i.OBJECT_TYPE,30) || ': skipped');
      end;
    end loop;
	begin
	  execute immediate 'PURGE RECYCLEBIN';
	  dbms_output.put_line (chr(10) || 'PURGE RECYCLEBIN: Done');
	exception
        when others then
        dbms_output.put_line (chr(10) || 'PURGE RECYCLEBIN: Failed');
    end;  
end;
/

set feedback on

exit
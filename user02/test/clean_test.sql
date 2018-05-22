@./define.sql

@&print -b 'Clean test-packages: schema &SCHEMA_NAME'

set termout on
SET SERVEROUTPUT on
set feedback off

begin
  for i in (select distinct OBJECT_NAME, OBJECT_TYPE 
            from user_objects o
            where o.OBJECT_TYPE = 'PACKAGE'
              and exists (select 1
                          from user_source s
                          where s.NAME = o.OBJECT_NAME
                            and s.TYPE = o.OBJECT_TYPE
                            and regexp_like(s.TEXT,'--[[:space:]]?+%suite')))
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
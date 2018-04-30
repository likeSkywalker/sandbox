SET SERVEROUTPUT on
begin
  for i in (select * from user_objects)
    loop
      begin
        dbms_output.put_line ('trying to drop '|| i.OBJECT_TYPE || ' ' || i.OBJECT_NAME);
        execute immediate 'DROP ' || i.OBJECT_TYPE || ' ' || i.OBJECT_NAME;
      exception
        when others then
        null;
      end;
    end loop;
	begin
	  execute immediate 'PURGE RECYCLEBIN';
	exception
        when others then
        null;
    end;  
end;
/

exit
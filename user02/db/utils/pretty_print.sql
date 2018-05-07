
set feedback off
set termout off
set serveroutput on

VAR v_symbol varchar2(1);
VAR v_symbols_count number;
VAR text varchar2(4000);

exec :v_symbol := case '&1' when '-b' then '#' when '-c' then '-' else '*' end;
exec :v_symbols_count := 60;
exec :text := '&2';

set termout on


begin
  dbms_output.put_line (rpad(:v_symbol,:v_symbols_count,:v_symbol)); 
  dbms_output.put_line (rpad(:v_symbol,2,:v_symbol) || ' ' || rpad(:text,:v_symbols_count - 6) || ' ' || rpad(:v_symbol,2,:v_symbol)); 
  dbms_output.put_line (rpad(:v_symbol,:v_symbols_count,:v_symbol));
  dbms_output.put_line (chr(13));
end;
/

set feedback on
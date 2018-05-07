set define on;
------------------------------------------------------
--  Set language : ENGLISH                          --
------------------------------------------------------
set feedback off
alter session set nls_language=ENGLISH;
set feedback on
------------------------------------------------------
--  Set print file location                         --
------------------------------------------------------
define print = './utils/pretty_print.sql';

------------------------------------------------------
--  Set schema name                                 --
------------------------------------------------------
undefine SCHEMA_NAME
column USER new_value SCHEMA_NAME
set termout off
select USER from dual;
set termout on


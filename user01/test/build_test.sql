@./define.sql

@&print -b 'install test-packages: schema &SCHEMA_NAME'

--------------------------------------------------------
-- Error while creation will NOT lead to buid FAILURE --
--------------------------------------------------------
@./function/UT$_GET_TEAM_US01.pck
@./procedure/UT$_INSERT_RESULT_US01.pck
@./package/UT$_PKG_RUN_US01.pck

@&print -b 'Compile schema &SCHEMA_NAME'
exec dbms_utility.compile_schema(schema => '&SCHEMA_NAME');

------------------------------------------------------
--  Checking Invalid objects and EXIT               --
-----------------------------------------------------
@../db/checks/invalid_objects.sql

@./define.sql

@&print -b 'Start deployment: schema &SCHEMA_NAME'

WHENEVER OSERROR EXIT 9;
WHENEVER SQLERROR EXIT SQL.SQLCODE;
------------------------------------------------------
--  Error while creation will lead to buid FAILURE  --
------------------------------------------------------
@./table/stg_game_result_us02.sql
@./sequence/seq_oid_us02.sql

WHENEVER OSERROR CONTINUE;
WHENEVER SQLERROR CONTINUE
--------------------------------------------------------
-- Error while creation will NOT lead to buid FAILURE --
--------------------------------------------------------
@./view/vw_daily_result_us02.sql
@./function/get_team_us02.sql
@./procedure/insert_result_us02.sql
@./package/pkg_run_us02_head.sql
@./package/pkg_run_us02_body.sql

@&print -b 'Compile schema &SCHEMA_NAME'

exec dbms_utility.compile_schema(schema => '&SCHEMA_NAME');

------------------------------------------------------
--  Checking Invalid objects and EXIT               --
------------------------------------------------------
@./checks/invalid_objects.sql
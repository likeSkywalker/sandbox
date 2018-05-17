@./define.sql

@&print -b 'Start deployment: schema &SCHEMA_NAME'

WHENEVER OSERROR EXIT 9;
WHENEVER SQLERROR EXIT SQL.SQLCODE;
------------------------------------------------------
--  Error while creation will lead to buid FAILURE  --
------------------------------------------------------
@./table/stg_game_result_us01.sql
@./sequence/seq_oid_us01.sql

WHENEVER OSERROR CONTINUE;
WHENEVER SQLERROR CONTINUE
--------------------------------------------------------
-- Error while creation will NOT lead to buid FAILURE --
--------------------------------------------------------
@./view/vw_daily_result_us01.sql
@./function/get_team_us01.sql
@./procedure/insert_result_us01.sql
@./package/pkg_run_us01_head.sql
@./package/pkg_run_us01_body.sql

@&print -b 'Compile schema &SCHEMA_NAME'

exec dbms_utility.compile_schema(schema => '&SCHEMA_NAME');

------------------------------------------------------
--  Checking Invalid objects and EXIT               --
------------------------------------------------------
@../test/function/UT$_GET_TEAM_USER01.pck

@./checks/invalid_objects.sql

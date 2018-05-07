@&print -c 'Create package body PKG_RUN_US02'

create or replace PACKAGE BODY PKG_RUN_US02 AS

  procedure p_insert_result (ip_count in number) AS
  BEGIN
    INSERT_RESULT_US02(ip_count => ip_count);
  END p_insert_result;

  procedure p_clean_result AS
  BEGIN
    execute immediate 'TRUNCATE TABLE STG_GAME_RESULT_US02';
  END p_clean_result;

END PKG_RUN_US02;
/
create or replace package UT$_PKG_RUN_US01 is

  -- %suite
  -- %suitepath(user01.package)
  -- %displayname(pkg_run_us01)
  -- %rollback(manual)

  -- %test
  -- %displayname(p_insert_result: n_record)
  -- %rollback(manual)
  procedure n_record;

  -- %test
  -- %displayname(p_insert_result@null_value)
  -- %rollback(manual)
  procedure null_value;

  -- %test
  -- %displayname(p_clean_result@clean_n_record)
  -- %aftertest(n_record)
  -- %rollback(manual)
  procedure clean_n_record;


end UT$_PKG_RUN_US01;
/
create or replace package body UT$_PKG_RUN_US01 is

  procedure n_record is
    cur_stg_game_result_us01 sys_refcursor;
    n number := 3;
  begin
    -- clean stg_game_result_us01 is not empty:
    for i in (select 1 from dual
              where (select count(1) from stg_game_result_us01 where rownum = 1) = 1)
      loop
        execute immediate 'TRUNCATE TABLE STG_GAME_RESULT_US01';
      end loop;
    -- insert n records:
    pkg_run_us01.p_insert_result(n);
    -- fetch n records and verify:
    open cur_stg_game_result_us01 for select * from stg_game_result_us01;
    ut.expect(cur_stg_game_result_us01).to_have_count(n);
  end n_record;

  procedure null_value is
    cur_stg_game_result_us01 sys_refcursor;
  begin
    -- clean stg_game_result_us01 is not empty:
    for i in (select 1 from dual
              where (select count(1) from stg_game_result_us01 where rownum = 1) = 1)
      loop
        execute immediate 'TRUNCATE TABLE STG_GAME_RESULT_US01';
      end loop;
    -- pass null as ip_count parameter:
    pkg_run_us01.p_insert_result(null);
    -- fetch and verify:
    open cur_stg_game_result_us01 for select * from stg_game_result_us01;
    ut.expect(cur_stg_game_result_us01).to_have_count(0);
  end null_value;

  procedure clean_n_record is
    cur_stg_game_result_us01 sys_refcursor;
  begin
    -- insert n records:
    pkg_run_us01.p_insert_result(3);
    -- run clean:
    pkg_run_us01.p_clean_result();
    -- fetch and verify:
    open cur_stg_game_result_us01 for select * from stg_game_result_us01;
    ut.expect(cur_stg_game_result_us01).to_have_count(0);
  end clean_n_record;


end UT$_PKG_RUN_US01;
/

create or replace package UT$_INSERT_RESULT_US01 is

  -- %suite
  -- %suitepath(user01.procedure)
  -- %displayname(insert_result_us01)
  -- %rollback(manual)

  -- %test
  -- %displayname(n_record: "put 'n' as input parameter and check count")
  -- %rollback(manual)
  procedure n_record;

  -- %test
  -- %displayname(null_value: "put 'null' as input parameter and check count")
  -- %rollback(manual)
  procedure null_value;

end UT$_INSERT_RESULT_US01;
/
create or replace package body UT$_INSERT_RESULT_US01 is

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
    insert_result_us01(n);
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
   insert_result_us01(null);
    -- fetch and verify:
    open cur_stg_game_result_us01 for select * from stg_game_result_us01;
    ut.expect(cur_stg_game_result_us01).to_have_count(0);
  end null_value;

end UT$_INSERT_RESULT_US01;
/

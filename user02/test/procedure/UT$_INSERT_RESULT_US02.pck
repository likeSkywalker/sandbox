create or replace package UT$_INSERT_RESULT_US02 is

  -- %suite
  -- %suitepath(user02.procedure)
  -- %displayname(insert_result_us02)
  -- %rollback(manual)

  -- %test
  -- %displayname("put 'n' as input parameter and check count")
  -- %rollback(manual)
  procedure n_record;

  -- %test
  -- %displayname("put 'null' as input parameter and check count")
  -- %rollback(manual)
  procedure null_value;

end UT$_INSERT_RESULT_US02;
/
create or replace package body UT$_INSERT_RESULT_US02 is

  procedure n_record is
    cur_stg_game_result_us02 sys_refcursor;
    n number := 3;
  begin
    -- clean stg_game_result_us02 is not empty:
    for i in (select 1 from dual
              where (select count(1) from stg_game_result_us02 where rownum = 1) = 1)
      loop
        execute immediate 'TRUNCATE TABLE STG_GAME_RESULT_US02';
      end loop;
    -- insert n records:
    insert_result_us02(n);
    -- fetch n records and verify:
    open cur_stg_game_result_us02 for select * from stg_game_result_us02;
    ut.expect(cur_stg_game_result_us02).to_have_count(n);
  end n_record;

  procedure null_value is
    cur_stg_game_result_us02 sys_refcursor;
  begin
    -- clean stg_game_result_us02 is not empty:
    for i in (select 1 from dual
              where (select count(1) from stg_game_result_us02 where rownum = 1) = 1)
      loop
        execute immediate 'TRUNCATE TABLE STG_GAME_RESULT_US02';
      end loop;
    -- pass null as ip_count parameter:
   insert_result_us02(null);
    -- fetch and verify:
    open cur_stg_game_result_us02 for select * from stg_game_result_us02;
    ut.expect(cur_stg_game_result_us02).to_have_count(0);
  end null_value;

end UT$_INSERT_RESULT_US02;
/

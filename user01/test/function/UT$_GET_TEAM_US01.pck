create or replace package UT$_GET_TEAM_US01 is

  -- %suite
  -- %suitepath(user01.function)
  -- %displayname(get_team_us01)
  
  -- %test
  -- %displayname(check_data_length)
  procedure check_data_length;
  
  -- %test
  -- %displayname(check_values_by_list)
  procedure check_values_by_list;
  
  
end UT$_GET_TEAM_US01;
/
create or replace package body UT$_GET_TEAM_US01 is

  procedure check_data_length is
  begin
   ut.expect(length(get_team_us01())).to_(be_less_or_equal(256));
  end;
  
  procedure check_values_by_list is
    cur_generate_500_values sys_refcursor;
  begin
     insert_result_us01(1);
     open cur_generate_500_values for
     select * 
      from (select level as lvl, get_team_us01 as team
            from dual
            connect by level <=500) vw
      where team not in ('DINAMO','DNIPRO','SHAHTAR','METALIST','ZORYA','VORSKLA');
     ut.expect(cur_generate_500_values).to_have_count(0);
  end;

end UT$_GET_TEAM_US01;
/

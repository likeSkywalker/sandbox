@&print -c 'Create procedure INSERT_RESULT_US02'

/* Check codeowners feature
 * Version v08
 */

create or replace PROCEDURE INSERT_RESULT_US02 (ip_count in number) AS 
  pragma autonomous_transaction;
  v_oid number;
  v_team1_name varchar2(256);
  v_team2_name varchar2(256);
  v_count number := nvl(ip_count,0);
BEGIN
  for i in 1..v_count
    loop
       v_team1_name := GET_TEAM_US02();
       loop
         v_team2_name := GET_TEAM_US02();
         if v_team1_name != v_team2_name
           then exit;
         end if;
       end loop;
       v_oid := SEQ_OID_US02.nextval;
       insert into STG_GAME_RESULT_US02 (STG_ID , EXTERNAL_GAME_ID , GAME_DATE , TEAM1_NAME , TEAM1_SCORE , TEAM2_NAME , TEAM2_SCORE )
       values (v_oid, 'L01-G'||to_char(v_oid,'0000'), trunc(sysdate),v_team1_name,trunc(DBMS_RANDOM.VALUE(0,5)),v_team2_name,trunc(DBMS_RANDOM.VALUE(0,5)));
    end loop;
  commit;
END INSERT_RESULT_US02;
/

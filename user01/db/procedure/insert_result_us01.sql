@&print -c 'Create procedure INSERT_RESULT_US01'

/* Check codeowners feature
 * Version v07
 */
create or replace PROCEDURE INSERT_RESULT_US01 (ip_count in number) AS 
  pragma autonomous_transaction;
  v_oid number;
  v_team1_name varchar2(256);
  v_team2_name varchar2(256);
BEGIN
  for i in 1..ip_count
    loop
       v_team1_name := GET_TEAM_US01();
       loop
         v_team2_name := GET_TEAM_US01();
		 if v_team1_name != v_team2_name
           then exit;
         end if;
       end loop;
       v_oid := SEQ_OID_US01.nextval;
       insert into STG_GAME_RESULT_US01 (STG_ID , EXTERNAL_GAME_ID , GAME_DATE , TEAM1_NAME , TEAM1_SCORE , TEAM2_NAME , TEAM2_SCORE)
       values (v_oid, 'L01-G'||to_char(v_oid,'0000'), trunc(sysdate),v_team1_name,trunc(DBMS_RANDOM.VALUE(0,5)),v_team2_name,trunc(DBMS_RANDOM.VALUE(0,5)));
    end loop;
  commit;
END INSERT_RESULT_US01;
/

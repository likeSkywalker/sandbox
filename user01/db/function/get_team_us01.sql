PROMPT ** Create function GET_TEAM_US01 **

create or replace FUNCTION GET_TEAM_US01 RETURN VARCHAR2 AS 
  v_random number;
BEGIN
  v_random := trunc(DBMS_RANDOM.VALUE(0,6));
  return case
           when v_random = 0 then 'DINAMO'
           when v_random = 1 then 'DNIPRO'
           when v_random = 2 then 'SHAHTAR'
           when v_random = 3 then 'METALIST'
           when v_random = 4 then 'ZORYA'
           else 'VORSKLA'
         end;
END GET_TEAM_US01;
/

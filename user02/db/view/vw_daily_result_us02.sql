CREATE VIEW VW_DAILY_RESULT_US02 AS 
select t1.PART_ID
      ,t1.STG_ID
      ,t1.GAME_DATE
      ,t1.TEAM1_NAME as team_name
      ,t1.EXTERNAL_GAME_ID 
      ,CASE 
         WHEN t1.TEAM1_SCORE > t1.TEAM2_SCORE THEN 3
         WHEN t1.TEAM1_SCORE = t1.TEAM2_SCORE THEN 1
         ELSE 0 
       END as points
      ,CASE 
         WHEN t1.TEAM1_SCORE > t1.TEAM2_SCORE THEN 'won'
         WHEN t1.TEAM1_SCORE = t1.TEAM2_SCORE THEN 'drawn'
         ELSE 'lost' 
       END as result
      ,t1.TEAM1_SCORE as gl_for
      ,t1.TEAM2_SCORE as gl_against
      ,t1.TEAM1_SCORE - t1.TEAM2_SCORE as gl_difference
from STG_GAME_RESULT_US02 t1
union all
select t2.PART_ID
      ,t2.STG_ID
      ,t2.GAME_DATE
      ,t2.TEAM2_NAME as team_name
      ,t2.EXTERNAL_GAME_ID 
      ,CASE 
         WHEN t2.TEAM2_SCORE > t2.TEAM1_SCORE THEN 3
         WHEN t2.TEAM2_SCORE = t2.TEAM1_SCORE THEN 1
         ELSE 0 
       END as points
      ,CASE 
         WHEN t2.TEAM2_SCORE > t2.TEAM1_SCORE THEN 'won'
         WHEN t2.TEAM2_SCORE = t2.TEAM1_SCORE THEN 'drawn'
         ELSE 'lost' 
       END as result
      ,t2.TEAM2_SCORE as gl_for
      ,t2.TEAM1_SCORE as gl_against
      ,t2.TEAM2_SCORE - t2.TEAM1_SCORE as gl_difference
from STG_GAME_RESULT_US02 t2;

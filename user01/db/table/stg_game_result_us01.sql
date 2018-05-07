@&print -c 'Create table STG_GAME_RESULT_US01'

 CREATE TABLE STG_GAME_RESULT_US01 
   (	"STG_ID" NUMBER NOT NULL ENABLE, 
	"CREATED_TMS" TIMESTAMP (6) DEFAULT systimestamp, 
	"PART_ID" NUMBER GENERATED ALWAYS AS (TO_NUMBER(TO_CHAR(TRUNC("CREATED_TMS"),'yyyymmdd'))) VIRTUAL , 
	"EXTERNAL_GAME_ID" VARCHAR2(30 BYTE), 
	"GAME_DATE" DATE, 
	"TEAM1_NAME" VARCHAR2(4000 BYTE), 
	"TEAM1_SCORE" NUMBER, 
	"TEAM2_NAME" VARCHAR2(4000 BYTE), 
	"TEAM2_SCORE" NUMBER, 
	 CONSTRAINT "STG_GAME_RESULT_US01_PK" PRIMARY KEY ("STG_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DEV_STB"  ENABLE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DEV_STB" 
  PARTITION BY RANGE ("PART_ID") INTERVAL (1) 
 (PARTITION "P_FIRST"  VALUES LESS THAN (20180425) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DEV_STB" ) ;

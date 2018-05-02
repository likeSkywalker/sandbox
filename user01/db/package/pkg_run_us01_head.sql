PROMPT ** Create package head PKG_RUN_US01 **

create or replace PACKAGE PKG_RUN_US01 AS 

  /* This comment should be added before merge to env/int01
    Version 1.06  */ 
  
  procedure p_insert_result (ip_count in number);
  
  procedure p_clean_result;

END PKG_RUN_US01;
/
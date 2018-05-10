@&print -c 'Create package head PKG_RUN_US02'

create or replace PACKAGE PKG_RUN_US02 AS 

  /* This comment should be added before merge to env/int01
    Version 1.18  */ 
  
  procedure p_insert_result (ip_count in number);
  
  procedure p_clean_result;

END PKG_RUN_US02;
/
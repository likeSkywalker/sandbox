PROMPT ** Create package head PKG_RUN_US01 **

create or replace PACKAGE PKG_RUN_US01 AS 

  /* TODO enter package declarations (types, exceptions, methods etc) here */ 
  procedure p_insert_result (ip_count in number);
  
  procedure p_clean_result;

END PKG_RUN_US01;
/
@&print -c 'Create sequence SEQ_OID_US01'

--test

CREATE SEQUENCE SEQ_OID_US01 INCREMENT BY 1 MAXVALUE 9999999999999999 MINVALUE 0 CACHE 20;

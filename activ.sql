----------------------------------------------------------------------------------------
--
-- File name: activ.sql
--
-- Purpose: Lists active sessions on RAC database
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @activ.sql
--
-- Notes: Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

column sse        format a15
column status     format a10
column username   format a15
column status     format a10
column source     format a20
column logon_time format a20
column "ELAPSED TIME"  format a12
column sql_id    format a14

SET PAGESIZE 160 LINES 220 PAGES 4000 HEADING on

SELECT sid||','||serial#||'@'||inst_id||'' sse
     , username
     , substr(osuser||'@'||machine,1,20) source
     , to_char(logon_time, 'YYYY-MM-DD HH24:MI:SS') logon_time
     , status
     , sql_id
     ,  lpad(trunc(LAST_CALL_ET/86400),2,0)||' '||
        lpad(trunc((LAST_CALL_ET/86400-trunc(LAST_CALL_ET/86400))*24),2,0)||':'||
        lpad (trunc((LAST_CALL_ET/3600-trunc(LAST_CALL_ET/3600))*60),2,0)||':'||
        lpad(trunc(((LAST_CALL_ET/3600-trunc(LAST_CALL_ET/3600))*60-trunc((LAST_CALL_ET/3600-trunc(LAST_CALL_ET/3600))*60))*60),2,0)"ELAPSED TIME"
 FROM GV$SESSION
WHERE status ='ACTIVE'
      AND 
      type!='BACKGROUND'
      AND 
      username is not null
ORDER BY 7
/


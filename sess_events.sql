----------------------------------------------------------------------------------------
--
-- File name: sess_events.sql
--
-- Purpose: Lists events running on the database
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @sess_events.sql
--
-- Notes: 	Developed and tested on 11.2.0.4.
--			RAC enabled
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

column sse        format a15
column status     format a10
column username   format a13
column status     format a10
column source     format a20
column logon_time format a20
column event		format a25 word_wrapped
column "ELAPSED TIME"  format a12
column sql_id    format a14

select sid||','||serial#||'@'||inst_id||'' sse
     , username
     , to_char(logon_time, 'YYYY-MM-DD HH24:MI:SS') logon_time
     , status
     , sql_id
	 , event
     ,  lpad(trunc(LAST_CALL_ET/86400),2,0)||' '||
        lpad(trunc((LAST_CALL_ET/86400-trunc(LAST_CALL_ET/86400))*24),2,0)||':'||
        lpad (trunc((LAST_CALL_ET/3600-trunc(LAST_CALL_ET/3600))*60),2,0)||':'||
        lpad(trunc(((LAST_CALL_ET/3600-trunc(LAST_CALL_ET/3600))*60-trunc((LAST_CALL_ET/3600-trunc(LAST_CALL_ET/3600))*60))*60),2,0)"ELAPSED TIME"
 from gv$session
where sid=&1
order by 7;


----------------------------------------------------------------------------------------
--
-- File name: sess_longops.sql
--
-- Purpose: Lists longops running on the database
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @sess_longops.sql
--
-- Notes: 	Developed and tested on 11.2.0.4.
--			RAC enabled
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

col sse         format a15
col username    format a15 word_wrapped
col opname      format a20 word_wrapped
col target_desc format a10 word_wrapped
col message     format a30 word_wrapped
col PROGRESS(%) format 99.00
 
SELECT sid||','||serial#||'@'||inst_id||'' sse
     , username
     , TO_CHAR(start_time,'YYYY-MM-DD HH24:MI:SS') AS start_time
     --, opname
     --, target_desc
     , totalwork
	 , sofar
     , ROUND((sofar/totalwork)*100, 2) "PROGRESS(%)"
     , message 
FROM GV$SESSION_LONGOPS 
where TIME_REMAINING > 0 
ORDER BY TIME_REMAINING;
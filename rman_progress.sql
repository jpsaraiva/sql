----------------------------------------------------------------------------------------
--
-- File name: rman_progress.sql
--
-- Purpose: Shows progress of database backup
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @rman_progress.sql
--
-- Notes: 	Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

col sse         	format a15
col opname      	format a20 word_wrapped
col target_desc 	format a10 word_wrapped
col message     	format a30 word_wrapped
col "PROGRESS(%)" 	format 99.00

SELECT sid||','||serial# sse
     , TO_CHAR(start_time,'YYYY-MM-DD HH24:MI:SS') AS start_time
     , to_char(sysdate + TIME_REMAINING/3600/24, 'YYYY-MM-DD HH24:MI:SS') end_time
	 , totalwork
     , sofar
     , ROUND((sofar/totalwork)*100, 2) "PROGRESS(%)"
     , message 
from v$session_longops
where totalwork > sofar
AND opname like 'RMAN%';
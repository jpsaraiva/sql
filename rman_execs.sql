----------------------------------------------------------------------------------------
--
-- File name: rman_execs.sql
--
-- Purpose: List database backups
--
-- Author: 
--
-- Version: 2017/02/13
--
-- Example: @rman_execs.sql
--
-- Notes: Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

col status                       format a25
col DURATION                     format a10
col output_bytes_display         format a10 HEADING 'bytes'
col output_bytes_per_sec_display format a10 HEADING 'bytes/sec'
col input_type                   format a15
col start_time                   format a20
col end_time                     format a20
col command_id                   format a20
col output_device_type           format a10

set pagesize 100 lines 220 pages 1000 heading on feed off null ''

SELECT session_key
     , input_type
     , status
     , TO_CHAR(start_time,'YYYY-MM-DD HH24:MI:SS') start_time
     , TO_CHAR(end_time,'YYYY-MM-DD HH24:MI:SS')   end_time
     , output_bytes_display
     , output_bytes_per_sec_display
     , case 
        when (floor(elapsed_seconds/86400)>0) then floor(elapsed_seconds/86400) || ' ' || TO_CHAR(TRUNC(SYSDATE) + NUMTODSINTERVAL(elapsed_seconds, 'second'),'hh24:mi:ss' )
        else TO_CHAR(TRUNC(SYSDATE) + NUMTODSINTERVAL(elapsed_seconds, 'second'),'hh24:mi:ss' ) 
		end DURATION
     , output_device_type
FROM V$RMAN_BACKUP_JOB_DETAILS
ORDER BY session_key;
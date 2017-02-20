----------------------------------------------------------------------------------------
--
-- File name: rman_execs.sql
--
-- Purpose: List database backups
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @rman_execs.sql ( < number of days >)
--
-- Notes: 	Developed and tested on 11.2.0.4.
--			Shows 10 days by default
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

col status                       format a25
col DURATION                     format a10
col output_bytes_display         format a10 HEADING 'BCK SIZE'
col output_bytes_per_sec_display format a10 HEADING 'THROUGHPUT'
col input_type                   format a15
col start_time                   format a20
col end_time                     format a20
col command_id                   format a20
col output_device_type           format a10
col res							 format a3

column 1 new_value 1 noprint
select '' "1" from dual where rownum = 0;
define param = &1 7

SELECT session_key
     , input_type
     , decode(status,'COMPLETED','OK','COMPLETED WITH WARNINGS','OK','FAILED','NOK','RUNNING','RUN','UNK') res
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
where start_time > trunc(sysdate) - &param
ORDER BY session_key;

undefine 1 param
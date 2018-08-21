----------------------------------------------------------------------------------------
--
-- File name: awr_statsexec.sql
--
-- Purpose: Gets executions stats from AWR tables for last 7 days
--
-- Author: jpsaraiva
--
-- Version: 2017/11/15
--
-- Example: @awr_statsexec.sql
--
-- Notes: 	Developed and tested on 11.2.0.4.
--			Requires Diagnostics Pack Licensing
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

set pages 4000
set lines 220

select 
    a.instance_number "INST_ID", 
    a.sql_id,
    a.plan_hash_value,
    a.parsing_schema_name,
    a.executions_delta,
    to_char(b.end_interval_time,'MM/DD/YYYY HH24:MI:SS') "DATA", 
    a.rows_processed_delta "ROWS_PROCESSED",
    round (((a.elapsed_time_delta / a.executions_delta) / 1000000),2)  "AVG_ELAPSED_TIME",
    round (((a.cpu_time_delta / a.executions_delta) / 1000000),2)  "AVG_CPU_TIME",
    round (((a.disk_reads_delta / a.executions_delta) / 1000000),2)  "AVG_DISK_READ",
    round (((a.direct_writes_delta / a.executions_delta) / 1000000),2)  "AVG_DISK_WRITE",
    round (((a.iowait_delta / a.executions_delta) / 1000000),2)  "AVG_IO_WAIT",
    round (((a.clwait_delta / a.executions_delta) / 1000000),2)  "AVG_CL_WAIT",
    round (((a.ccwait_delta / a.executions_delta) / 1000000),2)  "AVG_CC_WAIT",
    round (((a.apwait_delta / a.executions_delta) / 1000000),2)  "AVG_AP_WAIT",
    a.snap_id
from 
    dba_hist_sqlstat a,
    dba_hist_snapshot b
where 1=1
--and a.parsing_schema_name = 'schema'
and a.sql_id='&1'
--and a.sql_id in ('0000000000000','0000000000000')
--and a.plan_hash_value=00000000
and  CAST(b.end_interval_time AS DATE) > SYSDATE - 7
and a.executions_delta > 0
AND a.snap_id = b.snap_id
AND a.dbid = b.dbid
AND a.instance_number = b.instance_number
order by snap_id desc;
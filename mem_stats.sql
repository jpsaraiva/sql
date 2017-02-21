----------------------------------------------------------------------------------------
--
-- File name: mem_stats.sql
--
-- Purpose: Memory stats for sql_id
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @mem_stats.sql < sql_id >
--
-- Notes: Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

col "INST" for 9
col sql_id for a13
col "SCHEMA" for a13
col "ELAPSED_TIME" for 999999,99
col "CPU_TIME" for 999999,99
col "ROWS" for 999999

select 
    distinct inst_id "INST",
    sql_id,
    plan_hash_value,
    parsing_schema_name "SCHEMA",
    executions,
    to_char(last_active_time,'YYYY-MM-DD HH24:MI:SS') "DATA",
    rows_processed "ROWS", 
    round(elapsed_time/1000000/decode(executions,0,1,executions),2) "ELAPSED_TIME",
    round(cpu_time/1000000/decode(executions,0,1,executions),2) "CPU_TIME"
from gv$sql where sql_id = '&1';

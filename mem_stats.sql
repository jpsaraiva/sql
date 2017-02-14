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

set lines 220 pages 4000 ver off

col "INST" for 9
col sql_id for a13
col "SCHEMA" for a15
col "ELAPSED_TIME" for 999999,99
col "CPU_TIME" for 999999,99

select 
    distinct inst_id "INST",
    sql_id,
    plan_hash_value,
    parsing_schema_name "SCHEMA",
    executions,
    to_char(last_active_time,'YYYY-MM-DD HH24:MI:SS') "DATA",
    rows_processed, 
    round(elapsed_time/1000000/decode(executions,0,1,executions),2) "ELAPSED_TIME",
    round(cpu_time/1000000/decode(executions,0,1,executions),2) "CPU_TIME"
from gv$sql where sql_id = '&1';

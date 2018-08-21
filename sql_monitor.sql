----------------------------------------------------------------------------------------
--
-- File name: sql_monitor.sql
--
-- Purpose: shows statements execution errors based on sql_monitor view
--
-- Author: jpsaraiva
--
-- Version: 2017/10/27
--
-- Example: @sql_monitor.sql
--
-- Notes: 	Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

select 
    sql_exec_start,
    last_refresh_time,
    status,
    error_message,
    round(elapsed_time/1000000,0)  elapsed_time,
    username,
    sql_id,
    sql_text
from gv$sql_monitor where status like '%ERR%'
order by last_refresh_time desc;
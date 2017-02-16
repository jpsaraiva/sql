----------------------------------------------------------------------------------------
--
-- File name: list.sql
--
-- Purpose: List scripts available in repo
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @list.sql 
--
-- Notes: Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

-- grep -i purpose *.sql | grep -v list.sql | sed -e 's/:-- Purpose: /:/g' | awk -F: '{print "prompt "$1" # "$2}'

set pagesize 100 lines 220 pages 1000 heading on feed off null '' ver off

prompt activ.sql # Lists active sessions on RAC database
prompt idx_rebuild.sql # Finds indexes in need of rebuild based on their size compared to the table
prompt locks.sql # List blocking locks on RAC database
prompt mem_stats.sql # Memory stats for sql_id
prompt rman_execs.sql # List database backups
prompt tbl_fragmentation.sql # Forecast of table real size / fragmentation based on stats
prompt tbs_ocu.sql # List tablespace usage, takes in consideration autoextend values.
prompt tmp_ocu.sql # List temporary tablespace usage.
prompt xplan.sql # QoL script to show plan table after explain


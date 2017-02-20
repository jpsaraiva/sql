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
prompt asm_diskgroups.sql # List ASM diskgroups
prompt asm_disks.sql # List ASM disks
prompt dict.sql # Find tables in dictionary
prompt hwm_segments.sql # List segments occupying the HWM block on each datafile in a tablespace
prompt hwm_tbs.sql # Lists datafile HWM in a tablespace
prompt idx_rebuild.sql # Finds indexes in need of rebuild based on their size compared to the table
prompt locks.sql # List blocking locks on RAC database
prompt mem_stats.sql # Memory stats for sql_id
prompt rman_execs.sql # List database backups
prompt rman_progress.sql # Shows progress of database backup
prompt sch_job_actions.sql # Job action detail
prompt sch_job_details.sql # List scheduler job details
prompt sch_jobs.sql # List scheduled jobs
prompt sess_longops.sql # Lists longops running on the database
prompt sql_text.sql # Shows the text for a given sql_id
prompt tbl_fragmentation.sql # Forecast of table real size / fragmentation based on stats
prompt tbs_ocu.sql # List tablespace usage, takes in consideration autoextend values.
prompt tmp_ocu.sql # List temporary tablespace usage.
prompt xplan.sql # QoL script to show plan table after explain
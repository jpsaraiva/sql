----------------------------------------------------------------------------------------
--
-- File name: help.sql
--
-- Purpose: List scripts available in repo
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @help.sql 
--
-- Notes: Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

-- grep -i purpose *.sql | grep -v help.sql | sed -e 's/:-- Purpose: /:/g' | awk -F: '{print "prompt "$1" # "$2}'

set pagesize 100 lines 220 pages 1000 heading on feed off null '' ver off

prompt activ.sql                 #  Lists active sessions on RAC database
prompt activi.sql                #  Lists all sessions on RAC database
prompt asm_dg_disks.sql          #  List ASM disks assigned to diskgroups
prompt asm_diskgroups.sql        #  List ASM diskgroups
prompt asm_disks.sql             #  List all ASM disks
prompt awr_statsexec.sql         #  Gets executions stats from AWR tables for last 7 days
prompt awr_tbsgrowth.sql         #  Statistics on tablespace growth
prompt dg_gap.sql                #  Lists the content of v$archive_gap
prompt dg_mode.sql               #  Show recovery mode status
prompt dg_notapplied.sql         #  Identifies archive sequences not yet applied
prompt dg_sequence.sql           #  Compares difference in ORL with SRL
prompt dg_stats.sql              #  Lists v$dataguard_stats
prompt dg_status.sql             #  show database status in dataguard context
prompt dict.sql                  #  Find tables in dictionary
prompt fra_usage.sql             #  QoL script to check recovery area usage
prompt hwm_segments.sql          #  List segments occupying the HWM block on each datafile in a tablespace
prompt hwm_tbs.sql               #  Lists datafile HWM in a tablespace
prompt idx_framentation.sql      #  Identifies index fragmentation
prompt locks.sql                 #  List blocking locks on RAC database
prompt locks_exclusive.sql       #  List exclusive locks on database objects
prompt mem_stats.sql             #  Memory stats for sql_id
prompt process.sql               #  Displays SPID based on SID
prompt rman_execs.sql            #  List database backups
prompt rman_progress.sql         #  Shows progress of database backup
prompt sch_job_actions.sql       #  Job action detail
prompt sch_job_details.sql       #  List scheduler job details
prompt sch_jobs.sql              #  List scheduled jobs
prompt sess_events.sql           #  Lists events running on the database
prompt sess_longops.sql          #  Lists longops running on the database
prompt sess_rollback.sql         #  Shows sessions using rollback segments
prompt sess_tmp_usage.sql        #  List temporary usage by session.
prompt session.sql               #  Displays SID based on SPID
prompt sql_monitor.sql           #  shows statements execution errors based on sql_monitor view
prompt sql_plan.sql              #  Shows the plan for a given sql_id
prompt sql_text.sql              #  Shows the text for a given sql_id
prompt tbl_fragmentation.sql     #  Forecast of table real size / fragmentation based on stats
prompt tbs_files.sql             #  Lists files belonging to tablespace
prompt tbs_ocu.sql               #  List tablespace usage, takes in consideration autoextend values.
prompt tmp_ocu.sql               #  List temporary tablespace usage.
prompt undo.sql                  #  List undo usage
prompt xplan.sql                 #  QoL script to show plan table after explain



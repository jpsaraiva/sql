----------------------------------------------------------------------------------------
--
-- File name: sch_jobs.sql
--
-- Purpose: List scheduled jobs
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @sch_jobs.sql
--
-- Notes: 	Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

col owner                       format a15
col job_name                    format a30
col job_action         			format a30 word_wrapped
col "TYPE"						format a15
col next_run_date				format a25
col last_run_duration			format a30

select 
	  owner
	, job_name
	--, job_action
	, schedule_type "TYPE"
	, to_char(next_run_date,'YYYY-MM-DD HH24:MI:SS') next_run_date
	, last_run_duration
from dba_scheduler_jobs
where state <> 'DISABLED'
--and owner not in ('SYS','SYSTEM','OUTLN','DBSNMP','WMSYS','CTXSYS','XDB','PERFSTAT','EXFSYS','ORACLE_OCM') 				-- no system stuff
;
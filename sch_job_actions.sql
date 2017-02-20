----------------------------------------------------------------------------------------
--
-- File name: sch_job_actions.sql
--
-- Purpose: Job action detail
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @sch_job_actions < job_name >
--
-- Notes: 	Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

col job_action         			format a120 word_wrapped

select 
	job_action
from dba_scheduler_jobs
where job_name = '&1'
;
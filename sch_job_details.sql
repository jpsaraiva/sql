----------------------------------------------------------------------------------------
--
-- File name: sch_job_details.sql
--
-- Purpose: List scheduler job details
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @sch_job_details.sql
--
-- Notes: 	Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

col owner                       format a12
col job_name                    format a27
col status	                    format a10
col additional_info   			format a30 word_wrapped
col actual_start_date			format a19
col run_duration				format a15

select 
      owner
    , job_name
    , to_char(actual_start_date,'YYYY-MM-DD HH24:MI:SS') actual_start_date
	, status
    , run_duration
    , additional_info
from dba_scheduler_job_run_details
where log_date > trunc(sysdate)-10
and job_name='&1'
order by actual_start_date;
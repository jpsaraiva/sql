----------------------------------------------------------------------------------------
--
-- File name: mem_stats.sql
--
-- Purpose: QoL script to check recovery area usage
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

col file_type for a15

select file_type,percent_space_used,number_of_files from v$flash_recovery_area_usage where number_of_files > 0;

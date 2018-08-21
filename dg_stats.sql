----------------------------------------------------------------------------------------
--
-- File name: dg_stats.sql
--
-- Purpose: Lists v$dataguard_stats
--
-- Author: jpsaraiva
--
-- Version: 2017/05/16
--
-- Example: @dg_stats.sql
--
-- Notes: 	Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

select * from v$dataguard_stats;

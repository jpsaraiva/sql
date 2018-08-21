----------------------------------------------------------------------------------------
--
-- File name: dg_stats.sql
--
-- Purpose: show database status in dataguard context
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

select inst_id,name,open_mode,protection_mode,database_role from gv$database;

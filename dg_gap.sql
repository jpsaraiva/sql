----------------------------------------------------------------------------------------
--
-- File name: dg_gap.sql
--
-- Purpose: Lists the content of v$archive_gap
--
-- Author: jpsaraiva
--
-- Version: 2017/05/16
--
-- Example: @dg_gap.sql
--
-- Notes: 	Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

select * from v$archive_gap;

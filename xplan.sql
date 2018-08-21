----------------------------------------------------------------------------------------
--
-- File name: xplan.sql
--
-- Purpose: QoL script to show plan table after explain
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @xplan.sql
--
-- Notes: Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off
select * from table(dbms_xplan.display);
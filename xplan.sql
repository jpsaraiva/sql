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

set lines 200 pages 4000
select * from table(dbms_xplan.display);
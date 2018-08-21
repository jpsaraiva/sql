----------------------------------------------------------------------------------------
--
-- File name: dg_notapplied.sql
--
-- Purpose: Identifies archive sequences not yet applied
--
-- Author: jpsaraiva
--
-- Version: 2017/05/16
--
-- Example: @dg_notapplied.sql
--
-- Notes: 	Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

select THREAD#,SEQUENCE#,REGISTRAR,ARCHIVED,APPLIED,STATUS from V$ARCHIVED_LOG where APPLIED='NO';

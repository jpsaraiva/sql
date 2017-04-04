----------------------------------------------------------------------------------------
--
-- File name: sql_text.sql
--
-- Purpose: Shows the text for a given sql_id
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @sql_text.sql < sql_id >
--
-- Notes: 	Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off
set long 4000
column sql_fulltext format a120 word_wrapped

select sql_fulltext 
  from gv$sqlarea
 where sql_id='&1';

----------------------------------------------------------------------------------------
--
-- File name: dict.sql
--
-- Purpose: Find tables in dictionary
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @dict.sql < table_name >
--
-- Notes: Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

col table_name for a30
col comments for a80

select table_name,comments from dict where table_name like upper('%&1%');
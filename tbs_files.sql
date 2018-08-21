----------------------------------------------------------------------------------------
--
-- File name: tbs_files.sql
--
-- Purpose: Lists files belonging to tablespace
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @tbs_files.sql < tablespace_name >
--
-- Notes: 	Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

col file_name for a50
col tablespace_name for a20

SELECT file_id
     , file_name
     , bytes/1024/1024 m
     , maxbytes/1024/1024 max_m
     , autoextensible
     , increment_by/1024/1024*(select value from v$parameter where name like 'db_block_size') next_m
     , tablespace_name
FROM DBA_DATA_FILES 
WHERE tablespace_name='&1';
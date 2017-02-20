----------------------------------------------------------------------------------------
--
-- File name: hwm_tbs.sql
--
-- Purpose: Lists datafile HWM in a tablespace
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @hwm_tbs.sql < tablespace_name >
--
-- Notes: 	Developed and tested on 11.2.0.4.
--			RAC enabled
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

select distinct d.tablespace_name tbs,
                a.file_id id,
                a.file_name name,
                blocks*d.db_block_size/1024/1024 MB,
                hwm*d.db_block_size/1024/1024 hwm_mb, 
                (blocks-hwm+1)*d.db_block_size/1024/1024 shrink_possib_MB
    from (select file_id, file_name, blocks, tablespace_name from dba_data_files a ) a,
         (select file_id, max(block_id+blocks) hwm from dba_extents group by file_id ) b,
         (select tablespace_name, block_size db_block_size from dba_tablespaces) d
    where a.file_id = b.file_id and a.tablespace_name=d.tablespace_name
	and a.tablespace_name='&1';

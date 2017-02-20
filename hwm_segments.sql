----------------------------------------------------------------------------------------
--
-- File name: hwm_segments.sql
--
-- Purpose: List segments occupying the HWM block on each datafile in a tablespace
--
-- Author: jpsaraiva
--
-- Version: 2017/02/20
--
-- Example: @hwm_segments.sql 
--
-- Notes: Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

select 
    owner,
    segment_name,
    segment_type,
    (select file_name from dba_data_files b where b.file_id = a.file_id and b.relative_fno = b.relative_fno ) file_name
from (select owner, segment_name, segment_type, file_id, relative_fno, block_id, max(block_id) over (partition by file_id, relative_fno) max_block_id from dba_extents where tablespace_name='APPS_TS_TX_DATA') a
where block_id = max_block_id;
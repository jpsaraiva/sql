----------------------------------------------------------------------------------------
--
-- File name: tbl_framentation.sql
--
-- Purpose: Forecast of table real size / fragmentation based on stats
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @tbl_framentation.sql < schema >
--
-- Notes: Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

col owner 				for a15
col table_name 			for a30

select 
    t.owner,t.table_name
	-- , last_analyzed, num_rows, avg_row_len
    , round((t.blocks*8/1024),0) "estCurrSizeM"
    , round(s.bytes/1024/1024,0) "CurrSizeM"
    , round((num_rows*avg_row_len/1024/1024),0) "estRebuildSizeM"
    , round((s.bytes/1024/1024)-(num_rows*avg_row_len/1024/1024),0) "estFragmentationM",
    round(100-((num_rows*avg_row_len/1024/1024)*100/(s.bytes/1024/1024)),0) "Fragmentation%"    
from all_tables t left join dba_segments s on (s.owner=t.owner and s.segment_name=t.table_name)
where 1=1
and s.segment_type = 'TABLE'
and t.owner like 'NEO%'
and avg_row_len > 0 																					  -- not empty
and partitioned = 'NO'
and (select stale_stats from dba_tab_statistics where owner=t.owner and table_name = t.table_name) = 'NO' -- no stale stats
order by 1,2;
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
col "Allocated (Mb)" 	for 999999.99
col "Real (Mb)" 		for 999999.99
col "Frag (Mb)"			for 999999.99
col "(%)"				for 99.99
col num_rows			for 99999999
col avg_row_len			for 99999999

select * from (
select 
    owner,
    table_name,
    round((blocks*8/1024),2) "Alloc (Mb)",
    round((num_rows*avg_row_len/1024/1024),2) "Real (Mb)",
    round(((blocks*8)-(num_rows*avg_row_len/1024))/1024,2) "Frag (Mb)",
    round(round(((blocks*8)-(num_rows*avg_row_len/1024))/1024,2)*100/round((blocks*8/1024),2),2) "(%)", 
    last_analyzed,num_rows,avg_row_len
    --,(select round(bytes/1024/1024,2) from dba_segments where owner=t.owner and segment_name=t.table_name and segment_type = 'TABLE') "Segment Size (Mb)"    
from all_tables t
where 1=1
and owner  = '&1'
and avg_row_len > 0 																					  -- not empty
and partitioned = 'NO'
and (select stale_stats from dba_tab_statistics where owner=t.owner and table_name = t.table_name) = 'NO' -- no stale stats
order by 5 desc
) where rownum <= 10;
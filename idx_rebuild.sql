----------------------------------------------------------------------------------------
--
-- File name: idx_rebuild.sql
--
-- Purpose: Finds indexes in need of rebuild based on their size compared to the table
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @idx_rebuild.sql
--
-- Notes: Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

col owner 		for a15
col table_name 	for a30
col table_size 	for 99999.99
col index_name 	for a30
col index_size 	for 99999.99
col cmd 		for a100

select t.*,
    'alter index '||owner||'.'||index_name||' rebuild online;' cmd from (
select 
    ind.owner,
    ind.table_name,
    round(segtbl.bytes/1024/1024) table_size,
    ind.index_name,
    round(segidx.bytes/1024/1024) index_size
from dba_indexes ind 
    left join dba_segments segidx on (ind.owner=segidx.owner and ind.index_name=segidx.segment_name)
    left join dba_segments segtbl on (ind.owner=segtbl.owner and ind.table_name=segtbl.segment_name)
where 1=1 
and ind.owner not in ('SYS','SYSTEM','OUTLN','DBSNMP','WMSYS','CTXSYS','XDB','PERFSTAT') 				-- no system stuff
and partitioned = 'NO'
) t 
where t.index_size >= t.table_size 
and t.table_size > 5 																					-- only bigger then 5m
order by 5 desc;

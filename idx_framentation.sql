----------------------------------------------------------------------------------------
--
-- File name: idx_fragmention.sql
--
-- Purpose: Identifies index fragmentation
--
-- Author: 
--
-- Version: 2017/02/13
--
-- Example: @idx_fragmention.sql < schema_owner >
--
-- Notes: Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

col owner 		for a15
col table_name 	for a30
col index_name 	for a30
col sqlCMD		for a100


select a.owner owner, a.table_name table_name, a.index_name index_name
	, round(current_leaf_blocks * 8 / 1024,0) "estCurrSizeM"
	, round(segsize,0) "CurrSizeM"
	, round(index_leaf_estimate_if_rebuilt * 8 / 1024,0) "estRebuildSizeM"
	, round(segsize-(index_leaf_estimate_if_rebuilt * 8 / 1024),0) "estFragmentationM"
	, round(100-((index_leaf_estimate_if_rebuilt * 8 / 1024)*100/segsize)) "Fragmentation%"
	, 'alter index '||a.owner||'.'||a.index_name||' rebuild online' sqlCMD
from
(
select 
    owner,table_name, index_name, current_leaf_blocks
    , round (100 / 90 * (ind_num_rows * (rowid_length + uniq_ind + 4) + sum((avg_col_len) * (tab_num_rows) ) ) / (8192 - 192) ) as index_leaf_estimate_if_rebuilt
from (
select ind.owner,tab.table_name, tab.num_rows tab_num_rows , decode(tab.partitioned,'YES',10,6) rowid_length , ind.index_name, ind.index_type, ind.num_rows ind_num_rows, ind.leaf_blocks as current_leaf_blocks,
decode(uniqueness,'UNIQUE',0,1) uniq_ind,ic.column_name as ind_column_name, tc.column_name , tc.avg_col_len
from dba_tables tab
join dba_indexes ind on ind.owner=tab.owner and ind.table_name=tab.table_name
join dba_ind_columns ic on ic.table_owner=tab.owner and ic.table_name=tab.table_name and ic.index_owner=tab.owner and ic.index_name=ind.index_name
join dba_tab_columns tc on tc.owner=tab.owner and tc.table_name=tab.table_name and tc.column_name=ic.column_name
where ind.leaf_blocks is not null and ind.leaf_blocks > 1000
and ind.owner not in ('SYS','SYSTEM','SYSMAN','DBSNMP','PERFSTAT','DBAUSER','CTXSYS','MDSYS','XDB')
and ind.owner not like 'APEX%'
and ind.index_type = 'NORMAL'
and ind.num_rows > 0
) group by owner,table_name, index_name, current_leaf_blocks, ind_num_rows, uniq_ind, rowid_length
) a 
left join (select owner,segment_name,round(bytes/1024/1024,2) segsize from dba_segments where segment_type = 'INDEX') b on (a.owner=b.owner and a.index_name=b.segment_name) 
where a.owner like '&1'
where index_leaf_estimate_if_rebuilt/current_leaf_blocks < 0.5 --less than 50% fragmentation
and current_leaf_blocks - index_leaf_estimate_if_rebuilt > 131000 -- more than 15M? gain
order by index_leaf_estimate_if_rebuilt/current_leaf_blocks;
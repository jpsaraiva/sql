----------------------------------------------------------------------------------------
--
-- File name: undo.sql
--
-- Purpose: List undo usage
--
-- Author: jpsaraiva
--
-- Version: 2017/02/22
--
-- Example: @undo.sql
--
-- Notes: Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

col owner 				for a13
col tablespace_name 	for a30
col status 				for a10
col "TOTAL MB"			for 999999.99

select 
	  owner
	, tablespace_name
	, trunc(sum(bytes)/1024/1024,2) as "TOTAL MB"
	, status 
from dba_undo_extents
group by owner,tablespace_name,status
order by 3,4;
----------------------------------------------------------------------------------------
--
-- File name: tmp_ocu.sql
--
-- Purpose: List temporary tablespace usage.
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @tmp_ocu.sql
--
-- Notes: Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

col tablespace_name 	for a30
col status 				for a10
col "TOTAL MB"			for 999999.99
col "USED MB"			for 999999.99
col "FREE MB"			for 999999.99
col "CURRENT USERS"		for 999999

select
        t.TABLESPACE_NAME,
        t.status,
        sum(TOTAL_BLOCKS*b.bs/1024/1024) "TOTAL MB",
        sum(used_blocks*b.bs/1024/1024) "USED MB",
        sum(FREE_BLOCKS*b.bs/1024/1024) "FREE MB",
        sum(CURRENT_USERS) "CURRENT USERS"        
from gv$sort_segment s,
    (SELECT tablespace_name, status, sum(bytes)/1024/1024 total FROM dba_temp_files GROUP BY tablespace_name, status) t,
    (select value bs from v$parameter where name='db_block_size') b
where s.tablespace_name(+)=t.tablespace_name
group by
        t.TABLESPACE_NAME,
        t.status,
        t.total;
----------------------------------------------------------------------------------------
--
-- File name: awr_tbsgrowth.sql
--
-- Purpose: Statistics on tablespace growth
--
-- Author: jpsaraiva
--
-- Version: 2017/11/15
--
-- Example: @awr_tbsgrowth.sql < tablespace_name >
--
-- Notes: 	Developed and tested on 11.2.0.4.
--			Requires Diagnostics Pack Licensing
--
---------------------------------------------------------------------------------------
--

set lines 220 pages 4000
col tablespace_name for a20
col ts_size for 999999999
col ts_maxsize for 999999999
col ts_usedsize for 999999999
variable bs number;
begin
select value into :bs from v$parameter where name = 'db_block_size';
end;
/
select 
    to_char(snap.begin_interval_time,'YYYY-MM-DD') day,
    to_char(snap.begin_interval_time,'HH24') hour,
    ts.tsname,ts.contents,
    tsu.tablespace_size * :bs / 1024 / 1024 ts_size,
    tsu.tablespace_maxsize * :bs / 1024 / 1024 ts_maxsize,
    tsu.tablespace_usedsize * :bs / 1024 / 1024 ts_usedsize
from
DBA_HIST_TBSPC_SPACE_USAGE tsu, DBA_HIST_TABLESPACE_STAT ts, DBA_HIST_SNAPSHOT snap
where 1=1
and snap.snap_id=ts.snap_id and snap.snap_id=tsu.snap_id
and tsu.tablespace_id=ts.ts#
and ts.tablespace_name = '&1'
and snap.instance_number = ts.instance_number
and ts.instance_number = 1
order by 1,2;
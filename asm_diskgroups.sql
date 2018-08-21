----------------------------------------------------------------------------------------
--
-- File name: asm_diskgroups.sql
--
-- Purpose: List ASM diskgroups
--
-- Author: jpsaraiva
--
-- Version: 2017/02/20
--
-- Example: @asm_diskgroups.sql
--
-- Notes: Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

col group_number	for 9999999
col name 			for a20
col state 			for a10
col type 			for a10
col total_mb 		for 999,999,999
col free_mb 		for 999,999,999
col pct_used    	for 999.99 HEAD '(%) Used'

select    dg.group_number
		, dg.name
--		, dg.compatibility, dg.database_compatibility 
		, dg.state
		, dg.type
		, dg.total_mb
		, dg.free_mb
		, CASE WHEN free_mb = 0 THEN 0 ELSE ROUND((1- (free_mb / total_mb))*100, 2) END pct_used
		, dg.OFFLINE_DISKS
from v$asm_diskgroup dg
/


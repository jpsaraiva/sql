----------------------------------------------------------------------------------------
--
-- File name: asm_disks.sql
--
-- Purpose: List ASM disks
--
-- Author: jpsaraiva
--
-- Version: 2017/02/20
--
-- Example: @asm_disks.sql ([opt:] < diskgroup >)
--
-- Notes: Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

undefine param
column 1 new_value 1 noprint
select '' "1" from dual where rownum = 0;
define param = &1 null

col path 	format 	a35
col name 	format 	a20
col	"SIZE" 	format	999,999,999
break on "DG NAME"

select    g.name		"DG NAME"
		, d.path
        , d.name
		, d.header_status 
        , d.os_mb 		"SIZE"
        from v$asm_diskgroup_stat g, v$asm_disk_stat d
where d.group_number=g.group_number(+)
and (('&param' is not null and g.name = '&param') or ('&param' = 'null'))
order by g.name,d.failgroup,d.path
;

undefine 1 param
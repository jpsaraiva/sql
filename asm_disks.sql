----------------------------------------------------------------------------------------
--
-- File name: asm_disks.sql
--
-- Purpose: List all ASM disks
--
-- Author: jpsaraiva
--
-- Version: 2017/02/20
--
-- Example: @asm_disks.sql
--
-- Notes: Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

set pages 4000
set lines 220
col path for a30
col gn for 999
col dn for 999
col "DG NAME" format a30
col "DISK NAME" format a30
col name for a15
SELECT
     group_number gn
    ,disk_number dn
    ,name
    ,os_mb
    --,compound_index
    --,incarnation
    ,mount_status
    ,header_status
    ,mode_status
    ,state
    ,redundancy
    ,path
  FROM v$asm_disk
order by name;

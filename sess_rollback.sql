----------------------------------------------------------------------------------------
--
-- File name: sess_rollback.sql
--
-- Purpose: Shows sessions using rollback segments
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @sess_rollback.sql
--
-- Notes: 	Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

column sse        format a15
column "Rollback Usage"  format a35 word_wrapped
column "Status"          format a8 word_wrapped
column USERNAME          format a8
column Size(MB)          format 999,990.00


SELECT s.sid||','||s.serial#||'@'||s.inst_id||'' sse
      , s.username      
      , t.start_time "Start" 
      , t.status "Status"
      , s.sql_id
      , ((t.used_ublk*8192)/1024/1024) "Size(MB)"
      ,t.used_ublk||' Blocks and '||t.used_urec||' Records' "Rollback Usage"
   from dba_data_files df
      , dba_extents e
      , gv$session s
      , gv$transaction t
  where df.tablespace_name = e.tablespace_name 
		and s.inst_id = t.inst_id
        and df.file_id = ubafil 
        and s.saddr = t.ses_addr 
        and t.ubablk between e.block_id and e.block_id+e.blocks 
        and e.segment_type in ( 'ROLLBACK','TYPE2 UNDO');
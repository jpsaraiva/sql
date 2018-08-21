----------------------------------------------------------------------------------------
--
-- File name: sess_tmp_usage.sql
--
-- Purpose: List temporary usage by session.
--
-- Source http://www.oracle-wiki.net/startsqldisplaytempspcuser
--
-- Example: @sess_tmp_usage.sql
--
-- Notes: 
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

COLUMN tablespace FORMAT A20
COLUMN temp_size FORMAT A20
COLUMN sid_serial FORMAT A20
COLUMN username FORMAT A20
COLUMN program FORMAT A50

SELECT b.tablespace,
       ROUND(((b.blocks*p.value)/1024/1024),2) AS temp_size_m,
       a.inst_id as Instance,
       a.sid||','||a.serial# AS sid_serial,
       NVL(a.username, '(oracle)') AS username,
       a.program,
       a.status,
       a.sql_id
FROM   gv$session a,
       gv$sort_usage b,
       gv$parameter p
WHERE  p.name  = 'db_block_size'
AND    a.saddr = b.session_addr
AND    a.inst_id=b.inst_id
AND    a.inst_id=p.inst_id
ORDER BY 2 desc
/
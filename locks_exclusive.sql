----------------------------------------------------------------------------------------
--
-- File name: locks.sql
--
-- Purpose: List exclusive locks on database objects
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @locks.sql
--
-- Notes: Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

col  "BLKING USER" 		for a15 word_wrapped
col  "BLKING SESS" 		for a15
col  "BLKING SQLID" 	for a15
col  "BLKING STATUS" 	for a15
col  "BLKING SQL ID" 	for a15
col  "LAST ACTIVE"		for a15
col  "BLKED USER" 		for a15 word_wrapped
col  "BLKED SQL ID" 	for a15

select 
    s.sid || ',' || s.serial# || ',@' || s.inst_id "SESS",
    substr(l.oracle_username,1,8) ora_user,
    substr(o.owner||'.'||o.object_name,1,40) object,
    p.spid os_pid,
    decode(l.locked_mode, 0,'NONE',
        1,'NULL',
        2,'ROW SHARE',
        3,'ROW EXCLUSIVE',
        4,'SHARE',
        5,'SHARE ROW EXCLUSIVE',
        6,'EXCLUSIVE',
        null) lock_mode
from gv$locked_object l, dba_objects o, gv$session s, gv$process p
where l.object_id = o.object_id
and l.inst_id = s.inst_id
and l.session_id = s.sid
and s.inst_id = p.inst_id
and s.paddr = p.addr(+)
order by l.inst_id ;
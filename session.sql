----------------------------------------------------------------------------------------
--
-- File name: session.sql
--
-- Purpose: Displays SID based on SPID
--
-- Author: jpsaraiva
--
-- Version: 2017/05/16
--
-- Example: @session.sql < spid > < instance >
--
-- Notes: 	Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

undefine spid 
undefine instance
column 1 new_value 1 noprint
select '' "1" from dual where rownum = 0;
define spid = &1 null
define instance = &2 null

select s.inst_id INST_ID, s.sid SID, p.spid SPID
from gv$session s, gv$process p
where p.spid = &spid and s.inst_id = &instance
and s.paddr = p.addr and s.inst_id = p.inst_id;

undefine spid
undefine instance
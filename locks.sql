----------------------------------------------------------------------------------------
--
-- File name: locks.sql
--
-- Purpose: List blocking locks on RAC database
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

set lines 220 pages 4000

col  "BLOCKING USER" 		for a30
col  "BLOCKING SESSION" 	for a15
col  "BLOCKING SQL ID" 		for a8
col  "BLOCKING STATUS" 		for a15
col  "BLOCKING SQL ID" 		for a15
col  "LAST ACTIVE"		 	for a15
col  "BLOCKED USER" 		for a30
col  "BLOCKED SESSION" 		for a15
col  "BLOCKED STATUS" 		for a15
col  "BLOCKED SQL ID" 		for a15

SELECT 
    distinct 
        s1.username || '@' || s1.machine "BLOCKING USER",
        s1.sid || ',' || s1.serial# || '@' || s1.inst_id "BLOCKING SESSION",
        s1.status "BLOCKING STATUS", s1.sql_id "BLOCKING SQL ID",
        lpad(trunc(s1.last_call_et/86400),2,0)||' '||
        lpad(trunc((s1.last_call_et/86400-trunc(s1.last_call_et/86400))*24),2,0)||':'||
        lpad (trunc((s1.last_call_et/3600-trunc(s1.last_call_et/3600))*60),2,0)||':'||
        lpad(trunc(((s1.last_call_et/3600-trunc(s1.last_call_et/3600))*60-trunc((s1.last_call_et/3600-trunc(s1.last_call_et/3600))*60))*60),2,0) "LAST ACTIVE",
        s2.username || '@' || s2.machine "BLOCKED USER",
        s2.sid || ',' || s2.serial# || '@' || s2.inst_id "BLOCKED SESSION",
        s2.status "BLOCKED STATUS", s2.sql_id "BLOCKED SQL ID"
  FROM GV$LOCK l1
     , GV$SESSION s1
     , GV$LOCK l2
     , GV$SESSION s2
 WHERE s1.sid=l1.sid 
   AND s2.sid=l2.sid
   AND s1.inst_id=l1.inst_id 
   AND s2.inst_id=l2.inst_id
   AND l1.block > 0 
   AND l2.request > 0
   AND l1.id1 = l2.id1 
   AND l1.id2 = l2.id2;


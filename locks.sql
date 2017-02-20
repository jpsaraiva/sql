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

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

col  "BLKING USER" 		for a15 word_wrapped
col  "BLKING SESS" 		for a15
col  "BLKING SQLID" 	for a15
col  "BLKING STATUS" 	for a15
col  "BLKING SQL ID" 	for a15
col  "LAST ACTIVE"		for a15
col  "BLKED USER" 		for a15 word_wrapped
col  "BLKED SQL ID" 	for a15

break on "BLKING USER" on "BLKING SESS" on "BLKING STATUS" on "BLKING SQLID" on "LAST ACTIVE"

SELECT 
    distinct 
        s1.username || '@' || s1.machine "BLKING USER",
        s1.sid || ',' || s1.serial# || '@' || s1.inst_id "BLKING SESS",
        s1.status "BLKING STATUS", nvl(s1.sql_id,s1.prev_sql_id) "BLKING SQLID",
        lpad(trunc(s1.last_call_et/86400),2,0)||' '||
        lpad(trunc((s1.last_call_et/86400-trunc(s1.last_call_et/86400))*24),2,0)||':'||
        lpad (trunc((s1.last_call_et/3600-trunc(s1.last_call_et/3600))*60),2,0)||':'||
        lpad(trunc(((s1.last_call_et/3600-trunc(s1.last_call_et/3600))*60-trunc((s1.last_call_et/3600-trunc(s1.last_call_et/3600))*60))*60),2,0) "LAST ACTIVE",
        s2.username || '@' || s2.machine "BLKED USER",
        s2.sql_id "BLKED SQLID"
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
   AND l1.id2 = l2.id2
   order by 1,2,3,4;


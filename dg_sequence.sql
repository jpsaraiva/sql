----------------------------------------------------------------------------------------
--
-- File name: dg_sequence.sql
--
-- Purpose: Compares difference in ORL with SRL
--
-- Author: jpsaraiva
--
-- Version: 2017/05/16
--
-- Example: @dg_gap.sql
--
-- Notes: 	Developed and tested on 11.2.0.4.
--			Only works if there is connectivity between primary and standby
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

select l.thread# thread#,l.seq primary_seq,s.seq standby_seq from
(select thread#,max(sequence#) seq from v$log group by thread#) l,
(select thread#,max(sequence#) seq from v$standby_log where status='ACTIVE' group by thread#) s
where l.thread#=s.thread#
order by 1;


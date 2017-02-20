----------------------------------------------------------------------------------------
--
-- File name: tbs_ocu.sql
--
-- Purpose: List tablespace usage, takes in consideration autoextend values.
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @tbs_ocu.sql ([opt:] < tablespace_name >)
--
-- Notes: Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

col tablespace_name 	for a30
col total 				for a6
col used 				for a6
col free				for a6
col "%USED"				for 99,99
col severity			for a10
col total_m				for 999999,99
col used_m				for 999999,99
col free_m				for 999999,99

undefine param
column 1 new_value 1 noprint
select '' "1" from dual where rownum = 0;
define param = &1 null

select 
tablespace_name,
case 
    when total < power(1024,1) then trunc(total/power(1024,0),1) || 'b'
    when total < power(1024,2) then trunc(total/power(1024,1),1) || 'K'
    when total < power(1024,3) then trunc(total/power(1024,2),1) || 'M'
    when total < power(1024,4) then trunc(total/power(1024,3),1) || 'G'
    when total < power(1024,5) then trunc(total/power(1024,4),1) || 'T'
end "TOTAL",
case 
    when used < power(1024,1) then trunc(used/power(1024,0),1) || 'b'
    when used < power(1024,2) then trunc(used/power(1024,1),1) || 'K'
    when used < power(1024,3) then trunc(used/power(1024,2),1) || 'M'
    when used < power(1024,4) then trunc(used/power(1024,3),1) || 'G'
    when used < power(1024,5) then trunc(used/power(1024,4),1) || 'T'
end "USED",
case 
    when NVL(free,0) < power(1024,1) then trunc(NVL(free,0)/power(1024,0),1) || 'b'
    when NVL(free,0) < power(1024,2) then trunc(NVL(free,0)/power(1024,1),1) || 'K'
    when NVL(free,0) < power(1024,3) then trunc(NVL(free,0)/power(1024,2),1) || 'M'
    when NVL(free,0) < power(1024,4) then trunc(NVL(free,0)/power(1024,3),1) || 'G'
    when NVL(free,0) < power(1024,5) then trunc(NVL(free,0)/power(1024,4),1) || 'T'
end "FREE",
trunc(used*100/total,1) "%USED",
case 
when (total > threshold) and (free > limite*1.1) then 'NORMAL' -- special cases
when (total > threshold) and (free between limite*0.9 and limite*1.1) then 'WARNING'  -- special cases
when (total > threshold) and (free < limite*0.9) then 'CRITICAL'  -- special cases
when (used*100/total) > critical then 'CRITICAL'
when (used*100/total) > warning then 'WARNING'
else 'NORMAL'
end "SEVERITY"
,trunc(total/power(1024,2),1) "TOTAL_M"
,trunc(used/power(1024,2),1) "USED_M"
,trunc(free/power(1024,2),1) "FREE_M"
from (
SELECT DISTINCT 
t.tablespace_name "TABLESPACE_NAME",
case when (t.max > t.total) then t.max else t.total end "TOTAL",
t.total-NVL(f.free,0) "USED",
case when (t.max > t.total) then NVL(f.free,0)+t.max-t.total else NVL(f.free,0) end "FREE",
power(1024,4) "THRESHOLD", 100*power(1024,3) "LIMITE", 85 "WARNING", 90 "CRITICAL" 
FROM 
(SELECT tablespace_name ,sum(bytes) total, sum(decode(maxbytes,0,bytes,maxbytes)) max FROM dba_data_files where tablespace_name in (select tablespace_name from dba_tablespaces where contents='PERMANENT' and status='ONLINE') GROUP BY tablespace_name) t,
(SELECT tablespace_name ,sum(bytes) free FROM dba_free_space GROUP BY tablespace_name) f
WHERE t.tablespace_name = f.tablespace_name(+) 
) 
where ('&param' is not null and tablespace_name = '&param') or ('&param' = 'null')
order by 1 desc;

undefine 1 param
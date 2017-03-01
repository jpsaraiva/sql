----------------------------------------------------------------------------------------
--
-- File name: sql_plan.sql
--
-- Purpose: Shows the plan for a given sql_id
--
-- Author: jpsaraiva
--
-- Version: 2017/02/13
--
-- Example: @sql_plan.sql < sql_id >
--
-- Notes: 	Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

col I			for 9
col PHV 		for 9999999999
col operation 	for a16
col options 	for a15
col owner 		for a8
col object_name for a15
col object_type for a14
col cost 		for 9999999
col cardinality	for 99999999

select 
	inst_id I
	, plan_hash_value PHV
	, operation
	, options
	, object_owner owner
	, object_name
	, object_type
	, cost 
	, cardinality
	, bytes
from gv$sql_plan where sql_id='&1' order by id;
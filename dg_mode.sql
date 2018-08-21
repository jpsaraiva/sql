----------------------------------------------------------------------------------------
--
-- File name: dg_mode.sql
--
-- Purpose: Show recovery mode status
--
-- Author: jpsaraiva
--
-- Version: 2017/05/16
--
-- Example: @dg_mode.sql
--
-- Notes: 	Developed and tested on 11.2.0.4.
--
---------------------------------------------------------------------------------------
--

set pagesize 100 lines 120 pages 1000 heading on feed off null '' ver off

COL DEST_NAME FOR A30

SELECT DEST_ID,DEST_NAME,STATUS,TYPE,SRL,RECOVERY_MODE FROM V$ARCHIVE_DEST_STATUS WHERE DEST_ID=1;

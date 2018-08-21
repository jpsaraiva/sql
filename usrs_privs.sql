SET LINESIZE 160
SET PAGESIZE 9999
set echo off
set verify off
set pages 200
col granted_role form a35
col owner form a12
col table_name form a35
col privilege form a35

prompt 
prompt +----------------------------------------------------+
prompt | List user Priviliges                               |
prompt +----------------------------------------------------+

ACCEPT username  prompt 'Enter Username : '

spool user_privs.log

PROMPT Roles granted to user

SELECT granted_role,admin_option,default_role
FROM dba_role_privs
WHERE grantee=UPPER('&username');

PROMPT Table Privileges granted to a user through roles

SELECT granted_role, owner, table_name, privilege
FROM ( SELECT granted_role
     FROM dba_role_privs WHERE grantee=UPPER('&username')
       UNION
       SELECT granted_role
     FROM role_role_privs
     WHERE role in (SELECT granted_role
                FROM dba_role_privs WHERE grantee=UPPER('&username')
               )
    ) roles, dba_tab_privs
WHERE granted_role=grantee;

PROMPT System Privileges assigned to a user through roles

SELECT granted_role, privilege
FROM ( SELECT granted_role
     FROM dba_role_privs WHERE grantee=UPPER('&username')
       UNION
       SELECT granted_role
     FROM role_role_privs
     WHERE role in (SELECT granted_role
                FROM dba_role_privs WHERE grantee=UPPER('&username')
               )
    ) roles, dba_sys_privs
WHERE granted_role=grantee;

PROMPT Table privileges assigned directly to a user

SELECT owner, table_name, privilege
FROM dba_tab_privs
WHERE grantee=UPPER('&username');

PROMPT System privileges assigned directly to a user
SELECT privilege, admin_option
FROM  dba_sys_privs
WHERE grantee=UPPER('&username');

spool off
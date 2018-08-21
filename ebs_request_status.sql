select 
    r.request_id reqid
    , pr.concurrent_process_id
    , to_char(r.actual_start_date, 'DD-MON-YY HH24:MI:SS') start_time
    , u.user_name
    --, r.phase_code phase
    --, r.status_code status
    , decode(r.phase_code, 'C', 'Completed', 'I', 'Inactive', 'P', 'Pending', 'R', 'Running', 'NAN') phase_code
    , decode(r.status_code, 'A', 'Waiting', 'B', 'Resuming', 'C', 'Normal', 'D', 'Cancelled', 'E','Error','F','Scheduled','G','Warning','H','On Hold','I','Normal','M','No Manager','Q','Standby','R','Normal','S','Suspended','T','Terminating','U','Disabled','W','Paused','X','Terminated','Z','Waiting', 'NAN') status_code
    , floor(((SYSDATE - r.actual_start_date)*24*60*60)/3600) hrs,
        floor((((SYSDATE - r.actual_start_date)*24*60*60) - floor(((SYSDATE - r.actual_start_date)*24*60*60)/3600)*3600)/60) mins,
        round((((SYSDATE - r.actual_start_date)*24*60*60) - floor(((SYSDATE - r.actual_start_date)*24*60*60)/3600)*3600 - (floor((((SYSDATE - r.actual_start_date)*24*60*60) - floor(((SYSDATE - r.actual_start_date)*24*60*60)/3600)*3600)/60)*60) )) secs
    , round((SYSDATE - r.actual_start_date)*24*60) Tot_Mins
    --, cp.concurrent_program_id progid
    , decode(p.user_concurrent_program_name,
       'Request Set Stage', 'RSS - '||r.description,
       'Report Set', 'RS - '||r.description,
       p.user_concurrent_program_name ) program_name
    , q.concurrent_queue_name
    , s.sid
    , s.serial#
    , s.status
    , s.last_call_et
from   v$session s
       , apps.fnd_user u
       , apps.fnd_concurrent_processes pr
       , apps.fnd_concurrent_programs_vl p
       , apps.fnd_concurrent_requests r
       , applsys.fnd_concurrent_queues q
where s.process = pr.os_process_id
and pr.concurrent_process_id = r.controlling_manager
and pr.concurrent_queue_id = q.concurrent_queue_id
and r.phase_code in ('R') -- and r.status_code = 'R'
and r.requested_by = u.user_id
and p.concurrent_program_id = r.concurrent_program_id
order by 2 desc
/
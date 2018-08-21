 select
   concurrent_queue_name,
   running_processes
from
   applsys.fnd_concurrent_queues
where concurrent_queue_name = '&1';
class icinga::nrpe::default_comands {
  require Class
  icinga::nrpe::command{[
    'check_cpu',
    'check_memory',
    'check_load',
    'check_swap',
  ]:}
  icinga::nrpe::command{
    'check_disk_all':
      command => 'check_disk -w $ARG1$ -c $ARG2$';
    'check_disk':
      command => 'check_disk -w $ARG1$ -c $ARG2$ -p $ARG3$',
    'check_proc':
      command => 'check_procs -w $ARG1$ -c $ARG2$ -C $ARG3$',
    'check_procs'
      command => 'check_procs -w $ARG1$ -c $ARG2$ -s $ARG3$',
  }
}

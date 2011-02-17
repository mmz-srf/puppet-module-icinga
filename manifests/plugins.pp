class icinga::plugins {
  package{'nagios-plugins-all':
    ensure => present,
  }
  icinga::plugin{[
    'check_cpu',
    'check_memory',
  ]:}
}

class icinga::plugins {
  package{[
    'perl-Nagios-Plugin',
    'nagios-plugins-all',
  ]:
    ensure => present,
  }
  icinga::plugin{[
    'check_cpu',
    'check_memory',
  ]:}
}

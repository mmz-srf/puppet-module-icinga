class icinga::plugins {
  package{'nagios-plugins-all':
    ensure => present,
  }
}

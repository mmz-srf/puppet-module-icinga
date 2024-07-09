class icinga::plugins::debian {
  package{'nagios-plugins':
    name   => 'monitoring-plugins',
    ensure => present,
  }
}

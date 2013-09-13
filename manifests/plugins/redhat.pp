class icinga::plugins::redhat {
  package{'nagios-plugins':
    name   => 'nagios-plugins-all',
    ensure => present,
  }
}

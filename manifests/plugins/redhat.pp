class icinga::plugins::debian {
  package{'nagios-plugins':
    name => 'nagios-plugins-all'
    ensure => present,
  }
}
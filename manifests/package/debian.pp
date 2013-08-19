class icinga::package::debian {
  package{[
    'nagios-nrpe-plugin',
  ]:
    ensure => present,
  }
  package{'nagios-plugins':
    name => 'nagios-plugins',
    ensure => present,
  }
}
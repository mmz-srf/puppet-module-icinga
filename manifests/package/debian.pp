class icinga::package::debian {
  package{[
    'nagios-nrpe-plugin',
  ]:
    ensure => present,
  }
}
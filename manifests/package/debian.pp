class icinga::package::debian {
  package{[
    'nagios-nrpe-plugin',
    'python-yaml', # needed for plugin check_puppetagent
  ]:
    ensure => present,
  }
}
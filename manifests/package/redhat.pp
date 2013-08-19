class icinga::package::debian {
  package{[
    'icinga-api',
    'libdbi-dbd-mysql',
    'libdbi-dbd-pgsql',
    'nagios-plugins-nrpe',
    'perl-Nagios-Plugin',
  ]:
    ensure => present,
  }
  package{'nagios-plugins':
    name => 'nagios-plugins-all'
    ensure => present,
  }
}
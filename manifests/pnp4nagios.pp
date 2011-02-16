class icinga::pnp4nagios {
  package{'pnp4nagios':
    ensure => present,
  }
  file{'/var/icinga/spool':
    ensure => directory,
    require => Package['icinga'],
    owner => icinga, group => icinga, mode => 0755;
  }
}

class icinga::pnp4nagios {
  package{'pnp4nagios':
    ensure => present,
  }
  file{
    '/etc/pnp4nagios/npcd.cfg':
      source => [
        "puppet://$server/modules/site-icinga/pnp4nagios/$fqdn/npcd.cfg",
        "puppet://$server/modules/site-icinga/pnp4nagios/npcd.cfg",
        "puppet://$server/modules/icinga/pnp4nagios/npcd.cfg",
      ],
      require => Package['icinga'],
      owner => icinga, group => icinga, mode => 0755;
  }
  file{[
    '/var/icinga/spool',
    '/var/lib/pnp4nagios',
  ]:
      ensure => directory,
      require => Package['icinga'],
      owner => icinga, group => icinga, mode => 0755;
  }
}

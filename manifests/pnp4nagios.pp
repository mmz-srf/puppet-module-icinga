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
      owner => root, group => root, mode => 0444;
    '/usr/share/icinga-web/app/modules/Cronks/data/xml/grid/icinga-host-template.xml':
      source => "puppet://$server/modules/icinga/pnp4nagios/icinga-host-template.xml",
      require => Package['icinga-web'],
      owner => root, group => root, mode => 0644;
    '/usr/share/icinga-web/app/modules/Cronks/data/xml/grid/icinga-service-template.xml':
      source => "puppet://$server/modules/icinga/pnp4nagios/icinga-service-template.xml",
      require => Package['icinga-web'],
      owner => root, group => root, mode => 0644;
    '/usr/share/icinga-web/app/modules/Cronks/config/cronks.xml':
      source => "puppet://$server/modules/icinga/pnp4nagios/cronks.xml",
      require => Package['icinga-web'],
      owner => root, group => root, mode => 0644;
  }
  file{[
    '/var/icinga/spool',
    '/var/lib/pnp4nagios',
  ]:
      ensure => directory,
      require => Package['icinga'],
      owner => icinga, group => icinga, mode => 0755;
  }
  exec{'icinga-web_clearcache':
    command => '/usr/share/icinga-web/bin/clearcache.sh',
    refreshonly => true,
    require => Package['icinga-web'],
    subscribe => [
      File[
        '/usr/share/icinga-web/app/modules/Cronks/data/xml/grid/icinga-host-template.xml',
        '/usr/share/icinga-web/app/modules/Cronks/data/xml/grid/icinga-service-template.xml',
        '/usr/share/icinga-web/app/modules/Cronks/config/cronks.xml'
      ]
    ]
  }
}

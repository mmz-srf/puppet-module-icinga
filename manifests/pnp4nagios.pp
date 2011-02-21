class icinga::pnp4nagios {
  package{'pnp4nagios':
    ensure => present,
  }
  nagios_command{'process-service-perfdata-file':
    command_line => '/usr/bin/perl /usr/libexec/pnp4nagios/process_perfdata.pl --bulk=/var/icinga/spool/service-perfdata',
    require => Package['pnp4nagios'],
  }
  nagios_command{'process-host-perfdata-file':
    command_line => '/usr/bin/perl /usr/libexec/pnp4nagios/process_perfdata.pl --bulk=/var/icinga/spool/host-perfdata',
    require => Package['pnp4nagios'],
  }
  file{
    '/etc/pnp4nagios/npcd.cfg':
      source => [
        "puppet://$server/modules/site-icinga/pnp4nagios/$fqdn/npcd.cfg",
        "puppet://$server/modules/site-icinga/pnp4nagios/npcd.cfg",
        "puppet://$server/modules/icinga/pnp4nagios/npcd.cfg",
      ],
      require => Package['pnp4nagios'],
      owner => root, group => root, mode => 0444;
    '/etc/httpd/vhosts.d/pnp4nagios.conf':
      source => [
        "puppet://$server/modules/site-icinga/pnp4nagios/$fqdn/apache.conf",
        "puppet://$server/modules/site-icinga/pnp4nagios/apache.conf",
        "puppet://$server/modules/icinga/pnp4nagios/apache.conf",
      ],
      notify => Service['httpd'],
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

class icinga::objects {
  include icinga::defaults

  $objects = {
    command
      => "$icinga::cfgdir/objects/commands.cfg",
    contact
      => "$icinga::cfgdir/objects/contacts.cfg",
    contactgroup
      => "$icinga::cfgdir/objects/contactgroups.cfg",
    host
      => "$icinga::cfgdir/objects/hosts.cfg",
    hostextinfo
      => "$icinga::cfgdir/objects/hostextinfos.cfg",
    hostgroup
      => "$icinga::cfgdir/objects/hostgroups.cfg",
    service
      => "$icinga::cfgdir/objects/services.cfg",
    servicedependency
      => "$icinga::cfgdir/objects/servicedependencies.cfg",
    serviceescalation
      => "$icinga::cfgdir/objects/serviceescalations.cfg",
    serviceextinfo
      => "$icinga::cfgdir/objects/serviceextinfos.cfg",
    timeperiod
      => "$icinga::cfgdir/objects/timeperiods.cfg",
  }

  file{[
    $objects['command'],
    $objects['contact'],
    $objects['contactgroup'],
    $objects['host'],
    $objects['hostextinfo'],
    $objects['hostgroup'],
    $objects['service'],
    $objects['servicedependency'],
    $objects['serviceescalation'],
    $objects['serviceextinfo'],
    $objects['timeperiod'],
  ]:
    ensure => present,
    replace => false,
    require => Package['icinga'],
    notify => Service['icinga'],
    owner => root, group => root, mode => 0444;
  }

  Nagios_command <<||>>
  Nagios_contact <<||>>
  Nagios_contactgroup <<||>>
  Nagios_host <<||>>
  Nagios_hostextinfo <<||>>
  Nagios_hostgroup <<||>>
  Nagios_service <<||>>
  Nagios_servicedependency <<||>>
  Nagios_serviceescalation <<||>>
  Nagios_serviceextinfo <<||>>
  Nagios_timeperiod <<||>>

  Nagios_command <||> {
    target => $objects['command'],
    require => Package['icinga'],
    notify => Service['icinga'],
  }
  Nagios_contact <||> {
    target => $objects['contact'],
    require => Package['icinga'],
    notify => Service['icinga'],
  }
  Nagios_contactgroup <||> {
    target => $objects['contactgroup'],
    require => Package['icinga'],
    notify => Service['icinga'],
  }
  Nagios_host <||> {
    target => $objects['host'],
    require => Package['icinga'],
    notify => Service['icinga'],
  }
  Nagios_hostextinfo <||> {
    target => $objects['hostgroup'],
    require => Package['icinga'],
    notify => Service['icinga'],
  }
  Nagios_hostgroup <||> {
    target => $objects['hostgroup'],
    require => Package['icinga'],
    notify => Service['icinga'],
  }
  Nagios_service <||> {
    target => $objects['service'],
    require => Package['icinga'],
    notify => Service['icinga'],
  }
  Nagios_servicedependency <||> {
    target => $objects['servicedependency'],
    require => Package['icinga'],
    notify => Service['icinga'],
  }
  Nagios_serviceescalation <||> {
    target => $objects['serviceescalation'],
    require => Package['icinga'],
    notify => Service['icinga'],
  }
  Nagios_serviceextinfo <||> {
    target => $objects['serviceextinfo'],
    require => Package['icinga'],
    notify => Service['icinga'],
  }
  Nagios_timeperiod <||> {
    target => $objects['timeperiod'],
    require => Package['icinga'],
    notify => Service['icinga'],
  }

  # purge unmanaged icinga cfg files
  # must be defined after exported resource overrides and cfg file defs
  file{"$icinga::cfgdir/objects/":
    source => "puppet://$server/modules/icinga/empty",
    ensure => directory,
    purge => true,
    recurse => true,
    require => Package['icinga'],
    notify => Service['icinga'],
    owner => root, group => root, mode => 0555;
  }
}

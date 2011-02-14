class icinga::objects {
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
      => "$icinga::cfgdir/objects/servicedependency.cfg",
    serviceescalation
      => "$icinga::cfgdir/objects/serviceescalation.cfg",
    serviceextinfo
      => "$icinga::cfgdir/objects/serviceextinfo.cfg",
    timeperiod
      => "$icinga::cfgdir/objects/timeperiod.cfg",
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
    notify => Service['icinga'],
    owner => root, group => root, mode => 0644;
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

  resources{[
    'nagios_command',
    'nagios_contact',
    'nagios_contactgroup',
    'nagios_host',
    'nagios_hostextinfo',
    'nagios_hostgroup',
    'nagios_service',
    'nagios_servicedependency',
    'nagios_serviceextinfo',
    'nagios_timeperiod',
  ]:
    notify => Service['icinga'],
  }

  Nagios_command <||> {
    target => $objects['command'],
  }
  Nagios_contact <||> {
    target => $objects['contact'],
  }
  Nagios_contactgroup <||> {
    target => $objects['contactgroup'],
  }
  Nagios_host <||> {
    target => $objects['host'],
  }
  Nagios_hostextinfo <||> {
    target => $objects['hostgroup'],
  }
  Nagios_hostgroup <||> {
    target => $objects['hostgroup'],
  }
  Nagios_service <||> {
    target => $objects['service'],
  }
  Nagios_servicedependency <||> {
    target => $objects['servicedependency'],
  }
  Nagios_serviceescalation <||> {
    target => $objects['serviceescalation'],
  }
  Nagios_serviceextinfo <||> {
    target => $objects['serviceextinfo'],
  }
  Nagios_timeperiod <||> {
    target => $objects['timeperiod'],
  }

  # purge unmanaged icinga cfg files
  # must be defined after exported resource overrides and cfg file defs
  file{'icinga_cfgdir':
    path => "$icinga::cfgdir/",
    source => "puppet://$server/modules/common/empty",
    ensure => directory,
    recurse => true,
    purge => true,
    notify => Service['icinga'],
    mode => 0755, owner => root, group => root;
  }
}

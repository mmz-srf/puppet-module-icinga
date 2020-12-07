class icinga::objects {
  include icinga::defaults

  $objects = [
    'command',
    'contact',
    'contactgroup',
    'host',
    'hostextinfo',
    'hostgroup',
    #'servicegroup',
    'service',
    'servicedependency',
    'serviceescalation',
    'serviceextinfo',
    'timeperiod',
  ]
  $object_resourcenames = prefix($objects, 'nagios_')
  $object_pathnames_puppet = suffix(prefix($objects, '/etc/nagios/nagios_'), '.cfg')
  $object_pathnames_icinga = $::osfamily ? {
    'debian'  => suffix(prefix($objects, "$::icinga::cfgdir/objects/"), '_icinga.cfg'),
    'redhat'  => suffix(prefix($objects, "$::icinga::cfgdir/objects/"), '.cfg'),
  }

  # remove icinga example conf files in objects dir
  case $::osfamily {
    'redhat': {
      file{[
        "$::icinga::cfgdir/objects/commands.cfg",
        "$::icinga::cfgdir/objects/ido2db_check_proc.cfg",
        "$::icinga::cfgdir/objects/localhost.cfg",
        "$::icinga::cfgdir/objects/notifications.cfg",
        "$::icinga::cfgdir/objects/timeperiods.cfg",
        "$::icinga::cfgdir/objects/windows.cfg",
        "$::icinga::cfgdir/objects/printer.cfg",
        "$::icinga::cfgdir/objects/switch.cfg",
      ]:
        ensure => absent,
        require => Package['icinga'],
        before => Service['icinga'],
      }
    }
    'debian': {
      file{[
        "$::icinga::cfgdir/objects/contacts_icinga.cfg",
        "$::icinga::cfgdir/objects/extinfo_icinga.cfg",
        "$::icinga::cfgdir/objects/services_icinga.cfg",
        "$::icinga::cfgdir/objects/hostgroups_icinga.cfg",
        "$::icinga::cfgdir/objects/localhost_icinga.cfg",
        "$::icinga::cfgdir/objects/ido2db_check_proc.cfg",
        "$::icinga::cfgdir/objects/timeperiods_icinga.cfg",
        "$::icinga::cfgdir/objects/generic-host_icinga.cfg",
        "$::icinga::cfgdir/objects/generic-service_icinga.cfg",
      ]:
        ensure => absent,
        require => Package['icinga'],
        before => Service['icinga'],
      }
    }
  }


  file{'/etc/nagios/':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0555',
    recurse => true,
  } ->
  file{$object_pathnames_puppet:
    ensure  => present,
    replace => false,
    require => Package['icinga'],
    notify  => Service['icinga'],
    owner   => root,
    group   => root,
    mode    => '0444',
  } ->
  icinga::icinga_nagios_symlink { $objects :
    before => Service['icinga']
  }

  Nagios_command <<||>>
  Nagios_contact <<||>>
  Nagios_contactgroup <<||>>
  Nagios_host <<||>>
  Nagios_hostextinfo <<||>>
  Nagios_hostgroup <<||>>
  Nagios_service <<||>>
  Nagios_servicegroup <<||>>
  Nagios_servicedependency <<||>>
  Nagios_serviceescalation <<||>>
  Nagios_serviceextinfo <<||>>
  Nagios_timeperiod <<||>>

  Nagios_command <||> {
    require => Package['icinga'],
    notify => Service['icinga'],
  }
  Nagios_contact <||> {
    require => Package['icinga'],
    notify => Service['icinga'],
  }
  Nagios_contactgroup <||> {
    require => Package['icinga'],
    notify => Service['icinga'],
  }
  Nagios_host <||> {
    require => Package['icinga'],
    notify => Service['icinga'],
  }
  Nagios_hostextinfo <||> {
    require => Package['icinga'],
    notify => Service['icinga'],
  }
  Nagios_hostgroup <||> {
    require => Package['icinga'],
    notify => Service['icinga'],
  }
  Nagios_servicegroup <||> {
    require => Package['icinga'],
    notify => Service['icinga'],
  }
  Nagios_service <||> {
    require => Package['icinga'],
    notify => Service['icinga'],
  }
  Nagios_servicedependency <||> {
    require => Package['icinga'],
    notify => Service['icinga'],
  }
  Nagios_serviceescalation <||> {
    require => Package['icinga'],
    notify => Service['icinga'],
  }
  Nagios_serviceextinfo <||> {
    require => Package['icinga'],
    notify => Service['icinga'],
  }
  Nagios_timeperiod <||> {
    require => Package['icinga'],
    notify => Service['icinga'],
  }
}

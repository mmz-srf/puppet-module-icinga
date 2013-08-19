class icinga::objects {
  include icinga::defaults

  $objects = [
    'command',
    'contact',
    'contactgroup',
    'host',
    'hostextinfo',
    'hostgroup',
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

  define icinga_nagios_symlink {
    $object_pathname_icinga = $::osfamily ? {
      'debian'  => "$::icinga::cfgdir/objects/${name}_icinga.cfg",
      'redhat'  => "$::icinga::cfgdir/objects/${name}.cfg",
    } 
    file{$object_pathname_icinga:
      ensure => link,
      target => "/etc/nagios/nagios_${name}.cfg",
    }
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
      } 
    }
  }


  file{'/etc/nagios/':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => 0555,
    recurse => true,
  } ->
  file{$object_pathnames_puppet:
    ensure  => present,
    replace => false,
    require => Package['icinga'],
    notify  => Service['icinga'],
    owner   => root,
    group   => root,
    mode    => 0444,
  } ->
  icinga_nagios_symlink{$objects:
    before => Service['icinga']
  }

  # purge unmanaged resources
  resources{$object_resourcenames:
    purge => true,
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

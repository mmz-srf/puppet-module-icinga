class icinga::objects {
  include icinga::defaults

  $objects = [
    'commands',
    'contacts',
    'contactgroups',
    'hosts',
    'hostextinfos',
    'hostgroups',
    'srvices',
    'servicedependencys',
    'serviceescalations',
    'serviceextinfos',
    'timeperiods',
  ]
  $object_resourcenames = prefix($objects, 'nagios_')
  $object_filenames = suffix($objects, '.cfg')
  $object_pathnames = prefix($object_filenames, "$icinga::cfgdir/objects/")

  define icinga_nagios_symlink {
    file{"/etc/nagios/${name}":
      ensure => link,
      target => "$icinga::cfgdir/objects/${name}",
    }
  }
  file{'/etc/nagios':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 0555,
  } ->
  file{$object_pathnames:
    ensure  => present,
    replace => false,
    require => Package['icinga'],
    notify  => Service['icinga'],
    owner   => root,
    group   => root, 
    mode    => 0444,
  } ->
  icinga_nagios_symlink{$object_filenames:}

  # purge unmanaged resources
  resource{$object_resourcenames:
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

  # purge unmanaged icinga cfg files
  # must be defined after exported resource overrides and cfg file defs
  file{[
    "$icinga::cfgdir/objects/",
    "/etc/nagios/",
  ]:
    source => "puppet://$server/modules/icinga/empty",
    ensure => directory,
    purge => true,
    recurse => true,
    require => Package['icinga'],
    notify => Service['icinga'],
    owner => root, group => root, mode => 0555;
  }
}

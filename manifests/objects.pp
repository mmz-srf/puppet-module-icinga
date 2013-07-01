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
  $object_pathnames = suffix(prefix($objects, '/etc/nagios/nagios_'), '.cfg')

  define icinga_nagios_symlink {
    file{"$icinga::cfgdir/objects/${name}.cfg":
      ensure => link,
      target => "/etc/nagios/nagios_${name}.cfg",
    }
  }
  
  file{'/etc/nagios/':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => 0555,
    recurse => true,
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
  icinga_nagios_symlink{$objects:}

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

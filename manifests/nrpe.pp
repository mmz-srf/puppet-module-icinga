class icinga::nrpe(
  $nrpe_cfgdir = '/etc/nagios',
  $nrpe_allowed_hosts = '127.0.0.1',
  $nrpe_dont_blame_nrpe = 1,
  $nrpe_debug = 0,
  $nrpe_command_timeout = 60,
  $nrpe_connection_timeout = 300,
  $nrpe_pid = $::osfamily ? { 
    'debian' => '/var/run/nagios/nrpe.pid',
    'redhat' => '/var/run/nrpe.pid',
  },
  $nrpe_user = $::osfamily ? { 
    'debian' => 'nagios',
    'redhat' => 'nrpe',
  },
  $nrpe_group = $::osfamily ? { 
    'debian' => 'nagios',
    'redhat' => 'nrpe',
  },
  $libdir = $::osfamily ? { 
    'debian' => 'lib',
    'redhat' => $architecture ? {
      x86_64  => 'lib64',
      default => 'lib',
    },
  },
) {
  package{'nrpe':
    ensure => installed,
    name   => $::osfamily ? { 
      'debian' => 'nagios-nrpe-server',
      'redhat' => 'nrpe',
    }
  } ->
  file{"$nrpe_cfgdir/nrpe.d":
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0555',
  } ->
  file{"$nrpe_cfgdir/nrpe.cfg":
    content => template('icinga/nrpe.cfg.erb'),
    notify  => Service['nrpe'],
    owner   => root, group => root, mode => 444;
  } ~>
  icinga::nrpe::command{'default_commands':
  } ~>
  service{'nrpe':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    name      => $::osfamily ? { 
      'debian' => 'nagios-nrpe-server',
      'redhat' => 'nrpe',
    }
  }
}

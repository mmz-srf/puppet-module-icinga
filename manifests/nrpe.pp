class icinga::nrpe(
  $nrpe_cfgdir = '/etc/nagios',
  $nrpe_allowed_hosts = '127.0.0.1',
  $nrpe_dont_blame_nrpe = 1,
  $nrpe_debug = 0,
  $nrpe_command_timeout = 60,
  $nrpe_connection_timeout = 300
) {
  $libdir = $architecture ? {
    x86_64 => 'lib64',
    default => 'lib',
  }
  require icinga::plugins
  package{'nrpe':
    ensure => installed,
  }
  file{"$nrpe_cfgdir/nrpe.d":
    ensure => directory,
    require => Package['nrpe'],
    owner => root, group => root, mode => 555;
  }
  file{"$nrpe_cfgdir/nrpe.cfg":
    content => template('icinga/nrpe.cfg.erb'),
    require => Package['nrpe'],
    notify => Service['nrpe'],
    owner => root, group => root, mode => 444;
  }
  file{"$nrpe_cfgdir/nrpe.d/default_commands.cfg":
    content => template('icinga/nrpe_commands.cfg.erb'),
    require => File["$nrpe_cfgdir/nrpe.d"],
    notify => Service['nrpe'],
    owner => root, group => root, mode => 444;
  }
  service{'nrpe':
    ensure => running,
    enable => true,
    hasstatus => true,
    require => Package['nrpe'],
  }
}

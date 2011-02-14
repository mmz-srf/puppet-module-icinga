class icinga::nrpe(
  $cfgdir = '/etc/nagios',
  $allowed_hosts = '127.0.0.1',
  $dont_blame_nrpe = 1,
  $debug = 0,
  $command_timeout = 60,
  $connection_timeout = 300
) {
  $libdir = $architecture ? {
    x86_64 => 'lib64',
    default => 'lib',
  }
  package{'nrpe':
    ensure => installed,
  }
  file{[
    $cfgdir,
    "$cfgdir/nrpe.d",
  ]:
    ensure => directory,
    owner => root, group => root, mode => 755;
  }
  file{"$cfgdir/nrpe.cfg":
    content => template('icinga/nrpe.cfg.erb'),
    notify => Service['nrpe'],
    owner => root, group => root, mode => 644;
  }
  file{"$cfgdir/nrpe.d/nrpe_commands.cfg":
    source => [
      "puppet://$server/modules/site-icinga/configs/nrpe/nrpe_commands.cfg.$architecture",
      "puppet://$server/modules/site-icinga/configs/nrpe/nrpe_commands.cfg",
      "puppet://$server/modules/icinga/nrpe/nrpe_commands.cfg.$architecture",
    ],
    notify => Service['nrpe'],
    owner => root, group => root, mode => 644;
  }
  service{'nrpe':
    ensure => running,
    enable => true,
    hasstatus => true,
    require => Package['nrpe'],
  }
}

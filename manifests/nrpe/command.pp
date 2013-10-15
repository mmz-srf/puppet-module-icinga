define icinga::nrpe::command(
  $command = $name,
  $base_path = "/usr/${::icinga::nrpe::libdir}/nagios/plugins/",
) {
  file{"${::icinga::nrpe::nrpe_cfgdir}/nrpe.d/${name}.cfg":
    content => template('icinga/nrpe_command.cfg.erb'),
    notify  => Service['nrpe'],
    owner   => root,
    group   => root,
    mode    => '0444';
  }
}

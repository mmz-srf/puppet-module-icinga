define icinga::nrpe::command(
  $source_module => 'icinga',
) {
  file{"${::icinga::nrpe::nrpe_cfgdir}/nrpe.d/${name}.cfg":
    content => template("${source_module}/nrpe-commands/${name}.cfg.erb'),
    require => Class['::icinga::nrpe'],
    notify  => Service['nrpe'],
    owner   => root,
    group   => root,
    mode    => '0444';
  }
}

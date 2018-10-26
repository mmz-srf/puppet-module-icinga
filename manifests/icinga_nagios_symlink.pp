define icinga::icinga_nagios_symlink {
  $object_pathname_icinga = $::osfamily ? {
    'debian'  => "${::icinga::cfgdir}/objects/${name}_icinga.cfg",
    'redhat'  => "${::icinga::cfgdir}/objects/${name}.cfg",
  }

  file { $object_pathname_icinga :
    ensure => link,
    target => "/etc/nagios/nagios_${name}.cfg",
  }
}

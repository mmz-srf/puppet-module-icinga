define icinga::cfg() {
  file{"${::icinga::cfgdir}/${name}.cfg":
    source => [
      "puppet:///modules/site_icinga/core/${::fqdn}/${name}.cfg",
      "puppet:///modules/site_icinga/core/${name}.cfg",
      "puppet:///modules/icinga/core/${::osfamily}/${name}.cfg",
      "puppet:///modules/icinga/core/${name}.cfg",
    ],
    require => [
      Package['icinga'],
      Package['icinga-idoutils'],
    ],
    notify => [
      Service['icinga'],
    ],
    owner => root, group => root, mode => '0444';
  }
}

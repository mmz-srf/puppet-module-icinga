define icinga::cfg() {
  file{"$icinga::cfgdir/$name.cfg":
    source => [
      "puppet://$server/modules/site_icinga/core/$fqdn/$name.cfg",
      "puppet://$server/modules/site_icinga/core/$name.cfg",
      "puppet://$server/modules/icinga/core/$name.cfg",
    ],
    require => [
      Package['icinga'],
      Package['icinga-idoutils'],
    ],
    notify => [
      Service['icinga'],
      Service['ido2db'],
    ],
    owner => root, group => root, mode => 0444;
  }
}

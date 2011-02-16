define icinga::cfg {
  file{"$icinga::cfgdir/$name.cfg":
    source => [
      "puppet://$server/modules/site-icinga/$fqdn/core/$name.cfg",
      "puppet://$server/modules/site-icinga/core/$name.cfg",
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
    owner => root, group => root, mode => 0644;
  }
}

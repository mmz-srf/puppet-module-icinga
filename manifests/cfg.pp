define icinga::cfg {
  file{"$icinga::cfgdir/$name.cfg":
    source => [
      "puppet://$server/modules/site-icinga/$fqdn/$name.cfg",
      "puppet://$server/modules/site-icinga/$name.cfg",
      "puppet://$server/modules/icinga/$name.cfg",
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

class icinga::defaults::templates {
  file{"$icinga::cfgdir/objects/templates.cfg":
    source => [
      "puppet://$server/modules/site_icinga/core/$fqdn/templates.cfg",
      "puppet://$server/modules/site_icinga/core/templates.cfg",
      "puppet://$server/modules/icinga/core/templates.cfg" ],
    require => Package['icinga'],
    notify => Service['icinga'],
    mode => 0444, owner => root, group => root;
  }
}

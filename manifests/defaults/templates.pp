class icinga::defaults::templates {
  file{"$icinga::cfgdir/objects/templates.cfg":
    source => [
      "puppet://$server/modules/site-icinga/$fqdn/core/templates.cfg",
      "puppet://$server/modules/site-icinga/core/templates.cfg",
      "puppet://$server/modules/icinga/core/templates.cfg" ],
    require => Package['icinga'],
    notify => Service['icinga'],
    mode => 0444, owner => root, group => root;
  }
}

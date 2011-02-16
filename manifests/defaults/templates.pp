class icinga::defaults::templates {
  file{"$icinga::cfgdir/objects/templates.cfg":
    source => [
      "puppet://$server/modules/site-icinga/$fqdn/templates.cfg",
      "puppet://$server/modules/site-icinga/templates.cfg",
      "puppet://$server/modules/icinga/templates.cfg" ],
    require => Package['icinga'],
    notify => Service['icinga'],
    mode => 0644, owner => root, group => root;
  }
}

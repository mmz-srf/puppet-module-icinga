class icinga::defaults::templates {
  file{'icinga_templates':
    path => "$icinga::cfgdir/objects/templates.cfg",
    source => [
      "puppet://$server/modules/site-icinga/${fqdn}/templates.cfg",
      "puppet://$server/modules/site-icinga/templates.cfg",
      "puppet://$server/modules/icinga/templates.cfg" ],
    notify => Service['icinga'],
    mode => 0644, owner => root, group => root;
  }
}

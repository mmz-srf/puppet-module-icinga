#
# icinga module
#
# Copyright 2010, Atizo AG
# Simon Josi simon.josi+puppet(at)atizo.com
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

class icinga(
  $cfgdir = '/etc/icinga'
) {
  require gcc
  include icinga::objects
  package{[
    'icinga',
    'icinga-gui',
    'icinga-api',
    'icinga-doc',
    'icinga-idoutils',
    'libdbi',
    'libdbi-devel',
    'libdbi-drivers',
    'libdbi-dbd-mysql',
    'libdbi-dbd-pgsql',
  ]:
    ensure => present,
  }
  service{[
    'icinga',
    'ido2db',
  ]:
    hasstatus => true,
    ensure => running,
    enable => true,
  }
  Service['icinga']{
    require => Service['ido2db'],
  }
  file{
    "$icinga::cfgdir/icinga.cfg":
      source => [
        "puppet://$server/modules/site-icinga/$fqdn/icinga.cfg",
        "puppet://$server/modules/site-icinga/icinga.cfg",
        "puppet://$server/modules/icinga/icinga.cfg",
      ],
      require => Package['icinga'],
      notify => Service['icinga'],
      owner => root, group => root, mode => 0644;
    "$icinga::cfgdir/ido2db.cfg":
      source => [
        "puppet://$server/modules/site-icinga/$fqdn/ido2db.cfg",
        "puppet://$server/modules/site-icinga/ido2db.cfg",
        "puppet://$server/modules/icinga/ido2db.cfg",
      ],
      require => Package['icinga'],
      notify => Service['ido2db'],
      owner => root, group => root, mode => 0644;
    "$icinga::cfgdir/idomod.cfg":
      source => [
        "puppet://$server/modules/site-icinga/$fqdn/idomod.cfg",
        "puppet://$server/modules/site-icinga/idomod.cfg",
        "puppet://$server/modules/icinga/idomod.cfg",
      ],
      require => Package['icinga'],
      notify => [
        Service['ido2db'],
        Service['icinga'],
      ],
      owner => root, group => root, mode => 0644;
    "$icinga::cfgdir/resource.cfg":
      source => [
        "puppet://$server/modules/site-icinga/$fqdn/resource.cfg",
        "puppet://$server/modules/site-icinga/resource.cfg",
        "puppet://$server/modules/icinga/resource.cfg",
      ],
      require => Package['icinga'],
      notify => Service['icinga'],
      owner => root, group => root, mode => 0644;
  }
}

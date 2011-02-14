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
  $cfgdir = '/usr/local/icinga/etc',
  $webserver = false,
  $servername = absent,
  $port = absent
) {
  require gcc
  include icinga::objects
  package{[
    'libdbi',
    'libdbi-devel',
    'libdbi-drivers',
    'libdbi-dbd-mysql',
    'libdbi-dbd-pgsql',
  ]:
    ensure => present,
  }
  user::managed{[
    'icinga',
    'icinga-cmd',
  ]:
    ensure => present,
    homedir => '/usr/local/icinga',
    managehome => false,
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
  file{'/usr/local/icinga/var/rw/cmd':
    ensure => directory,
    require => [
      User::Managed['icinga'],
      User::Managed['icinga-cmd'],
    ],
    #require => Package['icinga'],
    mode => 2660, owner => 'icinga', group => 'icinga-cmd',
  }
  exec{'icinga.cmd':
    command => 'mkfifo /usr/local/icinga/var/rw/cmd/icinga.cmd',
    creates => '/usr/local/icinga/var/rw/cmd/icinga.cmd',
    require => [
      User::Managed['icinga'],
      User::Managed['icinga-cmd'],
    ],
    #require => Package['icinga'],
  }
  file{'/usr/local/icinga/var/rw/cmd/icinga.cmd':
    ensure => present,
    replace => false,
    require => [
      Exec['icinga.cmd'],
      #Package['icinga'],
    ],
    owner => root, group => root, mode => 2660;
  }
  file{
    "$icinga::cfgdir/icinga.cfg":
      source => [
        "puppet://$server/modules/site-icinga/$fqdn/icinga.cfg",
        "puppet://$server/modules/site-icinga/icinga.cfg",
        "puppet://$server/modules/icinga/icinga.cfg",
      ],
      notify => Service['icinga'],
      owner => root, group => root, mode => 0644;
    "$icinga::cfgdir/ido2db.cfg":
      source => [
        "puppet://$server/modules/site-icinga/$fqdn/ido2db.cfg",
        "puppet://$server/modules/site-icinga/ido2db.cfg",
        "puppet://$server/modules/icinga/ido2db.cfg",
      ],
      notify => Service['ido2db'],
      owner => root, group => root, mode => 0644;
    "$icinga::cfgdir/idomod.cfg":
      source => [
        "puppet://$server/modules/site-icinga/$fqdn/ido2db.cfg",
        "puppet://$server/modules/site-icinga/ido2db.cfg",
        "puppet://$server/modules/icinga/ido2db.cfg",
      ],
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
      notify => Service['icinga'],
      owner => root, group => root, mode => 0644;
  }
  if $webserver {
    class{'icinga::web':
      webserver => $webserver,
      servername => $servername,
      port => $port,
    }
  }
}

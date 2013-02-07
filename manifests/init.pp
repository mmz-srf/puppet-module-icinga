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
  $cfgdir = '/etc/icinga',
  $version = latest,
) {
  require icinga::plugins
  include icinga::objects
  $libdir = $architecture ? {
    x86_64 => 'lib64',
    default => 'lib',
  }
  package{[
    'icinga',
    'icinga-idoutils',
  ]:
    ensure => $version,
    notify => [
      Service['icinga'],
      Service['ido2db'],
      Exec['purge_contactgroups'],
    ],
  }
  package{[
    'icinga-api',
    'libdbi-dbd-mysql',
    'libdbi-dbd-pgsql',
    'nagios-plugins-nrpe',
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
  icinga::cfg{[
    'icinga',
    'ido2db',
    'idomod',
    'resource',
  ]:}
  file{'/usr/share/icinga/plugins':
    ensure => "/usr/$libdir/nagios/plugins",
    require => [
      Package['icinga'],
      Package['nagios-plugins-all'],
    ],
  }
  # workaround until we got purging behaviour for objects
  exec{'purge_contactgroups':
    command => 'rm -f /etc/icinga/objects/contactgroups.cfg',
    refreshonly => true,
    before => [
      Service['icinga'],
      Class['icinga::objects'],
    ]
  }
}

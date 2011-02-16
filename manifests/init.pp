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
  include icinga::objects
  $libdir = $architecture ? {
    x86_64 => 'lib64',
    default => 'lib',
  }
  package{[
    'icinga',
    'icinga-gui',
    'icinga-api',
    'icinga-doc',
    'icinga-idoutils',
    'libdbi-dbd-mysql',
    'libdbi-dbd-pgsql',
    'nagios-plugins',
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
    'cgi',
    'ido2db',
    'idomod',
    'resource',
  ]:}
  file{'/usr/share/icinga/plugins':
    ensure => "/usr/$libdir/nagios/plugins",
    require => Package['nagios-plugins'],
  }
}

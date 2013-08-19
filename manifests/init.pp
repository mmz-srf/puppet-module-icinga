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
  include icinga::objects
  $libdir = $architecture ? {
    x86_64 => 'lib64',
    default => 'lib',
  }
  
  include ::icinga::package

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

  if $::osfamily == 'redhat' {
    file{'/usr/share/icinga/plugins':
      ensure => "/usr/$libdir/nagios/plugins",
      require => [
        Package['icinga'],
        Package['nagios-plugins'],
      ],
    }
  }
  icinga::plugin{[
    'check_cpu',
    'check_memory',
  ]:}
}

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

class icinga {
  require gcc
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
  #service{'icinga':
  #  hasstatus => true,
  #  ensure => running,
  #  enable => true,
  #}
}

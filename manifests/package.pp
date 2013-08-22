class icinga::package { 
  package{[
    'icinga',
    'icinga-idoutils',
  ]:
    ensure => $::icinga::version,
    notify => [
      Service['icinga'],
      Service['ido2db'],
    ],
  } 
  case $::osfamily {
    'RedHat': {
      include ::icinga::package::redhat
    }
    'Debian': {
      include ::icinga::package::debian
    }
    default: {
      fail("Operting System not suported : $osfamily")
    }
  }
}
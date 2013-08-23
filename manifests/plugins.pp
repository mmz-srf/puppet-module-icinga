class icinga::plugins {
  case $::osfamily {
    'RedHat': {
      include ::icinga::plugins::redhat
    }
    'Debian': {
      include ::icinga::plugins::debian
    }
    default: {
      fail("Operting System not suported : $osfamily")
    }
  }
}
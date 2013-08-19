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
  	'redhat': {
  		include ::icinga::package::redhat
  	}
  	'debian': {
  		include ::icinga::package::debian
  	}
  	default: {
  		fail("Operting System not suported : $osfamily")
  	}
  }

}
class icinga::plugins::debian {
  
  if $::lsbdistcodename == 'buster' {
    # This package was renamed in Debian8 Jessie. We want to use the new shit
    # TODO : Change this if to Busters Lsb major dist number aufter buster release
    package{'nagios-plugins':
      name   => 'monitoring-plugins',
      ensure => present,
    }
  } else {

    package{'nagios-plugins':
      name   => 'nagios-plugins',
      ensure => present,
    }
  }
}

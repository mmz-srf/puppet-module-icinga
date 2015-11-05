class icinga::plugins::debian {
  package{'nagios-plugins':
    name => 'nagios-plugins',
    ensure => present,
    install_options => ['-t','wheezy'],
  }
}
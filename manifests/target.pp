class icinga::target(
  $use = 'generic-host',
  $parents = undef,
  $hostgroups = undef,
) {
  if defined (Class['::icinga']) {
    Class['::icinga'] <- Class['::icinga::target']
  }

  include ::icinga::plugins

  @@nagios_host{$fqdn:
    address => $ipaddress,
    alias => $hostname,
    use => $use,
  }

  if $parents {
    Nagios_host[$fqdn] {
      parents => $icinga_parents
    }
  }

  if $hostgroups {
    Nagios_host[$fqdn] {
      parents => $hostgroups,
    }
  }

  icinga::plugin{[
    'check_cpu',
    'check_memory',
  ]:}

  case $osfamily {
    'RedHat': {
      package { 'perl-Nagios-Plugin':
        ensure => 'present',
      }
      icinga::plugin { 'check_yum': }
    }
    default: {
      # nothing specific yet
    }
  }
}

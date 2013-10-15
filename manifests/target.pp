class icinga::target(
  $use = 'generic-host'
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
  if $icinga_parents {
    Nagios_host[$fqdn] {
      parents => $icinga_parents
    }
  }
  icinga::plugin{[
    'check_cpu',
    'check_memory',
  ]:}
}

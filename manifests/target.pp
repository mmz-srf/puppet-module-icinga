class icinga::target(
  $use = 'generic-host'
) {
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
}

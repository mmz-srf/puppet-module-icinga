class nagios::target {
  @@nagios_host{$fqdn:
    address => $ipaddress,
    alias => $hostname,
    use => 'generic-host',
  }
  if $icinga_parents {
    Nagios_host[$fqdn] {
      parents => $icinga_parents
    }
  }
}

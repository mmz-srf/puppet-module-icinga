class icinga::defaults::hostgroups {
  nagios_hostgroup{'all':
    alias => 'All Servers',
    members => '*',
  }
}

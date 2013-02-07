class icinga::defaults::contactgroups {
  nagios_contactgroup{'administrators':
    alias => 'Icinga Administrators',
    members => 'root',
  }
}

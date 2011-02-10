class icinga::defaults::contactgroups {
  nagios_contactgroup{'admins':
    alias => 'Icinga Administrators',
    members => 'root',
  }
}

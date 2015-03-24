define icinga::servicegroup (
  $ensure = present,
  $servicegroupalias,
  $target = "/etc/icinga/objects/servicegroup_icinga.cfg",
) {

  @@nagios_servicegroup{"${name}_servicegroup":
    ensure => $ensure,
    alias  => $servicegroupalias,
    notify => Service['icinga'],
    target => $target,
    mode   => '644'
  }
}
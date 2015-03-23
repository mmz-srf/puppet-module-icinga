define icinga::servicegroup (
  $ensure = present,
  $servicegroupalias,
  $target = "/etc/icinga/objects/${::hostname}_servicegroup.cfg",
) {

  @@nagios_servicegroup{"${hostname}_${name}_servicegroup":
    ensure => $ensure,
    alias  => $servicegroupalias,
    notify => Service['icinga'],
    target => $target,
    mode   => '644'
  }
}
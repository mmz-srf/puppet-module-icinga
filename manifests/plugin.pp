define icinga::plugin {
  include icinga::plugins
  $libdir = $architecture ? {
    x86_64 => 'lib64',
    default => 'lib',
  }
  file{"/usr/$libdir/nagios/plugins/$name":
    source => [
      "puppet://$server/modules/site_icinga/plugins/$name",
      "puppet://$server/modules/icinga/plugins/$name",
    ],
    require => Package['nagios-plugins-all'],
    owner => root, group => root, mode => 0755;
  }
}

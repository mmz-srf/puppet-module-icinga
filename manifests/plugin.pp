define icinga::plugin(
  source_module => 'icinga',
) {
  $libdir = $architecture ? {
    x86_64 => 'lib64',
    default => 'lib',
  }
  include ::icinga::plugins
  file{"/usr/$libdir/nagios/plugins/$name":
    source => "puppet://$server/modules/${source_module}/plugins/${name}",
    require => Package['nagios-plugins'],
    owner => root, group => root, mode => 0755;
  }
}
 

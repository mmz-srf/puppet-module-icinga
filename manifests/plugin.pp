define icinga::plugin(
  $source_module = $caller_module_name,
) {
  $libdir = $architecture ? {
    x86_64 => 'lib64',
    default => 'lib',
  }
  include ::icinga::plugins
  file{"/usr/$libdir/nagios/plugins/$name":
    source => "puppet:///modules/${source_module}/icinga-plugins/${name}",
    require => Package['nagios-plugins'],
    owner => root, group => root, mode => '0755';
  }
}

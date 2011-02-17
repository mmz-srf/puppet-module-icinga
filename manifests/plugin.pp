define icinga::plugin {
  file{"/usr/share/icinga/plugins/$name":
    source => [
      "puppet://$server/modules/site-icinga/plugins/$name",
      "puppet://$server/modules/icinga/plugins/$name",
    ],
    require => File['/usr/share/icinga/plugins'],
    owner => root, group => root, mode 0755;
  }
}

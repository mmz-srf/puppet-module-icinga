class icinga::web(
  $webserver = 'apache',
  $servername = 'localhost',
  $port = 80
) {
  Class['icinga::web'] <- Class['icinga']

  package{'icinga-web':
    ensure => present,
  }
  file{'/etc/icinga-web':
    recurse => true,
    source => [
      "puppet://$server/modules/site_icinga/icinga-web/$fqdn/",
      "puppet://$server/modules/site_icinga/icinga-web/",
      "puppet://$server/modules/icinga/icinga-web",
    ],
    require => Package['icinga-web'],
    notify => Service[$webserver],
    owner => root, group => root, mode => 0444;
  }
  #exec{'initialize_database':
  #  command => ,
  #  creates => ,
  #}
  case $webserver {
    'apache': {
      include apache
      $webserver_conf = '/etc/httpd/conf.d/icinga-web.conf'
    }
    'nginx': {
      include nginx::spawn-fcgi
      $webserver_conf = '/etc/nginx/conf.d/icinga-web.conf'
    }
    default: {
      fail "webserver '$webserver' is not supported."
    }
  }
  file{'webserver-config':
    content => template("icinga/icinga-web/webserver-conf.$webserver.erb"),
    path => $webserver_conf,
    require => Package['icinga-web'],
    notify => Service[$webserver],
    owner => root, group => root, mode => 0444;
  }
  user::groups::manage_member{"${webserver}-in-icingacmd":
    user => $webserver,
    group => 'icingacmd',
  }
  class{'php':
    webserver => $webserver,
  }
  if $lsbmajdistrelease == 5 {
    Class['php']{
      centos_use_remi => true,
    }
  }
  include php::extensions::mysql
  include php::extensions::xml
  include php::extensions::xmlrpc
  include php::extensions::pdo
  include php::extensions::ldap
  include php::extensions::soap
}

class icinga::web(
  $servername,
  $webserver = 'apache',
  $port = 80
) {
  require icinga
  include $webserver
  case $webserver {
    'apache': {
      $webserver_conf = '/etc/httpd/vhosts.d/icinga-web.conf'
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
    content => template("icinga/webserver-conf.$webserver.erb"),
    path => $webserver_conf,
    notify => Service[$webserver],
    owner => root, group => root, mode => 0444;
  }
  user::groups::manage_member{$webserver:
    group => 'icinga-cmd',
  }
  class{'php':
    centos_use_remi => true,
    webserver => $webserver,
  }
  include php::extensions::mysql
  include php::extensions::xml
  include php::extensions::xmlrpc
  include php::extensions::pdo
  include php::extensions::ldap
  include php::extensions::soap
}

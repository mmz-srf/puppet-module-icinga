class icinga::web(
  $webserver = 'apache',
  $servername = 'localhost',
  $port = 80
) {
  require icinga
  package{'icinga-web':
    ensure => present,
  }
  file{
    '/usr/share/icinga-web/app/config/databases.xml':
      source => [
        "puppet://$server/modules/site-icinga/$fqdn/icinga-web/databases.xml",
        "puppet://$server/modules/site-icinga/icinga-web/databases.xml",
        "puppet://$server/modules/icinga/icinga-web/databases.xml",
      ],
      require => Package['icinga-web'],
      notify => Service[$webserver],
      owner => root, group => root, mode => 0644;
    '/usr/share/icinga-web/app/modules/Web/config/icinga-io.xml':
      source => [
        "puppet://$server/modules/site-icinga/$fqdn/icinga-web/icinga-io.xml",
        "puppet://$server/modules/site-icinga/icinga-web/icinga-io.xml",
        "puppet://$server/modules/icinga/icinga-web/icinga-io.xml",
      ],
      require => Package['icinga-web'],
      notify => Service[$webserver],
      owner => root, group => root, mode => 0644;
    '/usr/share/icinga-web/app/modules/AppKit/config/auth.xml':
      source => [
        "puppet://$server/modules/site-icinga/$fqdn/icinga-web/auth.xml",
        "puppet://$server/modules/site-icinga/icinga-web/auth.xml",
        "puppet://$server/modules/icinga/icinga-web/auth.xml",
      ],
      require => Package['icinga-web'],
      notify => Service[$webserver],
      owner => root, group => root, mode => 0644;
  }
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

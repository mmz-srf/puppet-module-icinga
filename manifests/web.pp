class icinga::web(
  $webserver = 'apache',
  $servername = 'localhost',
  $port = 80
) {
  Class['icinga::web'] <- Class['icinga::package']

  package{'icinga-web':
    ensure => present,
  }->
  augeas { 'enable_ido2db':
    changes => [
      "set /files/etc/default/icinga/IDO2DB yes",
    ],
    onlyif => "match /files/etc/default/icinga/IDO2DB[. = 'yes'] size == 0"
  }

  if $::osfamily == 'redhat' {
    # Debian dont need this block. does not make any sense to me
    file{'/etc/icinga-web':
      recurse => true,
      source => [
        "puppet://$server/modules/site_icinga/icinga-web/$fqdn/",
        "puppet://$server/modules/site_icinga/icinga-web/",
        "puppet://$server/modules/icinga/icinga-web",
      ],
      require => Package['icinga-web'],
      notify => Class[$webserver],
      owner => root, group => root, mode => '0444';
    }
  }

  case $webserver {
    'apache': {
      if $::osfamily == 'debian' {
        # could not find this module used by srf.
        class {'::apache':
          keepalive    => 'On',
          default_mods => true,
          mpm_module   => "prefork", # needed to instal mod libapache2-mod-php5
        }
        include ::apache::mod::php
        include ::apache::mod::rewrite

        file { '/var/lib/icinga/rw':
          ensure => directory,
          mode   => '0755',
        }
      } else {
        include apache
      }

      $webserver_conf = $::osfamily ? {
        'debian' => '/etc/apache2/conf.d/icinga-web.conf',
        'redhat' => '/etc/httpd/conf.d/icinga-web.conf',
      }
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
    content => template("icinga/icinga-web/webserver-conf.$webserver.${::osfamily}.erb"),
    path => $webserver_conf,
    require => Package['icinga-web'],
    notify => Service['httpd'],
    owner => root, group => root, mode => '0444';
  }
  user::groups::manage_member{"${webserver}-in-icingacmd":
    user => $::osfamily ? {
      'debian' => 'www-data',
      'redhat' => $webserver,
    },
    group => $::osfamily ? {
      'debian' => 'nagios',
      'redhat' => 'icingacmd',
    }
  }
  class{'php':
    webserver => $webserver,
  }
  if $lsbmajdistrelease == 5 {
    Class['php']{
      centos_use_remi => true,
    }
  }
  # clear webcache
  exec{'icinga_web_clearcache':
    command    => $::osfamily ? {
      'debian' => '/usr/lib/icinga-web/bin/clearcache.sh',
      'redhat' => '/usr/bin/icinga-web-clearcache',
    },
    refreshonly => true,
  }
  include php::extensions::mysql
  include php::extensions::xml
  include php::extensions::xmlrpc
  include php::extensions::pdo
  include php::extensions::ldap
  include php::extensions::soap
}

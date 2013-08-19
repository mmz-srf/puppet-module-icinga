# deploy db config for icinga-web
class icinga::web::dbconf (
  $database     = 'icinga',
  $username     = 'icinga',
  $password     = 'icinga',
  $hostname     = 'localhost',
  $port         = '3306',
  $web_database = 'icinga_web',
  $web_username = 'icinga_web',
  $web_password = 'icinga_web',
  $web_hostname = 'localhost',
  $web_port     = '3306'
){

  file{'/etc/icinga-web/conf.d/databases.xml':
    content => template('icinga/icinga-web/databases.xml.erb'),
    owner   => root,
    group   => apache,
    mode    => '0640',
    require => Package['icinga-web'],
    notify  => [
      Exec['icinga_web_clearcache'],
      Class['apache']
    ]
  }

}

# deploy db config for icinga-web
class icinga::web::dbconf (
  $database = 'icinga_web',
  $username = 'icinga_web',
  $password = 'icinga_web',
  $hostname = 'localhost',
  $port     = '3306'
){

  file{'/etc/icinga-web/conf.d/databases.xml':
    content => template('icinga/icinga-web/databases.xml.erb'),
    owner   => root,
    group   => apache,
    mode    => '0640',
    require => Package['icinga-web'],
    notify  => Service['apache']
  }

}

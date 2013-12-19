class icinga::web::ldapconf (
    $enabled     = false,
    $dsn         = 'ldap://ldap.myopenldap.foo/',
    $start_tls   = false,
    $basedn      = 'dc=myopenldap,dc=foo',
    $binddn      = 'cn=user,ou=authusers,dc=myopenldap,dc=foo',
    $bindpw      = 'XXXXXXXXX',
    $userattr    = 'uid',
    $filter_user = '(&(uid=__USERNAME__))',
) {
  file { '/etc/icinga-web/conf.d/auth.xml':
    content => template('icinga/icinga-web/auth.xml.erb'),
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['icinga-web'],
    notify  => [
      Exec['icinga_web_clearcache'],
      Service['httpd'],
    ]
  }
}

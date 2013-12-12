class icinga::web::ldapconf (
    $ldap_enabled     = false,
    $ldap_dsn         = 'ldap://ldap.myopenldap.foo/',
    $ldap_start_tls   = false,
    $ldap_basedn      = 'dc=myopenldap,dc=foo',
    $ldap_binddn      = 'cn=user,ou=authusers,dc=myopenldap,dc=foo',
    $ldap_bindpw      = 'XXXXXXXXX',
    $ldap_userattr    = 'uid',
    $ldap_filter_user = '(&(uid=__USERNAME__))',
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

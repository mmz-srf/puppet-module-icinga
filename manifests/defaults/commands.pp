class icinga::defaults::commands {
  # common remote service commands
  nagios_command{
    'check_dummy':
      command_line => '$USER1$/check_dummy $ARG1$';
    'check_ping':
      command_line => '$USER1$/check_ping -H $HOSTADDRESS$ -w $ARG1$ -c $ARG2$';
    'check-host-alive':
      command_line => '$USER1$/check_ping -H $HOSTADDRESS$ -w 3000,80% -c 5000,100% -p 1';
    'check_tcp':
      command_line => '$USER1$/check_tcp -H $HOSTADDRESS$ -p $ARG1$';
    'check_udp':
      command_line => '$USER1$/check_udp -H $HOSTADDRESS$ -p $ARG1$';
    'check_dig':
      command_line => '$USER1$/check_dig -H $HOSTADDRESS$ -l $ARG1$';
    'check_ssh':
      command_line => '$USER1$/check_ssh $HOSTADDRESS$';
    'check_ssh_port':
      command_line => '$USER1$/check_ssh -p $ARG1$ $HOSTADDRESS$';
    'check_http':
      command_line => '$USER1$/check_http -H $HOSTADDRESS$';
    'check_http_url':
      command_line => '$USER1$/check_http -H $ARG1$ -u $ARG2$';
    'check_http_url_regex':
      command_line => '$USER1$/check_http -H $ARG1$ -u $ARG2$ -e $ARG3$';
    'check_http_url_string':
      command_line => '$USER1$/check_http -H $ARG1$ -u $ARG2$ -s $ARG3$';
    'check_https':
      command_line => '$USER1$/check_http --ssl -H $HOSTADDRESS$';
    'check_https_url':
      command_line => '$USER1$/check_http --ssl -H $ARG1$ -u $ARG2$';
    'check_https_url_regex':
      command_line => '$USER1$/check_http --ssl -H $ARG1$ -u $ARG2$ -e $ARG3$';
    'check_https_url_string':
      command_line => '$USER1$/check_http --ssl -H $ARG1$ -u $ARG2$ -s $ARG3$';
    'check_https_cert':
      command_line => '$USER1$/check_http --ssl -C 20 -H $HOSTADDRESS$ -I $HOSTADDRESS$';
    'check_https_sni_local_cert':
      command_line => '$USER1$/check_http --ssl -C $ARG2$ --sni -H $ARG1$ -I $HOSTADDRESS$';
    'check_https_sni_loadbalancer_cert':
      command_line => '$USER1$/check_http --ssl -C $ARG2$ --sni -H $ARG1$';
    'check_mysql':
      command_line => '$USER1$/check_mysql -H $ARG1$ -P $ARG2$ -u $ARG3$ -p $ARG4$';
    'check_mysql_db':
      command_line => '$USER1$/check_mysql -H $ARG1$ -P $ARG2$ -u $ARG3$ -p $ARG4$ -d $ARG5$';
    'check_ntp_time':
      command_line => '$USER1$/check_ntp_time -H $HOSTADDRESS$ -w 0.5 -c 1';
    'check_nrpe':
      command_line => '$USER1$/check_nrpe -t 60 -H $HOSTADDRESS$ -c $ARG1$ -a $ARG2$';
    'check_silc':
      command_line => '$USER1$/check_tcp -p 706 -H $ARG1$';
    'check_smtp':
      command_line => '$USER1$/check_smtp -H $ARG1$';
    'check_imap':
      command_line => '$USER1$/check_imap -H $HOSTADDRESS$';
    'check_pop':
      command_line => '$USER1$/check_pop -H $HOSTADDRESS$';
    'check_sobby':
      command_line => '$USER1$/check_tcp -H $ARG1$ -p $ARG2$';
    'check_traceroute':
      command_line => 'sudo $USER1$/check_traceroute.pl -H $ARG1$ -R $ARG2$';
    'check_traceroute_max_hops':
      command_line => 'sudo $USER1$/check_traceroute.pl -H $ARG1$ -R $ARG2$ -N $ARG3$';
    'check_jabber':
      command_line => '$USER1$/check_jabber -H $ARG1$ -e $ARG2$';
  }

  # notification commands
  nagios_command{
    'notify-host-by-email':
      command_line => '/usr/bin/printf "%b" "***** Icinga *****\n\nNotification Type: $NOTIFICATIONTYPE$\nHost: $HOSTNAME$\nState: $HOSTSTATE$\nAddress: $HOSTADDRESS$\nInfo: $HOSTOUTPUT$\n\nDate/Time: $LONGDATETIME$\n" | /bin/mail -s "** $NOTIFICATIONTYPE$ Host Alert: $HOSTNAME$ is $HOSTSTATE$ **" $CONTACTEMAIL$';
    'notify-service-by-email':
      command_line => '/usr/bin/printf "%b" "***** Icinga *****\n\nNotification Type: $NOTIFICATIONTYPE$\n\nService: $SERVICEDESC$\nHost: $HOSTALIAS$\nAddress: $HOSTADDRESS$\nState: $SERVICESTATE$\n\nDate/Time: $LONGDATETIME$\n\nAdditional Info:\n\n$SERVICEOUTPUT$\n" | /bin/mail -s "** $NOTIFICATIONTYPE$ Service Alert: $HOSTALIAS$/$SERVICEDESC$ is $SERVICESTATE$ **" $CONTACTEMAIL$';
  }
}

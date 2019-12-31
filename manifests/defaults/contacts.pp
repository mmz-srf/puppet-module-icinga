class icinga::defaults::contacts (
  $notify_option_service       = 'w,u,c,r',
  $notify_option_host          = 'd,r',
  ) {
  nagios_contact{'root':
    alias                           => 'Root',
    service_notification_period     => '24x7',
    host_notification_period        => '24x7',
    service_notification_options    => $notify_option_service,
    host_notification_options       => $notify_option_host,
    service_notification_commands   => 'notify-service-by-email',
    host_notification_commands      => 'notify-host-by-email',
    email                           => 'root@localhost',
  }
}

class icinga::defaults::contacts {
  $notify_or_not_service = $::mpc_project ? {
    'production' => 'w,u,c,r',
    default      => 'n',
  }

  $notify_or_not_host = $::mpc_project ? {
    'production' => 'd,r',
    default      => 'n',
  }
  nagios_contact{'root':
    alias                           => 'Root',
    service_notification_period     => '24x7',
    host_notification_period        => '24x7',
    service_notification_options    => $notify_or_not_service,
    host_notification_options       => $notify_or_not_host,
    service_notification_commands   => 'notify-service-by-email',
    host_notification_commands      => 'notify-host-by-email',
    email                           => 'root@localhost',
  }
}

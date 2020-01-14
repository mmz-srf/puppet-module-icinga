define icinga::service (
  $check_command,
  $nrpe_args = '',
  $ensure = present,
  $host_name = $fqdn,
  $use_nrpe = false,
  $action_url = false,
  $active_checks_enabled = false,
  $check_freshness = false,
  $check_interval = false,
  $check_period = false,
  $contact_groups = false,
  $contacts = false,
  $display_name = false,
  $event_handler = false,
  $event_handler_enabled = false,
  $failure_prediction_enabled = false,
  $first_notification_delay = false,
  $flap_detection_enabled = false,
  $flap_detection_options = false,
  $freshness_threshold = false,
  $high_flap_threshold = false,
  $hostgroup_name = false,
  $icon_image = false,
  $icon_image_alt = false,
  $initial_state = false,
  $is_volatile = false,
  $low_flap_threshold = false,
  $max_check_attempts = false,
  $normal_check_interval = false,
  $notes = false,
  $notes_url = false,
  $notification_interval = false,
  $notification_options = false,
  $notification_period = false,
  $notifications_enabled = false,
  $obsess_over_service = false,
  $parallelize_check = false,
  $passive_checks_enabled = false,
  $process_perf_data = false,
  $register = false,
  $retain_nonstatus_information = false,
  $retain_status_information = false,
  $retry_check_interval = false,
  $retry_interval = false,
  $service_description = false,
  $servicegroups = false,
  $stalking_options = false,
  $target = "/etc/icinga/objects/${::hostname}_services.cfg",
  $use = false
) {
  if $use_nrpe {
    $real_check_command = "check_nrpe!$check_command!'$nrpe_args'"
  } else {
    $real_check_command = $check_command
  }
  Nagios_service{
    use => 'generic-service',
  }
  @@nagios_service{"${hostname}_$name":
    ensure => $ensure,
    notify => Service['icinga'],
    check_command => $real_check_command,
    host_name => $host_name,

    action_url => $action_url,
    active_checks_enabled => $active_checks_enabled,
    check_freshness => $check_freshness,
    check_interval => $check_interval,
    check_period => $check_period,
    contact_groups => $contact_groups,
    contacts => $contacts,
    display_name => $display_name,
    event_handler => $event_handler,
    event_handler_enabled => $event_handler_enabled,
    failure_prediction_enabled => $failure_prediction_enabled,
    first_notification_delay => $first_notification_delay,
    flap_detection_enabled => $flap_detection_enabled,
    flap_detection_options => $flap_detection_options,
    freshness_threshold => $freshness_threshold,
    high_flap_threshold => $high_flap_threshold,
    hostgroup_name => $hostgroup_name,
    icon_image => $icon_image,
    icon_image_alt => $icon_image_alt,
    initial_state => $initial_state,
    is_volatile => $is_volatile,
    low_flap_threshold => $low_flap_threshold,
    max_check_attempts => $max_check_attempts,
    normal_check_interval => $normal_check_interval,
    notes => $notes,
    notes_url => $notes_url,
    notification_interval => $notification_interval,
    notification_options => $notification_options,
    notification_period => $notification_period,
    notifications_enabled => $notifications_enabled,
    obsess_over_service => $obsess_over_service,
    parallelize_check => $parallelize_check,
    passive_checks_enabled => $passive_checks_enabled,
    process_perf_data => $process_perf_data,
    register => $register,
    retain_nonstatus_information => $retain_nonstatus_information,
    retain_status_information => $retain_status_information,
    retry_check_interval => $retry_check_interval,
    retry_interval => $retry_interval,
    service_description => $service_description,
    servicegroups => $servicegroups,
    stalking_options => $stalking_options,
    target => $target,
    use => $use,
    mode => '644',
  }
}

class icinga::defaults::timeperiods {
  nagios_timeperiod{
    '24x7':
      alias       => '24 Hours A Day, 7 Days A Week',
      monday      => '00:00-24:00',
      tuesday     => '00:00-24:00',
      wednesday   => '00:00-24:00',
      thursday    => '00:00-24:00',
      friday      => '00:00-24:00',
      saturday    => '00:00-24:00',
      sunday      => '00:00-24:00';
    'clouddayhours':
      alias       => 'Cloudday hours',
      monday      => '06:30-23:55',
      tuesday     => '06:30-23:55',
      wednesday   => '06:30-23:55',
      thursday    => '06:30-23:55',
      friday      => '06:30-23:55',
      saturday    => '06:30-23:55',
      sunday      => '06:30-23:55';
    'workhours':
      alias       => 'Standard Work Hours',
      monday      => '09:00-19:00',
      tuesday     => '09:00-19:00',
      wednesday   => '09:00-19:00',
      thursday    => '09:00-19:00',
      friday      => '09:00-19:00';
    'nonworkhours':
      alias       => 'Non-Work Hours',
      monday      => '00:00-09:00,19:00-24:00',
      tuesday     => '00:00-09:00,19:00-24:00',
      wednesday   => '00:00-09:00,19:00-24:00',
      thursday    => '00:00-09:00,19:00-24:00',
      friday      => '00:00-09:00,19:00-24:00',
      saturday    => '00:00-24:00',
      sunday      => '00:00-24:00';
    'never':
      alias       => 'Never';
  }
}

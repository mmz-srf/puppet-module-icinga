class icinga::defaults {
  include icinga::defaults::commands
  include icinga::defaults::contactgroups
  include icinga::defaults::contacts
  include icinga::defaults::hostgroups
  include icinga::defaults::templates
  include icinga::defaults::timeperiods
}

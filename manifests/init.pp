# = Class: nsswitch
#
# This class handles the configuration for nsswitch
#
# == Parameters:
#   TODO

# == Actions:
#   TODO

# == Requires:
#
# == Tested/works on:
#   - Debian untested
#   - RHEL   5.2   / 5.4   / 5.5   / 6.1   / 6.2
#   - OVS    2.1.1 / 2.1.5 / 2.2.0 / 3.0.2 / 
#
# == Sample Usage:
# 
# class { 'nsswitch':
#	module => 'none',
# }
#
# class { 'nsswitch':
#	module => 'ldap',
# }
#

class nsswitch(
	$uri         = false,
	$base        = false,
	$module_type = 'none') {

	include nsswitch::params
	include nsswitch::install
	include nsswitch::service
	include nsswitch::config

}

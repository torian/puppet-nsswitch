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
# module_type => 'none',
#}
#
# class { 'nsswitch':
# module_type => 'ldap',
#}
#

class nsswitch (
	$uri         = false,
	$base        = false,
	$module_type = 'none',
	$ensure      = 'present') {

	include nsswitch::params
	
	package { $nsswitch::params::package:
		ensure => $ensure
	}
	
	service { $nsswitch::params::service:
		ensure     => $module_type ? {
				'ldap'  => running,
				default => stopped,
				},
		enable     => $module_type ? {
				'ldap'  => true,
				default => false,
				},
		name       => $nsswitch::params::script,
		pattern    => $nsswitch::params::pattern,
		hasstatus  => true,
		hasrestart => true,
		subscribe  => File[$nsswitch::params::service_cfg],
		require    => Package[$nsswitch::params::package],
	}
	
	include nsswitch::config

}

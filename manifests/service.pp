
class nsswitch::service {

	service { $nsswitch::params::service:
		ensure     => $nsswitch::module_type ? {
				'ldap'  => running,
				default => stopped,
				},
		enable     => $nsswitch::module_type ? {
				'ldap'  => true,
				default => false,
				},
		name       => $nsswitch::params::script,
		pattern    => $nsswitch::params::pattern,
		hasstatus  => true,
		hasrestart => true,
		subscribe  => File[$nsswitch::params::service_cfg],
		require    => Package[$nsswitch::params::service_pkg],
	}
}

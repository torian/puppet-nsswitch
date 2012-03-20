
class nsswitch::install {
	
	package { $nsswitch::params::package:
		ensure => present,
	}
	package { $nsswitch::params::service_pkg:
		ensure => present,
	}
	
}

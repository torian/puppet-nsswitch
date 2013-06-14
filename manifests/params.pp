
class nsswitch::params {

	case $operatingsystem {
	
		/Debian/: {
			
			$package = [ 'nscd', 'libnss-ldap' ]
			
			$owner    = 'root'
			$group    = 'root'
			$config   = "/etc/nsswitch.conf"
			$ldap_cfg = '/etc/ldap/ldap.conf'
			$libnss   = "/etc/libnss-ldap.conf"
			
			$service     = 'nscd'
			$script      = 'nscd'
			$pattern     = 'nscd'
			$service_cfg = $config

			$databases_ldap = [ 
				'set *[self::database = "passwd"]/service[1] compat',
				'set *[self::database = "passwd"]/service[2] ldap',
				'set *[self::database = "shadow"]/service[1] compat',
				'set *[self::database = "shadow"]/service[2] ldap',
				'set *[self::database = "group" ]/service[1] compat',
				'set *[self::database = "group" ]/service[2] ldap',
				]

			$databases_none = [
				'set *[self::database = "passwd"]/service[1] compat',
				'set *[self::database = "shadow"]/service[1] compat',
				'set *[self::database = "group" ]/service[1] compat',
				]
		}

		/(Redhat|CentOS)/: {
			$mod_prefix = 'nsswitch/redhat'
			
			$prefix = '/etc'
			$owner  = 'root'
			$group  = 'root'

			$config = "${prefix}/nsswitch.conf"

			if($operatingsystemrelease =~ /^6\./) {

				$package = [ 'nscd', 'nss-pam-ldapd' ]
			
				$config_src  = "${prefix}/nsswitch.conf-6.x"
				
				$service     = 'nslcd'
				$script      = 'nslcd'
				$pattern     = 'nslcd'
				$service_cfg = "${prefix}/nslcd.conf"

				$databases_ldap = [ 
					'set *[self::database = "passwd"]/service[1] files',
					'set *[self::database = "passwd"]/service[2] sss',
					'set *[self::database = "shadow"]/service[1] files',
					'set *[self::database = "shadow"]/service[2] sss',
					'set *[self::database = "group" ]/service[1] files',
					'set *[self::database = "group" ]/service[2] sss',
					]

				$databases_none = [
					'set *[self::database = "passwd"]/service[1] files',
					'set *[self::database = "shadow"]/service[1] files',
					'set *[self::database = "group" ]/service[1] files',
					]

			} else {

				$package = [ 'nss_ldap' ]

				$config_src  = "${prefix}/nsswitch.conf-5.x"

				$service     = 'nscd'
				$script      = 'nscd'
				$pattern     = 'nscd'
				$service_cfg = "${prefix}/nsswitch.conf"
				$service_pkg = 'nscd'

				$databases_ldap = [ 
					'set *[self::database = "passwd"]/service[1] files',
					'set *[self::database = "passwd"]/service[2] ldap',
					'set *[self::database = "shadow"]/service[1] files',
					'set *[self::database = "shadow"]/service[2] ldap',
					'set *[self::database = "group" ]/service[1] files',
					'set *[self::database = "group" ]/service[2] ldap',
					]

				$databases_none = [
					'set *[self::database = "passwd"]/service[1] files',
					'set *[self::database = "shadow"]/service[1] files',
					'set *[self::database = "group" ]/service[1] files',
					]
			}
		}
	
		/(OpenSuSE|SLES)/: {
			
			$package = [ 'nscd', 'nss_ldap' ]
			
			$owner    = 'root'
			$group    = 'root'
			$config   = "/etc/nsswitch.conf"
			$ldap_cfg = '/etc/ldap/ldap.conf'
			$libnss   = "/etc/libnss-ldap.conf"
			
			$service     = 'nscd'
			$script      = 'nscd'
			$pattern     = 'nscd'
			$service_cfg = $config

		}

		default: {
			fail("Operating system ${::operatingsystem} not supported")
		}
	}
}

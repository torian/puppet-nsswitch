
class nsswitch::params {

	case $operatingsystem {
	
		debian: {
			
			$mod_prefix = 'nsswitch/debian'
			
			$package = [ 'libnss-ldap' ]
			
			$prefix = '/etc'
			$owner  = 'root'
			$group  = 'root'
			$config = "${prefix}/nsswitch.conf"
			$libnss = "${prefix}/libnss-ldap.conf"

			$config_src = "${config}"

			$service     = 'nscd'
			$script      = 'nscd'
			$pattern     = 'nscd'
			$service_cfg = $config
			$service_pkg = 'nscd'

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

		# Defaults includes: redhat ovs oel
		default: {
			$mod_prefix = 'nsswitch/redhat'
			
			$prefix = '/etc'
			$owner  = 'root'
			$group  = 'root'

			$config = "${prefix}/nsswitch.conf"

			if($operatingsystemrelease =~ /^6\./) {

				$package = [ 'nscd' ]
			
				$config_src  = "${prefix}/nsswitch.conf-6.x"
				
				$service     = 'nslcd'
				$script      = 'nslcd'
				$pattern     = 'nslcd'
				$service_cfg = "${prefix}/nslcd.conf"
				$service_pkg = 'nss-pam-ldapd'

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

	}
}

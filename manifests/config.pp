class nsswitch::config {

  $module_type = $nsswitch::module_type

  file { $nsswitch::params::config:
    ensure  => present,
    owner   => $nsswitch::params::owner,
    group   => $nsswitch::params::group,
    mode    => '0644',
    content => template('nsswitch/nsswitch.conf.erb')
  }

  case $::osfamily {
    'Debian': {
      if ($module_type == 'ldap') {
        file { $nsswitch::params::libnss:
          ensure  => symlink,
          target  => $nsswitch::params::ldap_cfg,
          require => File[$nsswitch::params::ldap_cfg]
        }
      }
    }

    'RedHat': {
      if ($::operatingsystemrelease =~ /^6\./ and $module_type == 'ldap') {
        file { '/etc/nslcd.conf':
          ensure  => present,
          owner   => 'root',
          group   => 'root',
          mode    => '0640',
          content => template('nsswitch/nslcd.conf.erb'),
          notify  => Service[$nsswitch::params::service],
          require => Package[$nsswitch::params::service_pkg],
        }
      } elsif ($module_type == 'none') {
        file { '/etc/nslcd.conf':
          ensure => absent,
          notify => Service[$nsswitch::params::service],
        }
      }
    }

    'SuSE': {
      if($module_type == 'ldap') {
        Class['ldap'] -> Class['nsswitch']
      }
    }

    default: {}

  }
}


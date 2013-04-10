
class nsswitch::config {
  # if($module == 'ldap') {
  # $databases = $nsswitch::params::databases_ldap
  # } else {
  # $databases = $nsswitch::params::databases_none
  #}

  # Problemas con augeas en Debian #FIXME# - se usa file
  # augeas { $nsswitch::params::config:
  # context => "/files/${nsswitch::params::config}",
  # changes => $databases,
  #}

  $module_type = $nsswitch::module_type

  file { $nsswitch::params::config:
    ensure  => present,
    owner   => $nsswitch::params::owner,
    group   => $nsswitch::params::group,
    mode    => 0644,
    content => template("${nsswitch::params::mod_prefix}/${nsswitch::params::config_src}.erb")
  }

  case $operatingsystem {
    debian : {
      if ($module_type == 'ldap') {
        file { $nsswitch::params::libnss:
          ensure  => symlink,
          target  => "${ldap::params::prefix}/${ldap::params::config}",
          require => File["${ldap::params::prefix}/${ldap::params::config}"]
        }
      }
    }

    redhat : {
      if ($operatingsystemrelease =~ /^6\./ and $module_type == 'ldap') {
        file { '/etc/nslcd.conf':
          ensure  => present,
          owner   => 'root',
          group   => 'root',
          mode    => 0640,
          content => template("${nsswitch::params::mod_prefix}/etc/nslcd.conf.erb"),
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
  }

}

# vim: ts=4 ft=puppet


class nsswitch::install {
  package { [$nsswitch::params::package, $nsswitch::params::service_pkg]: ensure => present, }
}

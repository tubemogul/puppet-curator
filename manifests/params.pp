# == Class curator::params
#
# This class is meant to be called from curator
# It sets variables according to platform
#
class curator::params {


  case $::osfamily {
    'Debian', 'RedHat', 'Amazon': {
      $version = 'latest'
      $package_name = 'elasticsearch-curator'
      $package_provider = 'pip'
      $crons = {}
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}

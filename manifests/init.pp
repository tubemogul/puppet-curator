# == Class: curator
#
# Install and configure Elastic/Curator
#
# === Parameters
#
# [*version*]
#   Version of Curator to deploy
#
# [*package_name*]
#   By default name of the package is elasticsearch-curator
#
# [*package_provider*]
#   Default package provider is 'pip'
#

class curator (
  $version          = $curator::params::version,
  $package_name     = $curator::params::package_name,
  $package_provider = $curator::params::package_provider,
  $crons            = $curator::params::crons,
) inherits curator::params {

  validate_re($version, '^absent|purged|latest|(\d)+(.\d+)*$')
  validate_string($package_name)
  validate_string($package_provider)

  class { 'curator::install': } ->
  Class['curator']

  create_resources(curator::cron, $crons)
}

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
# [*pip_package*]
#   Package name to install Python PIP provider
#
# [*crons*]
#   Hash of cronjobs to deploy
#

class curator (
  $version          = $curator::params::version,
  $package_name     = $curator::params::package_name,
  $package_provider = $curator::params::package_provider,
  $pip_package      = $curator::params::pip_package,
  $crons            = $curator::params::crons,
) inherits curator::params {

  validate_re($version, '^absent|purged|latest|(\d)+(.\d+)*$')
  validate_string(
    $package_name,
    $package_provider
  )
  validate_hash($crons)

  class { 'curator::install': } ->
  Class['curator']

  create_resources(curator::cron, $crons)
}

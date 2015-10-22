# == Class curator::install
#
class curator::install {

  package { $curator::package_name:
    ensure   => $curator::version,
    provider => $curator::package_provider,
  }
}

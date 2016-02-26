# == Class curator::install
#
class curator::install {

  # Install the PIP provider package
  ensure_packages($curator::pip_package)

  # Install Curator package
  package { $curator::package_name:
    ensure   => $curator::version,
    provider => $curator::package_provider,
    require  => Package['python-pip'],
  }
}

# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]
### Changed
- Move the changelog to markdown and start using semver
- The Travis tests matrix has been changed to get quicker tests and integrate
  rubocop testing for code quality
- `Gemfile` and `Rakefile` have been refactored

### Fixed
- Fix metadata quality
- Fix a `json_pure` dependency problem in the `Gemfile`
- Code quality cleanup based on rubocop and rubocop-spec standards

### Dropped
- Removed the `CONTRIBUTORS` file. You can get the contributors via the GitHub API

## [1.0.1] - 2016-02-29
### Fixed
- Errors in the doc have been fixed

## [1.0.0] - 2016-02-26
### Added
- Some parameters validation in the cron.pp
- New parameter: `curator::pip_package` - Name of the package to install with pip
- Added rspec tests for the base class and the cron define

### Changed
- The documentation has been updated
- The travis matrix has been updated. Now we test for ruby >= 1.9

### Fixed
- Fixed some typos in the `metadata.json`
- The `Gemfile` has been updated to fix some issues coming with Ruby >= 2

## [0.1.0] - 2016-02-25
### Added
- First public version of the module

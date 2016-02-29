[![Build Status](https://travis-ci.org/tubemogul/puppet-curator.svg?branch=master)](https://travis-ci.org/tubemogul/puppet-curator)
[![Puppet Forge latest release](https://img.shields.io/puppetforge/v/TubeMogul/curator.svg)](https://forge.puppetlabs.com/TubeMogul/curator)
[![Puppet Forge downloads](https://img.shields.io/puppetforge/dt/TubeMogul/curator.svg)](https://forge.puppetlabs.com/TubeMogul/curator)
[![Puppet Forge score](https://img.shields.io/puppetforge/f/TubeMogul/curator.svg)](https://forge.puppetlabs.com/TubeMogul/curator/scores)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with curator](#setup)
    * [What curator affects](#what-curator-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with curator](#beginning-with-curator)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module manages Elasticsearch Curator (https://www.elastic.co/guide/en/elasticsearch/client/curator/current/index.html)

## Module Description

The module will install Curator via the Python PIP package and manage the cronjobs to schedule different Curator commands.

See the official Curator documentation for more details : https://www.elastic.co/guide/en/elasticsearch/client/curator/current/commands.html

## Setup

### What curator affects

* Install Python PIP if not present
* Install elasticsearch-curator PIP package
* Change the crontab

### Setup Requirements

* puppetlabs/stdlib

### Beginning with curator

See : https://www.elastic.co/guide/en/elasticsearch/client/curator/current/getting-started.html

## Usage

### Install Curator

```
class { 'curator': }
```

### Install Curator with a specific version and deploy jobs

```
class { 'curator':
  version => '3.3.0',
  crons   => {
    'logstash-cleanup' => {
      command     => 'delete',
      subcommand  => 'indices',
      parameters  => "--time-unit days --older-than 7 --timestring '\%Y.\%m.\%d' --prefix logstash-",
      cron_minute => 0,
      cron_hour   => 0,
    }
  }
}
```

### Example using Hiera

```
class { 'curator': }
```

```
---
curator::version: 3.3.0
curator::crons:
  logstash:
    command: 'delete'
    subcommand: 'indices'
    parameters: "--time-unit hours --older-than 7 --timestring '\\%Y.\\%m.\\%d.\\%H' --prefix logstash-"
    cron_minute: '30'
    cron_hour: '*/1'
  puppet-report:
    command: 'delete'
    parameters: "--time-unit days --older-than 14 --timestring \\%Y.\\%m.\\%d --prefix puppet-report-"
```


## Limitations

This module has been tested on Ubuntu and should work on Redhat/CentOS too.

For Redhat/CentOS, you will need to deploy the EPEL repository before using the module (See : https://fedoraproject.org/wiki/EPEL). This module doesn't manage EPEL.

## Development

See the CONTRIBUTING.md file. Pull requests are welcome :)

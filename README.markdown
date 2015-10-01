####Table of Contents

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

##Overview

This module manages Elasticsearch Curator (https://www.elastic.co/guide/en/elasticsearch/client/curator/current/index.html)

##Module Description

The curator module setup Curator via Python pip and manage cronjobs to schedule different Curator commands (https://www.elastic.co/guide/en/elasticsearch/client/curator/current/commands.html)

##Setup

###What curator affects

* elasticsearch-curator pip package
* crontab

###Setup Requirements

* The stdlib Puppet library
* Python pip installed

###Beginning with curator

See : https://www.elastic.co/guide/en/elasticsearch/client/curator/current/getting-started.html

##Usage

###Install Curator

```
class {'curator': }
```

###Install Curator with a specific version and deploy jobs

```
class { 'curator':
  version => '3.3.0',
  crons   => {
    logstash-cleanup => {
      command => 'delete',
      subcommand => 'indices',
      parameters => '--time-unit days --older-than 7 --timestring '%Y.%m.%d' --prefix logstash-',
      cron_minute => 0,
      cron_jour => 0,
    }
  }
}
```

###You can also use Hiera

```
class { 'curator': }
```

```
---
curator::crons:
  logstash:
    command: 'delete'
    subcommand: 'indices'
    parameters: "--time-unit days --older-than 7 --timestring '%Y.%m.%d' --prefix logstash-"
    log_file: '/var//curator-elasticsearch-logstash.log'
    cron_minute: 0
    cron_hour: 0
```


##Limitations

This module has only been tested with Ubuntu Trusty.

##Development

See the CONTRIBUTING.md file.

# == Define: tubemogul-curator::cron
#
# Add a cron with specific curator commands
# See : https://www.elastic.co/guide/en/elasticsearch/client/curator/current/commands.html
#
# === Parameters
#
# [*command*]
#   Curator command.
#   See : https://www.elastic.co/guide/en/elasticsearch/client/curator/current/commands.html
#
# [*subcommand*]
#   Curator subcommand. Depending of the command you are running.
#   See : https://www.elastic.co/guide/en/elasticsearch/client/curator/current/_command_tree.html
#
# [*parameters*]
#   String of parameters to pass to the command.
#
# [*cron_minute*]
#   The minute at which to run the cron job.
#
# [*cron_hour*]
#   The hour at which to run the cron job.
#
# [*ensure*]
#   The basic property that the resource should be in.
#
# [*user*]
#   The user who owns the cron job
#
# [*binary*]
#   Binary used for the cron job. By default /usr/local/bin/curator
#
# [*master_only*]
#   If true, Curator will only clean from the Elasticsearch Master node.
#   See : https://www.elastic.co/guide/en/elasticsearch/client/curator/current/master-only.html
#
# [*logfile*]
#   Flag to specify where you want to write logs
#   See : https://www.elastic.co/guide/en/elasticsearch/client/curator/current/loglevel.html
#
# [*loglevel*]
#   Level of logs required.
#
# [*logformat*]
#   Setup the log output. Can be 'default' or 'logstash'.
#   See : https://www.elastic.co/guide/en/elasticsearch/client/curator/current/logformat.html
#
# === Examples
#
#   curator::cron { 'logstash':
#     command    => 'delete'
#     subcommand => 'indices'
#     parameters => "--time-unit days --older-than 7 --timestring '\%Y.\%m.\%d' --prefix logstash-${::ec2_region}-"
#     logfile    => '/mnt/logs/curator-elasticsearch-purge.log'
#   }
#

define curator::cron(
  $command,
  $subcommand  = 'indices',
  $parameters  = undef,
  $cron_minute = '0',
  $cron_hour   = '0',
  $ensure      = 'present',
  $user        = 'root',
  $binary      = '/usr/local/bin/curator',

  # Flags. See : https://www.elastic.co/guide/en/elasticsearch/client/curator/current/flags.html
  $master_only = true,
  $log_file     = '/var/logs/curator.log',
  $log_level    = 'INFO',
  $log_format   = 'default',
) {

  include ::curator

  validate_string($command)
  validate_string($parameters)
  validate_re($subcommand, '^indices|snapshots$')
  validate_bool($master_only)
  validate_re($log_format, '^default|logstash$')
  validate_re($log_level, '^INFO|WARN|DEBUG|ERROR$')

  # Build flags string
  $master_only_flags = $master_only ? {
    true    => '--master-only',
    default => '',
  }

  $flags = "${master_only_flags} --logfile=${log_file} --logformat=${log_format} --loglevel=${log_level}"

  # Build command string
  $cron_cmd = join(delete_undef_values([$command, $subcommand, $parameters]), ' ')

  # Create cronjob
  cron { "cron_curator_${name}":
    ensure  => $ensure,
    user    => $user,
    command => "${binary} ${flags} ${cron_cmd} >/dev/null",
    minute  => $cron_minute,
    hour    => $cron_hour,
  }
}

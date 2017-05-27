# Class: install_config
# Parameters: none
#
# Actions:
#
# Requires: None
#
# Simple class to install and confgure
#
class audit_history_command::install_config
{
file {'/usr/local/bin/hcmnt':
  ensure => present,
  source => 'puppet:///modules/audit_history_command/hcmnt',
  mode   => '755',
  owner  => 'root',
}
file {'/usr/local/bin/caf':
  ensure    => present,
  source    => 'puppet:///modules/audit_history_command/caf',
  mode      => '755',
  owner     => 'root',
  subscribe => File['/usr/local/bin/hcmnt']
}
file {'/tmp/bashrc_lines':
  ensure    => present,
  source    => 'puppet:///modules/audit_history_command/bashrc_lines',
  mode      => '755',
  owner     => 'root',
  subscribe => File['/usr/local/bin/hcmnt']
}
$date = generate ('/usr/bin/date +%Y%m%d')
file {'/var/audit/audit_${date}':
  ensure    => present,
  mode      => '622',
  owner     => 'root',
  subscribe => File['/usr/local/bin/hcmnt']
}
exec {'edit_bashrc':
  command     => '/usr/bin/cat /tmp/bashrc_lines >> /etc/bashrc',
  subscribe   => File['/tmp/bashrc_lines'],
  refreshonly => true,
}

cron {'create_tomorrow_audit_file':
  command => '/usr/local/bin/caf',
  user    => 'root',
  hour    => 22,
  minute  => 23,
}
}
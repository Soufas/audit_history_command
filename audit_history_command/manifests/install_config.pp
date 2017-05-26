class audit_history_command::install_config(
  $bash_rc_text = '
source /usr/local/bin/hcmnt
export hcmntextra=\'date "+%Y%m%d %R"\'
export PROMPT_COMMAND=\'hcmnt -eityu\'
PS1=\'\[\033[01;31m\][\u@\h \w ]\$ \[\033[00m\]\'
',
)
{
file {'/usr/local/bin/hcmnt':
  ensure => present,
  source => 'puppet:///modules/audit_history_command/hcmnt',
  mode   => '755',
  owner  => 'root',
}
file {'/usr/local/bin/caf':
  ensure => present,
  source => 'puppet:///modules/audit_history_command/caf',
  mode   => '755',
  owner  => 'root',
  subscribe => File['/usr/local/bin/hcmnt']
}
file {'/tmp/bashrc_lines':
  ensure => present,
  source => 'puppet:///modules/audit_history_command/bashrc_lines',
  mode   => '755',
  owner  => 'root',
  subscribe => File['/usr/local/bin/hcmnt']
}
exec {'edit_bashrc':
  command => "/usr/bin/cat /tmp/bashrc_lines >> /etc/bashrc",
  subscribe => File['/tmp/bashrc_lines']
}

cron {'create_tomorrow_audit_file':
  command => '/usr/local/bin/caf',
  user    => 'root',
  hour    => 22,
  minute  => 23,
}
}
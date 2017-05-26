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
  before => Exec['edit_bashrc']
}
exec {'edit_bashrc':
  command => "/usr/bin/echo $bash_rc_text >> /etc/bashrc",
  subscribe => File['/usr/local/bin/hcmnt']
}
cron {'create_tomorrow_audit_file':
  command => '/usr/local/bin/caf',
  user    => 'root',
  hour    => 22,
  minute  => 23,
  subscribe => File['/usr/local/bin/caf']
}
}
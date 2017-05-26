# audit_history_command #

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Usage](#usage)
4. [Limitations](#limitations)

## Overview

This is a module to install and configure an immutable log file that contains the bash commands history for all users.
the line with the command contains also the timestamp,user,source ip,current directory

## Module Description

When installing this module , every node will have a log file /var/audit/audit_YYYYMMDD.log file that contains 
the bash commands history for all users.
Every line in the audit_YYYYMMDD.log file will contain the following:
* Command execute
* user
* filesystem
* Source IP address
* date
* time in seconds
* Current directory

Example of lines generated in the audit log file:
```puppet
less /etc/bashrc ### root /dev/pts/0 (122.30.68.5) 20170526 19:07:17 /home/soufas
su root ### seif /dev/pts/0 (122.30.68.7) 20170526 19:11:39 /etc/
}
```

## Usage

Minimal usage:

```puppet
include audit_history_command
```

## Limitations

This module is tested only on RHEL nodes
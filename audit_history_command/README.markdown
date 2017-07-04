# audit_history_command #

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Usage](#usage)
4. [Limitations](#limitations)

## Overview

This is a module to install and configure an immutable log file that contains the bash commands history for all users with other audit informations
The module will allow administrators to monitor and find the history of all commands ran by users on productions systems to help in identifying a cause of an issue after a manual intervention.

## Module Description

When installing this module , every node will have a log file /var/audit/audit_YYYYMMDD.log file that contains 
any command ran by any user on bash along with othe useful information described below .
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
less /etc/bashrc == root /dev/pts/0 (122.30.68.5) 20170526 19:07:17 /home/seif/
su root == seif /dev/pts/0 (122.30.68.7) 20170526 19:11:39 /etc/
cd /etc/puppetlabs/code/environments/production/modules/ == root /dev/pts/1 (192.168.1.4) 20170527 02:52 /root -> /etc/puppetlabs/code/environments/production/modules
ls == root /dev/pts/1 (192.168.1.4) 20170527 02:52 /etc/puppetlabs/code/environments/production/modules
```

Example of immutability of the audit log file even with root user:
```puppet
[root@client ~ ] rm -f /var/audit/audit_20170527.log
rm: cannot remove /var/audit/audit_20170527.log: Operation not permitted
[root@client ~ ] chmod 777 /var/audit/audit_20170527.log
chmod: changing permissions of /var/audit/audit_20170527.log: Operation not permitted
```

## Usage

Minimal usage:

```puppet
include audit_history_command
```

## Limitations

This module is tested only on RHEL servers
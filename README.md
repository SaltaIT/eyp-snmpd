# snmpd

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What snmpd affects](#what-snmpd-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with snmpd](#beginning-with-snmpd)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)
    * [TODO](#todo)
    * [Contributing](#contributing)

## Overview

SNMP agent management

## Module Description

snmpd management: SNMP v1 and v2c ACL management and SNMPv3 user creation

## Setup

### What snmpd affects

* snmpd package
* snmpd service

### Setup Requirements

### Beginning with snmpd

Install snmpd:

```
class { 'snmpd': }
```

## Usage

### disable snmpd

```puppet
class { 'snmpd':
  service_ensure => 'stopped',
  service_enable => false,
}
```

### purge snmpd

```puppet
class { 'snmpd':
  package_ensure => 'purged',
  manage_service => false,
}
```

### SNMP v1 and v2c ACL

```puppet
class { 'snmpd':
  add_default_acls => false,
}

snmpd::acl { 'demo':
  community => '1234567890',
}
```

### SNMPv3 user creation

```puppet
class { 'snmpd':
  add_default_acls => false,
}

snmpd::v3user { 'v3testuser':
  authpass => '1234567890',
  encpass  => '1234567890',
}
```

This setup can be tested vis snmpwalk:

```
# snmpwalk -v3  -l authPriv -u v3testuser -a SHA -A "1234567890"  -x AES -X "1234567890" 127.0.0.1 system
```


## Reference

### snmpd

* basic operations:
  * manage_package        = true,
  * package_ensure        = 'installed',
  * manage_service        = true,
  * manage_docker_service = true,
  * service_ensure        = 'running',
  * service_enable        = true,

### snmp::acl

### snmpd::disk

Relies on fact **::eyp_snmpd_mountpoints** for autoconfiguring disk monitoring if **snmpd::add_disk_monit** is set to true (default is true)

### snmpd::v3user

It is asumed that **/usr/bin/net-snmp-create-v3-user** is a bash script that this module modifies for it's own purposes. The modified script is stored on **/usr/local/bin/puppet_net-snmp-create-v3-user**

## Limitations

Tested on:
* CentOS 5
* CentOS 5
* CentOS 7
* Ubuntu 14.04

## Development

We are pushing to have acceptance testing in place, so any new feature should
have some test to check both presence and absence of any feature

### TODO

TODO list

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

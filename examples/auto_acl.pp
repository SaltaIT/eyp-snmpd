class { 'snmpd':
  add_default_acls => false,
}

class { 'snmpd::loadavg': }

# snmpwalk -v3  -l authPriv -u v3testuser -a SHA -A "1234567890"  -x AES -X "1234567890" 127.0.0.1 system

snmpd::acl { 'demo':
  community     => $::eyp_snmpd_acls['demo']['community'],
  allowed_hosts => $::eyp_snmpd_acls['demo']['hosts'],
}

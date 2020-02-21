class { 'snmpd':
  add_default_acls => false,
}

snmpd::v3user { 'v3testuser':
  authpass => '1234567890',
  encpass  => '1234567890',
}

# snmpwalk -v3  -l authPriv -u v3testuser -a SHA -A "1234567890"  -x AES -X "1234567890" 127.0.0.1 system

snmpd::acl { 'demo':
  community => '1234567890',
}

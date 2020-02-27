class { 'snmpd':
  add_default_acls => false,
}

class { 'snmpd::loadavg': }

# snmpwalk -v3  -l authPriv -u v3testuser -a SHA -A "1234567890"  -x AES -X "1234567890" 127.0.0.1 system

snmpd::acl { 'demoacl':
  community     => 'abcdefghjiklmn',
  allowed_hosts => '1.1.1.1',
}

snmpd::acl { 'autoacl1':
  community     => $::eyp_snmpd_acls['autoacl1']['community'],
  allowed_hosts => $::eyp_snmpd_acls['autoacl1']['hosts'],
}

snmpd::acl { 'autoacl2':
  auto_acl => true,
}

class { 'snmpd': }

snmpd::v3user { 'demov3user':
  authpass => '1234567890',
  encpass  => 'abcdefghij',
}

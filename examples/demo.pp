class { 'snmpd': }

snmpd::v3user { 'demov3user':
  authpass => 'abc',
  encpass  => 'abc',
}

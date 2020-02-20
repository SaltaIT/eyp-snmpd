class { 'snmpd': }

snmpd::v3user { 'demov3':
  authpass => 'abc',
  encpass  => 'abc',
}

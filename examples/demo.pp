class { 'snmpd': }

snmpd::v3user { 'demo':
  authpass => 'abc',
  encpass  => 'abc',
}

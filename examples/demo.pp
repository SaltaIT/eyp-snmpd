class { 'snmpd': }

snmpd::v3user { 'v3testuser':
  authpass => '1234567890',
  encpass  => '1234567890',
}

define snmpd::v3user(
                      $authpass,
                      $encpass,
                      $username = $name,
                      $ro             = false,
                      $enc_algorithm  = 'AES',
                      $auth_algorithm = 'SHA',
                    ) {

  include ::snmpd
  # service snmpd stop
  # net-snmp-create-v3-user -ro -A <snmpv3authPass> -a SHA -X <snmpv3encPass> -x AES <snmpv3user>
  # service snmpd start

  if($ro)
  {
    $ro_flag = '-ro'
  }
  else
  {
    $ro_flag = ''
  }

  exec { 'fix snmpdv3 create user':
    command => "/usr/local/bin/puppet_net-snmp-create-v3-user ${ro_flag} -A ${authpass} -a ${auth_algorithm} -X ${authpass} -x ${enc_algorithm}",
    unless => '',
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
    require => Class['::snmpd'],
  }

}

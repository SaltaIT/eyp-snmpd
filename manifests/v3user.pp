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
    $kind_v3_user = 'rouser'
  }
  else
  {
    $ro_flag = ''
    $kind_v3_user = 'rwuser'
  }

  exec { "create snmpdv3 user ${username}":
    command => "/usr/local/bin/puppet_net-snmp-create-v3-user ${ro_flag} -A ${authpass} -a ${auth_algorithm} -X ${authpass} -x ${enc_algorithm} ${username}",
    unless  => 'false',
    path    => '/usr/sbin:/usr/bin:/sbin:/bin',
    require => Class['::snmpd::install'],
    notify  => Class['::snmpd::service'],
  }

  # rwuser demo
  concat::fragment { "snmpv3 create user ${username}":
    target  => '/etc/snmp/snmpd.conf',
    order   => '99',
    content => template("${module_name}/v3user.erb"),
  }

}

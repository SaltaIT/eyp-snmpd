class snmpd::install inherits snmpd {

  if($snmpd::manage_package)
  {
    package { $snmpd::params::package_name:
      ensure => $snmpd::package_ensure,
    }

    exec { 'fix snmpd create user':
      command => "sed 's/^if.*snmpd[^;]*/if false/' ${snmpd::params::create_user_snmpd_v3} > /usr/local/bin/puppet_net-snmp-create-v3-user",
      unless => 'grep "if false" /usr/local/bin/puppet_net-snmp-create-v3-user',
      path => '/usr/sbin:/usr/bin:/sbin:/bin',
      require => Package[$snmpd::params::package_name],
    }
  }

}

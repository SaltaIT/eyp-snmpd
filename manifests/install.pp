class snmpd::install inherits snmpd {

  if($snmpd::manage_package)
  {
    package { $snmpd::params::package_name:
      ensure => $snmpd::package_ensure,
    }

    exec { 'fix snmpdv3 create user':
      command => "sed -e 's/^if.*snmpd[^;]*/if false/' -e 's@/etc/snmp/snmpd.conf@/dev/null@' ${snmpd::params::create_user_snmpd_v3} > /usr/local/bin/puppet_net-snmp-create-v3-user",
      unless => 'grep "if false" /usr/local/bin/puppet_net-snmp-create-v3-user',
      path => '/usr/sbin:/usr/bin:/sbin:/bin',
      require => Package[$snmpd::params::package_name],
    }

    file { '/usr/local/bin/puppet_net-snmp-create-v3-user':
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => Exec['fix snmpdv3 create user'],
    }
  }

}

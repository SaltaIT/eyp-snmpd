class snmpd::config inherits snmpd {

  if($snmpd::manage_package and $snmpd::package_ensure!='absent')
  {
    concat { '/etc/snmp/snmpd.conf':
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0600',
    }

    concat::fragment { 'base snmpd v2':
      target  => '/etc/snmp/snmpd.conf',
      order   => '00',
      content => template("${module_name}/snmpdconf.erb"),
    }

    if($snmpd::add_disk_monit)
    {
      snmpd::disk { 'mountpoints':
        disks => $::eyp_snmpd_mountpoints,
      }
    }
  }
}

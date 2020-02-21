class snmpd::loadavg(
                      $load1  = '2',
                      $load5  = '4',
                      $load15 = '6',
                    ) inherits snmpd::params{

  include ::snmpd

  concat::fragment { 'eyp-snmpd - load':
    target  => '/etc/snmp/snmpd.conf',
    order   => '02',
    content => template("${module_name}/load.erb"),
  }
}

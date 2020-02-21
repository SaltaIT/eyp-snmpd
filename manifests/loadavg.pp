class snmpd::loadavg(
                      $load1  = max(2, ceiling(sprintf('%d', ($::processorcount)*2.8))),
                      $load5  = max(2, ceiling(sprintf('%d', ($::processorcount)*2.6))),
                      $load15 = max(2, ceiling(sprintf('%d', ($::processorcount)*2.5))),
                    ) inherits snmpd::params{

  include ::snmpd

  concat::fragment { 'eyp-snmpd - load':
    target  => '/etc/snmp/snmpd.conf',
    order   => '02',
    content => template("${module_name}/load.erb"),
  }
}

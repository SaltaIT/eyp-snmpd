class snmpd::load(
                    $load1  = max(2, ceiling(sprintf('%d', ($::processorcount)*2.7))),
                    $load5  = max(4, ceiling(sprintf('%d', ($::processorcount)*2.5)),
                    $load15 = max(6, ceiling(sprintf('%d', ($::processorcount)*2.3))),
                  ) inherits snmpd::params {

  include ::snmpd

  concat::fragment { 'eyp-snmpd - load':
    target  => '/etc/snmp/snmpd.conf',
    order   => '02',
    content => template("${module_name}/load.erb"),
  }
}

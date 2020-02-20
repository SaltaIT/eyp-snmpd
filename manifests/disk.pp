define snmpd::disk(
                    $disks       = [],
                    $disk        = undef,
                    $description = $name,
                    $order       = '42',
                  ) {

  concat::fragment { 'base snmpd v2':
    target  => '/etc/snmp/snmpd.conf',
    order   => "01-${order}",
    content => template("${module_name}/disk.erb"),
  }
}

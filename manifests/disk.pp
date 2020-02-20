define snmpd::disk(
                    $disks       = [],
                    $disk        = undef,
                    $description = $name,
                    $order       = '42',
                  ) {

  concat::fragment { "eyp-snmpd - disk ${disk} ${disks}":
    target  => '/etc/snmp/snmpd.conf',
    order   => "01-${order}",
    content => template("${module_name}/disk.erb"),
  }
}

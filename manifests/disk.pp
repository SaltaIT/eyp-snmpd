define snmpd::disk(
                    $disks       = [],
                    $disk        = undef,
                    $description = $name,
                    $order       = '42',
                  ) {

  # TODO:
  # disk PATH [MIN=100000]
  #
  # PATH:  mount path to the disk in question.
  # MIN:   Disks with space below this value will have the Mib's errorFlag set.
  #        Default value = 100000.

  concat::fragment { "eyp-snmpd - disk ${disk} ${disks}":
    target  => '/etc/snmp/snmpd.conf',
    order   => "01-${order}",
    content => template("${module_name}/disk.erb"),
  }
}

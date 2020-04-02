define snmpd::extend(
                      $script,
                      $extend_name        = $name,
                      $description = undef,
                      $mib_oid     = undef,
                      $order       = '42',
                  ) {
  # extend [MIBOID] NAME PROG ARGS
  #       works  in a similar manner to the exec directive, but with a number of improvements.  The MIB tables (nsExtendConfigTable etc) are indexed by the NAME token, so are unaffected by the order in
  #       which entries are read from the configuration files.  There are two result tables - one (nsExtendOutput1Table) containing the exit status, the first line and full output (as a single  string)
  #       for each extend entry, and the other (nsExtendOutput2Table) containing the complete output as a series of separate lines.
  #
  #       If  MIBOID  is  specified, then the configuration and result tables will be rooted at this point in the OID tree, but are otherwise structured in exactly the same way. This means that several
  #       separate extend directives can specify the same MIBOID root, without conflicting.
  #
  #       The exit status and output is cached for each entry individually, and can be cleared (and the caching behaviour configured) using the nsCacheTable.

  concat::fragment { "eyp-snmpd - extend ${extend_name}":
    target  => '/etc/snmp/snmpd.conf',
    order   => "02-${order}",
    content => template("${module_name}/extend.erb"),
  }
}

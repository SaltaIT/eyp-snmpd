define snmpd::acl (
                    $community,
                    $description       = undef,
                    $order             = '42',
                    $security_name     = $name,
                    $group_name        = $name,
                    $view_name         = "view_${name}",
                    $allowed_hosts     = [ '127.0.0.1/32' ],
                    $security_model    = [ 'v1', 'v2c' ],
                    $included_subtrees = [ '.1' ],
                    $read              = true,
                    $write             = false,
                    $context           = 'prefix',
  ) {
  include ::snmpd

  concat::fragment { "snmpd ACL ${security_name} ${community} ${group_name}":
    target  => '/etc/snmp/snmpd.conf',
    order   => "02-${order}",
    content => template("${module_name}/acl.erb"),
  }

}

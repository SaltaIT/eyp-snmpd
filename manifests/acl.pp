define snmpd::acl (
                    $community         = undef,
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
                    $auto_acl          = false,
  ) {
  include ::snmpd

  if($auto_acl)
  {
    $comunity_parsed = $::eyp_snmpd_acls[$security_name]['community']
    $allowed_hosts_parsed = $::eyp_snmpd_acls[$security_name]['hosts']
  }
  else
  {
    if($community == undef)
    {
      fail('community is not an optional argument unless $auto_acl is set to true')
    }
    else
    {
      $comunity_parsed = $community
      $allowed_hosts_parsed = $allowed_hosts
    }
  }

  concat::fragment { "snmpd ACL ${security_name} ${community} ${group_name}":
    target  => '/etc/snmp/snmpd.conf',
    order   => "10-${order}",
    content => template("${module_name}/acl.erb"),
  }
}

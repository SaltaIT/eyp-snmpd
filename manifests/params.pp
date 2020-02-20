class snmpd::params {

  $service_name = 'snmpd'
  $create_user_snmpd_v3 = '/usr/bin/net-snmp-create-v3-user'

  case $::osfamily
  {
    'redhat':
    {
      $package_name = [ 'net-snmp', 'net-snmp-utils' ]

      case $::operatingsystemrelease
      {
        /^[5-8].*$/:
        {
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      $package_name = 'snmpd'

      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^1[468].*$/:
            {
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}

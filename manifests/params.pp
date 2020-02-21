class snmpd::params {

  $service_name = 'snmpd'
  $create_user_snmpd_v3 = '/usr/bin/net-snmp-create-v3-user'

  case $::osfamily
  {
    'redhat':
    {
      $package_name = [ 'net-snmp', 'net-snmp-utils' ]
      $net_snmpd_persistent_datafile = '/var/lib/net-snmp/snmpd.conf'

      case $::operatingsystemrelease
      {
        /^[5-6].*$/:
        {
          $servicectl_stop = "service ${service_name} stop"
        }
        /^[7-8].*$/:
        {
          $servicectl_stop = "systemctl stop ${service_name}"
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      $package_name = [ 'snmpd', 'libsnmp-dev' ]
      $net_snmpd_persistent_datafile = '/var/lib/snmp/snmpd.conf'

      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^1[4].*$/:
            {
              $servicectl_stop = "service ${service_name} stop"
            }
            /^1[68].*$/:
            {
              $servicectl_stop = "systemctl stop ${service_name}"
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

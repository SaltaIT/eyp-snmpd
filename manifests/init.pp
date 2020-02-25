# @param manage_package Selects if this puppet module manages the package (default: true)
# @param package_ensure What state the package should be in (default: installed)
# @param manage_service controls whether service definition should be managed by Puppet (default: true)
# @param manage_docker_service controls whether service definition should be managed by Puppet in a docker container (default: true)
# @param service_ensure Whether a service should be running. Valid values are stopped (also called false), running (default: running)
# @param service_enable Whether a service should be enabled to start at boot
# @param comunity SNMP comunity (default: public)
# @param subtree subtrees to publish (default: '.1.3.6.1.2.1.1', '.1.3.6.1.2.1.25.1.1')
# @param allowed_hosts list of allowed hosts
# @param syslocation System contact information: location (default: somewhere)
# @param syscontact System contact information: contact (default: someone)
class snmpd (
              $manage_package                 = true,
              $package_ensure                 = 'installed',
              $manage_service                 = true,
              $manage_docker_service          = true,
              $service_ensure                 = 'running',
              $service_enable                 = true,
              $community                      = 'public',
              $subtree                        = [ '.1.3.6.1.2.1.1', '.1.3.6.1.2.1.25.1.1' ],
              $allowed_hosts                  = [ 'default' ],
              $syslocation                    = 'somewhere',
              $syscontact                     = 'someone',
              $dont_log_tcp_wrappers_connects = true,
              $add_disk_monit                 = true,
              $add_default_acls               = true,
            ) inherits snmpd::params{

  class { '::snmpd::install': } ->
  class { '::snmpd::config': } ~>
  class { '::snmpd::service': } ->
  Class['::snmpd']

}

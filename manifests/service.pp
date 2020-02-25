class snmpd::service inherits snmpd {

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $snmpd::manage_docker_service)
  {
    if($snmpd::manage_service)
    {
      service { $snmpd::params::service_name:
        ensure => $snmpd::service_ensure,
        enable => $snmpd::service_enable,
      }
    }
  }
}

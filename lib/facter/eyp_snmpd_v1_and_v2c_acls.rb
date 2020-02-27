snmp_users = Facter::Util::Resolution.exec('bash -c \'grep com2sec /etc/snmp/snmpd.conf | awk "{ print \$2 }" | sort | uniq\'').to_s

unless snmp_users.nil? or snmp_users.empty?
  snmp_acls = {}

  for snmp_user in snmp_users.split("\n")
  	snmp_user_hosts = Facter::Util::Resolution.exec("bash -c 'grep com2sec /etc/snmp/snmpd.conf | grep #{snmp_user} | awk \"{ print \\$3 }\" | sort | uniq'").to_s.split("\n")
    snmp_user_community = Facter::Util::Resolution.exec("bash -c 'grep com2sec /etc/snmp/snmpd.conf | grep #{snmp_user} | awk \"{ print \\$4 }\" | sort | head -n1'").to_s

    snmp_acls[snmp_user] = { 'hosts' => snmp_user_hosts, 'community' => snmp_user_community }
  end

  Facter.add('eyp_snmpd_acls') do
      setcode do
        snmp_acls
      end
  end
end

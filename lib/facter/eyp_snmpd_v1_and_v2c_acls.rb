snmmp_users = Facter::Util::Resolution.exec('bash -c \'grep com2sec /etc/snmp/snmpd.conf | awk "{ print \$2 }" | sort | uniq\'').to_s

unless snmmp_users.nil? or snmmp_users.empty?
  # Facter.add('eyp_snmpd_acls') do
  #     setcode do
  #       snmmp_users.split("\n")
  #     end
  # end

  snmp_acls = {}

  for snmmp_user in snmmp_users
  	snmp_user_hosts = Facter::Util::Resolution.exec('bash -c \'grep com2sec /etc/snmp/snmpd.conf | grep #{snmmp_user} | awk "{ print \$3 }" | sort | uniq\'').to_s.split("\n")
    snmp_user_community = Facter::Util::Resolution.exec('bash -c \'grep com2sec /etc/snmp/snmpd.conf | awk "{ print \$4 }" | sort | head -n1\'').to_s

    snmp_acls[snmmp_user] = { 'hosts' => snmp_user_hosts, 'community' => snmp_user_community }
  end

  Facter.add('eyp_snmpd_acls') do
      setcode do
        snmp_acls
      end
  end
end

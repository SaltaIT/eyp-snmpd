mounts = Facter::Util::Resolution.exec('bash -c \'df -TP | grep -v "\btmpfs\b\|\bdevtmpfs\b\|^Filesystem" | awk "{ print \$NF }"\'').to_s

unless mounts.nil? or mounts.empty?
  Facter.add('eyp_snmpd_mountpoints') do
      setcode do
        mounts
      end
  end
end

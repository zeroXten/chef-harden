case node.platform_family
when 'debian'
  include_recipe 'apt'
when 'rhel'
  package 'yum-security'
end

cookbook_file '/usr/bin/list-security-updates' do
  owner 'root'
  group 'root'
  mode 0755
end

bash 'first-list-security-updates' do
  command '/usr/bin/list-security-updates | wc -l > /var/tmp/security-updates-count'
  not_if 'test -r /var/tmp/security-updates-count'
end

cron 'list-security-updates' do
  user 'root'
  command '/usr/bin/list-security-updates | wc -l > /var/tmp/security-updates-count'
end

# security updates
define /must have no security updates pending/ do
  command 'check_security_updates'
  code <<-EOF
    #!/bin/bash

    security_updates=$(cat /var/tmp/security-updates-count)

    if [[ -z "$security_updates" ]]; then
      echo "UNKNOWN - Problem reading /var/tmp/security-updates-count"; exit 3
    elif [[ "$security_updates" == "0" ]]; then
      echo "OK - There are 0 security updates pending"; exit 0
    else
      echo "CRITICAL - There are ${security_updates} security updates pending"; exit 2
    fi
  EOF
end

describe 'harden' do
  describe 'security updates' do

    describe 'command' do
      it 'must have command list-security-updates'
    end

    describe 'count' do
      it 'must have no security updates pending'
    end

  end
end

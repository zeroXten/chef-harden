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

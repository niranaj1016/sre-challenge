if node['platform_version'].to_i == 7
  package 'iptables-services'
else
  package 'iptables'
  if node['platform'] == 'ubuntu'
    package 'iptables-persistent'
  end
end

file '/etc/init/iptables.conf' do
  action :create
end

execute 'iptables-flush-input' do
  command 'iptables -F INPUT'
end

service 'iptables' do
  action [:enable, :start]
end

ports = node['iptables']['allowed']['ports']

ports.each do |port|
  execute "iptablerules" do
     command "iptables -A INPUT -p tcp --dport #{port} -j ACCEPT"
  end
end

if node['platform'] == 'ubuntu'
  execute 'iptables-save' do
    command 'service iptables-persistent save'
  end
else
  execute 'iptables-save' do
    command 'service iptables save'
  end
end


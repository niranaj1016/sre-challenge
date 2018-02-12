#
# Cookbook:: slm-test
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

directory '/data' do
  action :create
  owner 'root'
  group 'root'
end

directory '/data/www' do
  action :create
  owner 'root'
  group 'root'
end

directory '/data/www/html' do
  action :create
  owner 'root'
  group 'root'
end

package "nginx" do
  action :install
end

nginx_dir = node['nginx']['dir']
ssl_key_path = node['nginx']['ssl']['keypath']
ssl_cert_path = node['nginx']['ssl']['certpath']

directory "#{nginx_dir}/ssl" do
  action :create
  owner 'root'
  group 'root'
end

directory '/data/www/html' do
  action :create
  owner 'root'
  group 'root'
end

cert = ssl_certificate 'sre-nginx' do
  namespace node['sre-nginx']
  common_name node['nginx']['server_name']
  key_path ssl_key_path
  cert_path ssl_cert_path
end

cookbook_file '/data/www/html/index.html' do
  source 'index.html'
  owner 'root'
  group 'root'
  action :create
end

template "#{nginx_dir}/nginx.conf" do
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode 0644
  variables(server_name: node['nginx']['server_name'],
            cert_file: cert.cert_path,
            key_file: cert.key_path,
            access_log: node['nginx']['access_log'],
            error_log: node['nginx']['error_log'],
            ssl_protocol: node['nginx']['ssl']['protocol'])
end

service 'nginx' do
 supports :status => true, :restart => true, :reload => true
 action [:enable, :start]
 subscribes :reload, "template[#{nginx_dir}/nginx.conf]", :immediately
end


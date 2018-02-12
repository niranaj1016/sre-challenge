require 'serverspec'

set :backend, :exec

describe file('/etc/nginx/ssl/sre-nginx.pem') do
  it { should exist }
  it { should be_owned_by('root') }
  it { should be_grouped_into('root') }
end

describe file('/etc/nginx/ssl/sre-nginx.pem') do
  it { should exist }
  it { should be_owned_by('root') }
  it { should be_grouped_into('root') }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe port(443) do
  it { should be_listening }
end

describe command('curl -v -s -k --noproxy "*" http://localhost/') do
  its(:stderr) { should match 'HTTP/1.1 301 Moved Permanently' }
end

describe command('curl -v -s -k --noproxy "*" https://localhost:443/') do
  its(:stderr) { should match 'HTTP/1.1 200 OK' }
end


default['nginx']['dir'] = '/etc/nginx'
default['nginx']['ssl']['keypath'] = '/etc/nginx/ssl/sre-nginx.key'
default['nginx']['ssl']['certpath'] = '/etc/nginx/ssl/sre-nginx.pem'
default['nginx']['server_name'] = 'example.com'
default['sre-nginx']['common_name'] = 'example.com'
default['sre-nginx']['ssl_key']['source'] = 'data-bag'
default['sre-nginx']['ssl_key']['bag'] = 'secrets'
default['sre-nginx']['ssl_key']['item'] = 'ssl-nginx'
default['sre-nginx']['ssl_key']['item_key'] = 'key'

default['sre-nginx']['ssl_cert']['source'] = 'data-bag'
default['sre-nginx']['ssl_cert']['bag'] = 'secrets'
default['sre-nginx']['ssl_cert']['item'] = 'ssl-nginx'
default['sre-nginx']['ssl_cert']['item_key'] = 'cert'

default['nginx']['ssl']['protocol'] = 'TLSv1 TLSv1.1 TLSv1.2'
default['nginx']['access_log'] = '/var/log/nginx/access.log'
default['nginx']['error_log'] = '/var/log/nginx/error.log'


#iptables
default['iptables']['allowed']['ports'] = ['80', '443', '22']


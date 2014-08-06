directory '/var/www/miclo' do
  owner 'ops'
  action :create
  recursive true
end

template '/etc/nginx/sites-available/default' do
  action :create
  source 'default.conf.erb'
  notifies :reload, 'service[nginx]'
end


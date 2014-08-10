template '/etc/mysql/my.cnf' do
  action :create
  source 'my.conf.erb'
  notifies :restart, 'mysql_service[default]'
end


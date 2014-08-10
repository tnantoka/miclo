include_recipe 'database::mysql'

mysql_connection_info = {
  host: 'localhost',
  username: 'root',
  password: node['mysql']['server_root_password']
}

mysql_database node.miclo_cookbook.db_name do
  connection mysql_connection_info
  action :create
  encoding 'utf8mb4'
end


#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "yum update" do
  command "yum update"
end

package 'nginx' do
  action :install
end

service 'nginx' do
  action [ :enable, :start ]
end

cookbook_file "/var/www/index.html" do
  source "index.html"
  mode "0644"
end


package 'mlocate' do
  action :install
end
execute "updatedb" do
  command "updatedb"
end

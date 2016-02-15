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

directory '/etc/nginx/ssl' do
  owner 'root'
  group 'root'
  mode '0731'
  action :create
end

directory '/etc/nginx/ssl/hipcricket' do
  owner 'root'
  group 'root'
  mode '0731'
  action :create
end

cookbook_file "/etc/nginx/ssl/hipcricket/star_hipcricket.com.pem" do
  source "star_hipcricket.com.pem"
  mode "0644"
end

cookbook_file "/etc/nginx/ssl/hipcricket/star_hipcricket.com.key" do
  source "star_hipcricket.com.key"
  mode "0644"
end

cookbook_file "/etc/nginx/conf.d/server.conf" do
  source "server.conf"
  mode "0644"
end

cookbook_file "/etc/nginx/conf.d/upstream.conf" do
  source "upstream.conf"
  mode "0644"
end

service 'nginx' do
  action [ :enable, :start ]
end


package 'mlocate' do
  action :install
end
execute "updatedb" do
  command "updatedb"
end

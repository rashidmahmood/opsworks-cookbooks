#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#execute "yum -y update" do
#  command "yum -y update"
#end

package 'nginx' do
  action :install
end

directory '/etc/nginx/ssl' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

directory '/etc/nginx/ssl/hipcricket' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file "/etc/nginx/nginx.conf" do
  source "nginx.conf"
  mode "0644"
end


cookbook_file "/etc/nginx/ssl/hipcricket/star-hipcricket-com.pem" do
  source "star-hipcricket-com.pem"
  mode "0644"
end

cookbook_file "/etc/nginx/ssl/hipcricket/star-hipcricket-com.key" do
  source "star-hipcricket-com.key"
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

package 's3cmd' do
  action :install
end

####################################
#local web configs
cookbook_file "/etc/nginx/conf.d/mock-g-aug-me.conf" do
  source "mock-g-aug-me.conf"
  mode "0644"
end
directory '/var/www/html/mock-g-aug-me' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

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

package 'nagios-plugins-all' do
  action :install
end

package 'nagios-plugins-nrpe' do
  action :install
end

package 'nrpe' do
  action :install
end

cookbook_file "/etc/nagios/nrpe.cfg" do
  source "nrpe.cfg"
  mode "0644"
end

cookbook_file "/usr/lib64/nagios/plugins/check_diskstat.sh" do
  source "check_diskstat.sh"
  mode "0644"
end
#directory '/etc/nginx/ssl' do
#  owner 'root'
#  group 'root'
#  mode '0731'
#  action :create
#end


#cookbook_file "/etc/nginx/ssl/hipcricket/star_hipcricket.com.pem" do
#  source "star_hipcricket.com.pem"
#  mode "0644"
#end


service 'nrpe' do
  action [ :enable, :start ]
end



package 'mlocate' do
  action :install
end
execute "updatedb" do
  command "updatedb"
end

#
# Cookbook Name:: logstash
# Recipe:: default
#
# Copyright 2016, Hipcricket Incorporation
#
# All rights reserved - Do Not Redistribute
#
execute "rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch" do
  command "rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch"
end
cookbook_file "/etc/yum.repos.d/logstash.repo" do
  source "logstash.repo"
  mode "0644"
end
package 'logstash' do
  action :install
end
cookbook_file "/etc/logstash/conf.d/nginx.conf" do
  source "nginx.conf"
  mode "0644"
end
service 'logstash' do
  action [ :enable, :start ]
end

#cookbook_file "/usr/lib64/nagios/plugins/check_diskstat.sh" do
#  source "check_diskstat.sh"
#  mode "0644"
#end
#directory '/etc/nginx/ssl' do
#  owner 'root'
#  group 'root'
#  mode '0731'
#  action :create
#end
#service 'nrpe' do
#  action [ :enable, :start ]
#end

#package 'mlocate' do
#  action :install
#end
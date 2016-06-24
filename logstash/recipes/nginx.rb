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
execute "/opt/logstash/bin/logstash-plugin install logstash-output-amazon_es" do
  command "/opt/logstash/bin/logstash-plugin install logstash-output-amazon_es"
end
cookbook_file "/etc/logstash/conf.d/nginx.conf" do
  source "nginx.conf"
  mode "0644"
end
cookbook_file "/etc/init.d/logstash" do
  source "logstash"
  mode "0755"
end
execute "/etc/init.d/logstash stop" do
  command "/etc/init.d/logstash stop"
end
service 'logstash' do
  action [ :enable, :start ]
end

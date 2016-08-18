# Cookbook Name:: op-smtprelay
# Recipe:: default
#
# Copyright 2016, Hipcricket Incorporation
#
# All rights reserved - Do Not Redistribute
#
directory '/var/services/smtprelay/' do
  owner 'root'
  group 'root'
  mode '0731'
  recursive true
  action :create
end
cookbook_file "/var/services/smtprelay/smtprelay.sh" do
  source "smtprelay.sh"
  mode "0755"
end
cookbook_file "/var/services/smtprelay/main" do
  source "main"
  mode "0755"
end
execute "Setup SMTPRelay" do
  command "sh /var/services/smtprelay/smtprelay.sh"
end
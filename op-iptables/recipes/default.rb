# Cookbook Name:: op-iptables
# Recipe:: default
#
# Copyright 2016, Hipcricket Incorporation
#
# All rights reserved - Do Not Redistribute
#
directory '/var/services/' do
  owner 'root'
  group 'root'
  mode '0731'
  action :create
end
cookbook_file "/var/services/iptables.sh" do
  source "iptables.sh"
  mode "0755"
end
#execute "Setup Iptables" do
#  command "sh /var/services/iptables.sh"
#end
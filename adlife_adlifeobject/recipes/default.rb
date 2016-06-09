#
# Cookbook Name:: adlife_adlife
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
# ["/var/log/api", "/var/log/db"].each do | path|
# 	directory path do
# 		owner 'apache'
# 		group 'apache'
# 		mode '0755'
# 		recursive true
# 		action :create
# 	end
# end

package 'postgresql93' do
    action :install
end

%w(/var/log/api /var/log/adlife /var/log/adserve /var/log/adserve_csv /var/log/stats/ /var/log/db  /var/log/adlifeobject).each do |path|
    directory path do
        owner 'apache'
        group 'apache'
        mode '0755'
        recursive true
        action :create
    end
end

directory '/srv/www/adlifeobject/shared/recycle' do
    owner 'apache'
    group 'apache'
    mode '0755'
    recursive true
    action :create
end

%w(/srv/www/adlifeobject/current/class/wurfl/storage /srv/www/adlifeobject/current/class/wurfl/storage/persistence /srv/www/adlifeobject/current/class/wurfl/storage/cache).each do |path|
    directory path do
        owner 'apache'
        group 'apache'
        mode '0775'
        recursive true
        action :create
    end
end

template '/srv/www/adlifeobject/shared/recycle/key.php' do
    source 'key.php.erb'
    mode 0664
    owner 'root'
    group 'root'
end

template '/srv/www/adlifeobject/current/_includes/obj.conf' do
    source 'obj.conf.erb'
    mode 0664
    owner 'root'
    group 'root'
    variables(app_config: node[:appConfig],
              adlifeGateway: node[:appConfig][:adlifeGateway])
end

template '/srv/www/adlifeobject/current/config/app.json' do
    source 'config.json.erb'
    mode 0664
    owner 'root'
    group 'root'
end

link '/srv/www/adlifeobject/current/recycle' do
    to '/srv/www/adlifeobject/shared/recycle'
end

include_recipe 'adlife_adlifeobject::crons'

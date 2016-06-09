install_dir = '/srv/www/adlifeobject/current'

cron 'noop' do
    action :nothing
end
cron 'noop3' do
    action :nothing
end

cron 'log_stat' do
    command "php #{install_dir}/cron/log_stat.php"
    action :delete
end

cron 'build_cvin' do
    command "php #{install_dir}/unit_test/build_cvin.php"
    minute '1'
    hour '13,16'
    action :nothing
end

cron 'adserve_stats_csv_upload' do
    command "php #{install_dir}/cron/adserve_stats_csv_upload.php"
    action :nothing
end

cron 'adserve_stats' do
    command "php #{install_dir}/cron/adserve_stats.php"
    action :nothing
end

cron 'adserve_pings' do
    command "php #{install_dir}/cron/adserve_pings.php"
    action :nothing
end

cron 'nts' do
    command "php #{install_dir}/cron/nts.php"
    action :nothing
    minute '15,30'
end

cron 'download_keys' do
    command '/usr/bin/wget -q -O- http://localhost/rest/index.php/cron/downloadkeys &> /root/downloadkeys'
    action :create
    minute '*/5'
end

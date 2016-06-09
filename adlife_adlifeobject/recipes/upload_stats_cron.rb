install_dir = '/srv/www/adlifeobject/current'

cron 'move_stats' do
    command "php #{install_dir}/cron/moveStats.php"
    action :create
    minute '*/5'
end

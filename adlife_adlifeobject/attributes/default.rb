normal[:app_logs_find][:logs] = %w[ /var/log/api/* /var/log/db/* ]
normal[:app_logs_rotate][:logs] = %w[ /var/log/adserve/stat_processing.log /var/log/adlife/stat_processing.log /var/log/adserve_csv/stat_processing.log /var/log/adlifeobject/*.log ]

#normal['newrelic']['application_monitoring']['app_name'] = 'Prod Object'

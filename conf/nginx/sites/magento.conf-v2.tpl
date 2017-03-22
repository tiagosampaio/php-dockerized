#####################
# NON-SSL Configuration
#####################
server {
  server_name  dev.magento.com magento.dev magento.local;
  root         /var/www/html/magento;
  index        index.php;

  client_max_body_size 100M;
  fastcgi_read_timeout 1800;

  location / {
    try_files $uri $uri/ /index.php$is_args$args;
  }

  ### This shows the status for the VHost configuration. Eg: 'http://dev.magento.com/status'
  location /status {
    access_log off;
    allow 172.17.0.0/16;
    deny all;
    include /etc/nginx/fastcgi_params;
    fastcgi_param SCRIPT_FILENAME /status;
    fastcgi_pass unix:/var/run/php5-fpm.sock;
  }

  ### This pings the vhost to check if the request is reaching the NGinx correctly. Eg: 'http://dev.magento.com/ping'
  location /ping {
    access_log off;
    allow all;
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME /ping;
    fastcgi_pass unix:/var/run/php5-fpm.sock;
  }

  location /denied {
    deny all;
  }

  location /api {
    rewrite        ^/api/rest    /api.php?type=rest    last;
    rewrite        ^/api/v2_soap /api.php?type=v2_soap last;
    rewrite        ^/api/soap    /api.php?type=soap    last;
    include        fastcgi_params;
    fastcgi_pass   unix:/var/run/php5-fpm.sock;
    fastcgi_param  SCRIPT_FILENAME  $document_root/api.php;
  }

  location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
    expires       max;
    log_not_found off;
    access_log    off;
  }

  location ~ \.php$ {
    try_files       $uri =404;
    include         fastcgi_params;
    fastcgi_index   index.php;
    fastcgi_param   SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_param   MAGE_IS_DEVELOPER_MODE 'on'; ### Must be always on
    fastcgi_param   MAGE_RUN_CODE ''; ### You can change this according to the requirements
    fastcgi_param   MAGE_RUN_TYPE 'website'; ### You can change this according to the requirements
    fastcgi_pass    unix:/var/run/php5-fpm.sock;
    access_log      /var/log/nginx/magento-access.log main;
    error_log       /var/log/nginx/magento-error.log;
  }

}


#####################
# SSL Configuration
#####################
server {
  server_name  dev.magento.com magento.dev magento.local;
  root         /var/www/html/magento;
  index        index.php;

  client_max_body_size 100M;
  fastcgi_read_timeout 1800;

  ### Note that here is basically the difference.
  listen 443 ssl;
  ssl on;
  ssl_certificate_key /etc/ssl/local/website/certificate.key;
  ssl_certificate     /etc/ssl/local/website/certificate.crt;
  ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
  ssl_ciphers         HIGH:!aNULL:!MD5;

  location / {
    try_files $uri $uri/ /index.php$is_args$args;
  }

  location /status {
    access_log off;
    allow 172.17.0.0/16;
    deny all;
    include /etc/nginx/fastcgi_params;
    fastcgi_param SCRIPT_FILENAME /status;
    fastcgi_pass unix:/var/run/php5-fpm.sock;
  }

  location /ping {
    access_log off;
    allow all;
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME /ping;
    fastcgi_pass unix:/var/run/php5-fpm.sock;
  }

  location /denied {
    deny all;
  }

  location /api {
    rewrite        ^/api/rest    /api.php?type=rest    last;
    rewrite        ^/api/v2_soap /api.php?type=v2_soap last;
    rewrite        ^/api/soap    /api.php?type=soap    last;
    include        fastcgi_params;
    fastcgi_pass   unix:/var/run/php5-fpm.sock;
    fastcgi_param  SCRIPT_FILENAME  $document_root/api.php;
  }

  location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
    expires       max;
    log_not_found off;
    access_log    off;
  }

  location ~ \.php$ {
    try_files               $uri=404;
    include                 fastcgi_params;
    fastcgi_split_path_info ^(.+\.php)(/.+)$;
    fastcgi_index           index.php;
    fastcgi_param           SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_param           PATH_INFO $fastcgi_path_info;
    fastcgi_param           MAGE_IS_DEVELOPER_MODE 'on';
    fastcgi_param           MAGE_RUN_CODE '';
    fastcgi_param           MAGE_RUN_TYPE 'website';
    access_log              /var/log/nginx/magento-access-ssl.log main;
    error_log               /var/log/nginx/magento-error-ssl.log;
    fastcgi_pass            php:9000;
    # fastcgi_pass          unix:/var/run/php5-fpm.sock;
    # fastcgi_pass          unix:/var/run/hhvm/hhvm.sock;
  }
}

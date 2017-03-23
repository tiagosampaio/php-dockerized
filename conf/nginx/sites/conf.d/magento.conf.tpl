#######################################################################################################################
# Unsecure Protocol Configuraiton (HTTP)
#######################################################################################################################
server {
  server_name dev.magento.com;
  root /var/www/html/magento;

  location / {
    try_files $uri $uri/ /index.php$is_args$args;
  }

  include /etc/nginx/includes/general.conf;
  include /etc/nginx/includes/statics.conf;

  location /api {
    include /etc/nginx/includes/api.conf;
    fastcgi_pass php56:9000;
  }

  location ~ \.php$ {
    include /etc/nginx/includes/php.conf;
    fastcgi_pass php56:9000;

    fastcgi_param MAGE_IS_DEVELOPER_MODE on;
    # fastcgi_param MAGE_RUN_CODE 'default';
    # fastcgi_param MAGE_RUN_TYPE 'website';

    access_log /var/log/nginx/magento-access.log main;
    error_log /var/log/nginx/magento-error.log;
  }
}

#######################################################################################################################
# Secure Protocol Configuraiton (HTTPS)
#######################################################################################################################
server {
  server_name dev.magento.com;
  root /var/www/html/magento;

  listen 443 ssl;
  ssl on;
  ssl_certificate_key /etc/ssl/local/general/certificate.key;
  ssl_certificate     /etc/ssl/local/general/certificate.crt;
  ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
  ssl_ciphers         HIGH:!aNULL:!MD5;

  include /etc/nginx/includes/general.conf;
  include /etc/nginx/includes/statics.conf;

  location /api {
    include /etc/nginx/includes/api.conf;
    fastcgi_pass php56:9000;
  }

  location / {
    try_files $uri $uri/ /index.php$is_args$args;
  }

  location ~ \.php$ {
    include /etc/nginx/includes/php.conf;
    fastcgi_pass php56:9000;

    fastcgi_param MAGE_IS_DEVELOPER_MODE on;
    # fastcgi_param MAGE_RUN_CODE 'default';
    # fastcgi_param MAGE_RUN_TYPE 'website';

    access_log /var/log/nginx/ssl-magento-access.log main;
    error_log /var/log/nginx/ssl-magento-error.log;
  }
}

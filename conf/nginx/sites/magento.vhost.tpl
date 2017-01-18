##   Add www
server {
    listen 80;
    server_name magento.dev;
    return 301 $scheme://www.magento.dev$request_uri;
}

server {   
    listen 80;
    #listen 443 http2 ssl reuseport;
    server_name www.magento.dev;
    root /var/www/magento;
    error_log	/var/log/nginx/error_www.magento.dev.log  error;
    index index.php;
    ## SSL CONFIGURATION
       #ssl_certificate     /etc/ssl/certs/server.crt; 
       #ssl_certificate_key /etc/ssl/certs/server.key;
    
    location = /js/index.php/x.js {
       rewrite ^(.*\.php)/ $1 last;
       }

    ## Main Magento @location
    location / {
       try_files $uri $uri/ @rewrite;
       }

        
    ## These locations are protected
    location ~ /(app|var|downloader|includes|pkginfo)/ {
       deny all;
       }
    ## Images
    location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
       expires max;
       log_not_found off;
       access_log off;
       add_header ETag "";
       }
       
    ## Fonts
	location ~* \.(swf|eot|ttf|otf|woff|woff2)$ {
	expires max;
	log_not_found off;
        access_log off;
	add_header ETag "";
	add_header Access-Control-Allow-Origin "www.magento.dev, cdn.magento.dev";
	add_header Cache-Control "public";
	}
    ## Never Log js/css
	location ~* \.(js|css)$ {
        expires 0;
        log_not_found off;
        access_log off;
        add_header ETag "";
        }

    location @rewrite {
       rewrite / /index.php;
       }
  
    ## Execute PHP scripts
    location ~ \.php$ {
       try_files $uri =404;
       add_header X-Config-By 'Magehost -= www.magehost.com.br =-' always;
       add_header X-Processing-Time $request_time always;
       add_header X-Request-ID $request_id always;
       add_header X-UA-Compatible 'IE=Edge,chrome=1';
       add_header Link "<$scheme://$http_host$request_uri>; rel=\"canonical\"" always;
       fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
       fastcgi_pass  unix:/var/run/php5-fpm.sock;
       fastcgi_index index.php;
       include                 fastcgi_params;
       fastcgi_read_timeout 300;
       fastcgi_param MAGE_IS_DEVELOPER_MODE true;
       fastcgi_keep_conn       on;
       ## Store code with multi domain
       #fastcgi_param MAGE_RUN_CODE $mage_code;
       #fastcgi_param MAGE_RUN_TYPE $mage_type;
       }
    }

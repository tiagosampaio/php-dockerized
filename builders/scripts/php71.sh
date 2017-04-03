#!/bin/sh

########################################################################################################################
## Install new packages and php extensions which are not present in the container.
########################################################################################################################
#apt-get install -my \
#  php5-common \
#  php5-xdebug \
#  php5-oauth \
#  php5-memcached \
#  php-apc
#  php5-curl \
#  php5-gd \
#  php5-mysql \
#  php5-mcrypt \
#  php5-intl \
#  php5-xsl \
#  php-apc \

########################################################################################################################
## Compile the PHP extensions already included in the PHP's official docker container.
########################################################################################################################
docker-php-ext-configure gd --with-jpeg-dir=/usr/include/

docker-php-ext-install \
  bcmath \
  curl \
  mbstring \
  gd \
  mcrypt \
  intl \
  xsl \
  xml \
  zip \
  readline \
  pdo_mysql \
  pdo \
  opcache \
  json \
  session \
  simplexml

EXTENSION_DIR=$(php-config --extension-dir);

########################################################################################################################
## Install XDebug Manually
########################################################################################################################
wget -P /var/tmp https://xdebug.org/files/xdebug-2.5.1.tgz

cd /var/tmp && tar -xf xdebug-2.5.1.tgz && mv xdebug-2.5.1 xdebug && cd xdebug
phpize && ./configure && make

mv ./modules/xdebug.so $EXTENSION_DIR
cd .. && rm -rf xdebug xdebug-2.5.1.tgz

########################################################################################################################
## Install OAuth Manually
########################################################################################################################

wget -P /var/tmp http://pecl.php.net/get/oauth-2.0.2.tgz

cd /var/tmp && tar -xf oauth-2.0.2.tgz && mv oauth-2.0.2 oauth && cd oauth
phpize && ./configure && make

mv ./modules/oauth.so $EXTENSION_DIR
cd .. && rm -rf oauth oauth-2.0.2.tgz

#INSTALL_DIR=/usr/lib/php5/20131226
#EXTENSION_DIR=$(php-config --extension-dir)

#mv $INSTALL_DIR/xdebug.so    $EXTENSION_DIR
#mv $INSTALL_DIR/oauth.so     $EXTENSION_DIR
#mv $INSTALL_DIR/memcached.so $EXTENSION_DIR
#mv $INSTALL_DIR/apcu.so      $EXTENSION_DIR
#!/usr/bin/env bash

### Install Composer
#command -v composer >/dev/null 2>&1 || { echo >&2 "I require composer but it's not installed. Aborting."; exit 1; }

wget https://getcomposer.org/composer.phar
chmod +x composer.phar
mv composer.phar /usr/local/bin/composer

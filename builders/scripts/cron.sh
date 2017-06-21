#!/bin/sh

### Install Cron Service
apt-get install -my \
  cron

### Run Cron Service
/etc/init.d/cron start

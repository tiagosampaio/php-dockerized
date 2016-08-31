#!/bin/bash

sed -i "s/^mailhub=.*/mailhub=${SMTP_HOST}/" /etc/ssmtp/ssmtp.conf
sed -i "s/^rewriteDomain=.*/rewriteDomain=${SMTP_DOMAIN}/" /etc/ssmtp/ssmtp.conf
sed -i "s/^hostname=.*/hostname=${SMTP_DOMAIN}/" /etc/ssmtp/ssmtp.conf
sed -i "s/^UseTLS=.*/UseTLS=${SMTP_TLS}/" /etc/ssmtp/ssmtp.conf
sed -i "s/^UseSTARTTLS=.*/UseSTARTTLS=${SMTP_STARTTLS}/" /etc/ssmtp/ssmtp.conf
sed -i "s/^AuthUser=.*/AuthUser=${SMTP_USERNAME}/" /etc/ssmtp/ssmtp.conf
sed -i "s/^AuthPass=.*/AuthPass=${SMTP_PASSWORD}/" /etc/ssmtp/ssmtp.conf

exit 0

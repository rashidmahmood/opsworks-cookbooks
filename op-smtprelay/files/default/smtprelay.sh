#!/bin/bash

#Install postfix and set it at startup
YUM=$(which yum)
ALT=$(which alternatives)
CHKCONFIG=$(which chkconfig)
POSTMAP=$(which postmap)
NEWALIASES=$(which newaliases)
$YUM -y install postfix
$YUM -y install mailx
$ALT --config mta <<< '2'
$CHKCONFIG sendmail off
$CHKCONFIG postfix on
/etc/init.d/sendmail stop

#Add SMTP configs to main.conf
cat /etc/postfix/main.cf | grep email-smtp.us-east-1.amazonaws.com
if [[ $? -eq 0 ]]
then
	echo "Configs already added"
else
	echo "Adding SES SMTP Configs"
	cat main >> /etc/postfix/main.cf
fi
echo "[email-smtp.us-east-1.amazonaws.com]:25 AKIAIZ6TDQERBLSRIFDA:AqxwFlmZNDetm5HFAZylEUGDUHAR3o+qS+LdyBovmn9i" > /etc/postfix/sasl_passwd

sudo /usr/sbin/postmap hash:/etc/postfix/sasl_passwd
sudo chown root:root /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
sudo chmod 0600 /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
sudo postconf -e 'smtp_tls_CAfile = /etc/ssl/certs/ca-bundle.crt'

#/etc/init.d/postfix restart

HOSTNAME=$(hostname)
cat /etc/postfix/generic | grep $HOSTNAME
if [[ $? -eq 0 ]]
then
	echo "Already added mail from entry"
else
	echo "Adding mail from entry"
	echo "root@$HOSTNAME.localdomain $HOSTNAME@hipcricket.net" >> /etc/postfix/generic
	/usr/sbin/postmap /etc/postfix/generic
fi

cat /etc/aliases | grep hc-sysadmin@hipcricket.com
if [[ $? -eq 0 ]]
then
	echo "ROOT forwarder already added"
else
	echo "Adding Root forwarder"
	echo "root: hc-sysadmin@hipcricket.com" >> /etc/aliases
	Update_Aliases=$(/usr/bin/newaliases)
fi

/etc/init.d/postfix restart

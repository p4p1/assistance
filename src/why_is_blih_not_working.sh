#!/bin/bash
# why_is_blih_not_working.sh
# Created on: jeu. 28 mai 2020 03:40:52  CEST
#
#  ____   __  ____  __
# (  _ \ /. |(  _ \/  )
#  )___/(_  _))___/ )(
# (__)    (_)(__)  (__)
#
# Description:
#  Script to install blih

source /opt/problem/data/vars.sh

ret="Bad token"
blih_url="https://raw.githubusercontent.com/Epitech/dump/master/blih.py"

# Installing blih
if ! hash blih &> /dev/null; then
	curl $blih_url --output /tmp/blih
	chmod +x /tmp/blih
	sudo mv /tmp/blih ${PATH[0]%%:*}/blih
fi
if [ ! -d $HOME/.ssh ]; then
	echo -n "Press [Enter] 3 times to set the path to default and password to"
	echo " (null)"
	sshkey-gen
fi
echo -n "Please enter your @epitech.eu email: "
read email
echo -n "You are uploading your ssh public file to the server, press <C-c> "
echo "to exit"
while [[ ! -z "$ret" ]]; do
	ret=$(blih -u $email sshkey upload ~/.ssh/id_rsa.pub)
	echo $ret
	ret=$(echo $ret | grep "Bad token")
done
ssh git@git.epitech.eu


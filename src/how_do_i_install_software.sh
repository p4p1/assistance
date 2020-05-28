#!/bin/bash
# how_do_i_install_software.sh
# Created on: jeu. 28 mai 2020 03:42:10  CEST
#
#  ____   __  ____  __
# (  _ \ /. |(  _ \/  )
#  )___/(_  _))___/ )(
# (__)    (_)(__)  (__)
#
# Description:
#  script to install software

source /opt/problem/data/vars.sh

devgo_pack=($(cat $DATA_DIR/packages.txt | tr "\n" " "))

# Installing software
echo -e "\e[96;5;4mInstalling packages ...\e[m"
for item in ${devgo_pack[@]}; do
	echo -n "Checking $item -> "
	if hash $item &> /dev/null; then
		echo -e "\e[1;34m:)\e[m"
	else
		echo -e "\e[1;31m:(\e[m"
		sudo apt install -y $item
	fi
done
echo
source $SCRIPT_DIR/why_is_blih_not_working.sh

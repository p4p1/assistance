#!/bin/bash
# problem.sh
# Created on: Wed 27 May 2020 07:08:31 PM CEST
# Creator: Leo Smith (aka p4p1)
# Creator website: https://p4p1.github.io/
#  ____   __  ____  __
# (  _ \ /. |(  _ \/  )
#  )___/(_  _))___/ )(
# (__)    (_)(__)  (__)
#
# Description:
#  simple script to get help <3
#
# Install:
#  ./problem.sh -i
#
# Dependencies:
#  sudo apt install dialog tree ssh git curl
#
# Usage:
#  Students:
#    ./assistance.sh
#    ./assistance.sh -b    # Show a banner
#    ./assistance.sh -i    # Install this software
#  Teachers:
#   To add new questions just follow those simple instructions, 1: add a
#   question to the question variable. 2: create the function. 3: add an entry
#   to the switch case at the bottom of the script

# Ignore this line
DIALOG_RC="use_shadow = ON\nuse_colors = ON\nscreen_color = (RED,BLACK,ON)\nshadow_color = (BLACK,BLACK,ON)\ndialog_color = (BLACK,WHITE,OFF)\ntitle_color = (RED,WHITE,ON)\nborder_color = (WHITE,WHITE,ON)\nbutton_active_color = (RED,BLACK,ON)\nbutton_inactive_color = dialog_color\nbutton_key_active_color = button_active_color\nbutton_key_inactive_color = (BLACK,WHITE,OFF)\nbutton_label_active_color = (RED, BLACK, ON)\nbutton_label_inactive_color = (BLACK,WHITE,ON)\ninputbox_color = dialog_color\ninputbox_border_color = dialog_color\nsearchbox_color = dialog_color\nsearchbox_title_color = title_color\nsearchbox_border_color = border_color\nposition_indicator_color = title_color\nmenubox_color = dialog_color\nmenubox_border_color = border_color\nitem_color = dialog_color\nitem_selected_color = button_active_color\ntag_color = title_color\ntag_selected_color = button_label_active_color\ntag_key_color = button_key_inactive_color\ntag_key_selected_color = (RED,BLACK,ON)\ncheck_color = dialog_color\ncheck_selected_color = button_active_color\nuarrow_color = (GREEN,WHITE,ON)\ndarrow_color = uarrow_color\nitemhelp_color = (WHITE,BLACK,OFF)\nform_active_text_color = button_active_color\nform_text_color = (WHITE,CYAN,ON)\nform_item_readonly_color = (CYAN,WHITE,ON)\ngauge_color = title_color\nborder2_color = dialog_color\ninputbox_border2_color = dialog_color\nsearchbox_border2_color = dialog_color\nmenubox_border2_color = dialog_color\n"
# Important variables
WIDTH=80
HEIGHT=30
INSTALL_DIR=/opt/assistance
dependencies=(dialog tree ssh git curl)
question=("1" "What is this?")
scripts=($(ls $INSTALL_DIR/src/ 2> /dev/null))


function usage() {
	echo -e "Description:"
	echo -e "\tNew to linux? no worries, this tool helps you correct a few bugs"
	echo -e "\there and there to help you have a stable working environement."
	echo -e "\tFor more information open up the file and read the source code."
	echo -e "Usage:"
	echo -e "\t$0\t"
	echo -e "\t$0 -b\t\t# Show a banner"
	echo -e "\t$0 -i\t\t# Install this software"
	echo -e "Made by p4p1"
}


# function for the banner can be shown with -b
function banner() {
	banner=($(ls $INSTALL_DIR/banner))
	rand=$(( $RANDOM % ${#banner[*]} ))
	source $INSTALL_DIR/banner/${banner[$rand]}
	echo "Press [Enter] to continue:"
	read tmp
}

# function to install software list
function installer() {
	echo -e "\e[96;5;4mInstalling packages ...\e[m"
	sudo apt update
	for item in $@; do
		echo -n "Checking $item -> "
		if hash $item &> /dev/null; then
			echo -e "\e[1;34m:)\e[m"
		else
			echo -e "\e[1;31m:(\e[m"
			sudo apt install -y $item
		fi
	done
	echo
}

echo -e $DIALOG_RC > $HOME/.dialogrc

# Command parser
while getopts "bi" o; do
	case "${o}" in
		b)
			banner
			;;
		i)
			installer ${dependencies[*]}
			sudo mkdir -p $INSTALL_DIR
			sudo cp -r $0 ${PATH[0]%%:*}/$0
			echo -e "Copied \e[1;31m$0\e[m to: \e[1;34m${PATH[0]%%:*}/$0\e[m"
			sudo cp -r ./banner $INSTALL_DIR
			sudo cp -r ./data $INSTALL_DIR
			sudo cp -r ./src $INSTALL_DIR
			exit
			;;
		*)
			usage
			exit 84
			;;
	esac
done
shift $((OPTIND-1))

# Initial setup
echo -en "\e[96;5;4mChecking dependencies \e[m"
for item in ${dependencies[*]}; do
	if hash $item; then
		echo -n "."
	else
		installer ${dependencies[*]}
	fi
done
echo # echo for a new line

# Generate question list
let i=2
for item in ${scripts[*]}; do
	tmp=$(echo $item | tr "_" " ")

	question+=($i)
	question+=("${tmp/.sh/?}")
	let i=( $i + 1 )
done

# Main while loop
while true; do
	exec 3>&1
	selection=$(dialog --backtitle "$0" \
		--clear \
		--title "What is your problem?" \
		--cancel-label "Exit" \
		--menu "Please select:" \
		$HEIGHT $WIDTH 20 \
		"${question[@]}" \
		2>&1 1>&3)
	exit_state=$?
	exec 3>&-
	[ $exit_state -ne "0" ] && break
	case $selection in
		0 )
			clear
			break
			;;
		1)
			clear
			usage
			echo "Press [Enter] to continue:"
			read tmp
			;;
		*)
			clear
			let index=($selection - 2)
			source $INSTALL_DIR/src/${scripts[$index]}
			echo "All done, press [Enter]"
			read tmp
			;;
	esac
done

clear
echo "All done :)"

exit

#!/bin/bash
# This script creates a new Launchfile for usage with the Lnch utility
# Copyright (C) 2020 TFKls
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
# TO DO : COMPLETION
if ! test -f "$HOME/.lnch.cfg" ; then
	echo "No config file found."
	exit 1
fi
flag=0
source "$HOME/.lnch.cfg"
while getopts ":r:n:c" opt; do
	case $opt in
	r)
		if ! test -f "$lnchSPath/${OPTARG,,}/Launchfile"; then
			echo "Launchfile does not exist."
			exit 1
		fi
		if ! test -e "$lnchSPath/backups/"; then
			mkdir "$lnchSPath/backups"
		fi
		mv "$lnchSPath/${OPTARG,,}/Launchfile" "$lnchSPath/backups/${OPTARG,,}.lnchbk"
		rm -r "$lnchSPath/${OPTARG,,}"
		#sed -i.bak "/${OPTARG,,}/d" lnch_complete.cfg
		#rm lnch_complete.cfg.bak
		echo "The shortcut should be deleted and a backup created"
		exit 0
		;;
	n)
		newLnchName="${OPTARG,,}"
		if test -f "$lnchSPath/$newLnchName/Launchfile"; then
			echo "Launchfile already exists, aborting"
			exit 1
		fi
		flag=1
		;;
	c) 
		sed -i.bak "/savedCreateOption/d" lnch.cfg
		rm lnch.cfg.bak
		echo "savedCreateOption=0" >> lnch.cfg
		echo "Config cleared"
		exit 0
		;;
	esac
done
if ((flag == 0)); then
	echo "LaunchFile Creator - version 1.0"
	echo "Copyright (C) TFKls 2020"
	echo "You can use -n \"name\" or -r \"name\" to create and delete shortcuts"
#	echo "use -c to clear config of the saved create option"
	echo ""
	echo "Enter the name of your shortcut. (Note: Case insensitive) " 
	read newLnchName
	newLnchName="${newLnchName,,}"
	if test -f "$lnchSPath/$newLnchName/Launchfile"; then
		echo "Launchfile already exists, aborting"
		exit 1
	fi
fi
mkdir "$lnchSPath/$newLnchName"
echo "#!/bin/bash" >> "$lnchSPath/$newLnchName/Launchfile"
chmod +x "$lnchSPath/$newLnchName/Launchfile"
echo "File created successfully"
# if ((savedCreateOption == 0)) ; then
	echo "How do you want to configure the shortcut?"
	echo ""
	echo "1) Use nano to write your shell script (if you know bash)"
	echo "2) Use vim to write your shell script"
	echo "3) I'll set it up later myself"
	echo "4) Use the simple programs creation wizard included in this script (UNIMPLEMENTED)"
	read createOption
	# echo "Do you want to save that option? [y/N]"
	# read saveCreateOptionLocal
	# if (( saveCreateOptionLocal == "y" )); then
	#	echo "savedCreateOption=$createOption" >> lnch.cfg
	# fi
	# if (( saveCreateOptionLocal == "Y" )); then
	#	echo "savedCreateOption=$createOption" >> lnch.cfg
	# fi
	# unimplemented!
# else
# createOption="$savedCreateOption"
# fi
case $createOption in
#4)
#	echo "What exactly do you want to do : "
#	echo "1) Launch something like an electron app without a terminal"
#	echo "2) Launch an app not on path"
#	echo "More creation options may come soon."
#	read s_option
#	case $s_option in
#	1)  echo "Which approach do you prefer to use : "
#		echo "1) Use nohup and redirect to /dev/null"
#		echo "2) Use nohup but don't redirect and save to $lnchSPath/$newLnchName/nohup.out"
#		read nh_option
#		echo "Select the niceness you want your program to run at (between 19 to -20, write anything else to not change the value)"
#		read ni_option
#		regCheck='^[0-9]+$'
#		if ! [[ $ni_option =~ $regCheck ]]; then ni_option=-420; fi
#		if ((ni_option < -20 || ni_option > 19)) ;then ni_option=-420;fi
#		echo "Please enter the name of program (assuming it's on PATH, otherwise input full path)"
#		read p_option
#		case $nh_option in 
#		1)
#			if ((ni_option == -420)); then
#				echo "nohup $p_option >/dev/null 2>&1" >> "$lnchSPath/$newLnchName/Launchfile"
#			else
#				echo "nohup nice -n $ni_option $p_option >/dev/null 2>&1" >> "$lnchSPath/$newLnchName/Launchfile"
#			fi
#			;;
#		2)
#			if ((ni_option == -420)); then
#				echo "nohup $p_option &" >> "$lnchSPath/$newLnchName/Launchfile"
#			else
#				echo "nohup nice -n $ni_option $p_option &" >> "$lnchSPath/$newLnchName/Launchfile"
#			fi 
#			;;
#		*)	echo "No such option. Deleting the file and aborting"
#			rm $lnchSPath/$newLnchName/Launchfile
#			rmdir $lnchSPath/$newLnchName
#			exit 2
#			;;
#		esac
#		exit 0
#		;;
#	2)  echo "Please enter the full path to the program"
#		read p_option
#		echo "Select the niceness you want your program to run at (between 19 to -20, write anything else to not change the value)"
#		read ni_option
#		regCheck='^[0-9]+$'
#		if ! [[ $ni_option =~ $regCheck ]]; then ni_option=-420; fi
#		if ((ni_option < -20 || ni_option > 19)) ;then ni_option=-420;fi
#		if ((ni_option == -420)); then
#			"$p_option" >> "$lnchSPath/$newLnchName/Launchfile"
#		else
#			"nice -n $ni_option $p_option" >> "$lnchSPath/$newLnchName/Launchfile"
#		fi
#		exit 0
#		;;
#	*)  echo "No such option. Deleting the file and aborting"
#		rm $lnchSPath/$newLnchName/Launchfile
#		rmdir $lnchSPath/$newLnchName
#		exit 2
#		;;
#	esac
#	;;
# unimplemented!
1)
	nano "$lnchSPath/$newLnchName/Launchfile"
	;;
2)
	vim "$lnchSPath/$newLnchName/Launchfile"
	;;
3)
	exit 0
	;;
*)
	echo "No such option. Deleting the file and aborting"
	rm $lnchSPath/$newLnchName/Launchfile
	rmdir $lnchSPath/$newLnchName
	exit 2
	;;
esac
exit 0
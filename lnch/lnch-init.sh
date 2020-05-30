#!/bin/bash
# This is a short program for adding all the dependencies and creating the 
# standard config for the lnch utility 
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
case $1 in
[iI][nN][sS][tT][aA][lL][lL]|[iI])
	if test -f "$HOME/.lnch/cfg"; then
		echo "Error - already initiated."
		echo "Launch with \"uninstall\" to uninstall"
		exit 2
	fi
	echo "This will install the script by adding an alias in ~/.bash_aliases"
	echo "Write \"proceed\" to proceed with the installation"
	read installOption
	currentDir=`pwd`
	case $installOption in
	[pP][rR][oO][cC][eE][eE][dD])
		echo "alias lnch=$HOME/.lnch/lnch.sh" >> ~/.bash_aliases
		echo "alias lnch-create=$HOME/.lnch/lnch-create.sh" >> ~/.bash_aliases
		echo -e "source \"$HOME/.lnch/completion-scripts\"" >> ~/.bash_aliases
		mkdir "$HOME/.lnch"
		cp "$currentDir/lnch.sh" "$HOME/.lnch/lnch.sh"
		cp "$currentDir/lnch-create.sh" "$HOME/.lnch/lnch-create.sh"
		cp "$currentDir/completion-scripts" "$HOME/.lnch/completion-scripts"
		touch "$HOME/.lnch/cfg"
		echo "savedCreateOption=nano" >> "$HOME/.lnch/cfg"
		if ! test -e "$HOME/.lnch/lnchfiles"; then
			mkdir "$HOME/.lnch/lnchfiles"
		fi
		if ! test -e "$HOME/.lnch/lnchfiles/help/Launchfile"; then
			mkdir "$HOME/.lnch/lnchfiles/help"
			cp "$currentDir/helpLnch" "$HOME/.lnch/lnchfiles/help/Launchfile"
			chmod +x "$HOME/.lnch/lnchfiles/help/Launchfile"
		fi
		chmod +x "$HOME/.lnch/lnch.sh"
		chmod +x "$HOME/.lnch/lnch-create.sh"
		chmod +x "$HOME/.lnch/completion-scripts"
		touch "$HOME/.lnch/complete"
		echo "help" >> "$HOME/.lnch/complete"
		echo "Installation should be completed successsully. Please restart your shell."
		exit 0
	;;
	*)
		echo "Wrong confirmation, aborting program"
		exit 3
	;;
	esac
	;;
[uU][nN][iI][nN][sS][tT][aA][lL][lL]|[uU])
	if ! test -f "$HOME/.lnch/cfg"; then
		echo "Error - No config found."
		echo "Launch with \"install\" to install"
		exit 2
	fi
	echo "This will uninstall the script."
	echo "It will also remove ALL THE LAUNCHFILES"
	echo "PLEASE BACK THEM UP IF YOU WANT TO KEEP THEM"
	echo "Write \"proceed\" to proceed"
	read installOption
	currentDir=`pwd`
	case $installOption in
	[pP][rR][oO][cC][eE][eE][dD])
		sed -i.bak '/lnch/d' ~/.bash_aliases
		rm -r "$HOME/.lnch"
		echo "Uninstallation should be completed successsully."
		exit 0
	;;
	*)
		echo "Wrong confirmation, aborting program"
		exit 3
	;;
	esac
	;;
*)
	echo "No argument given"
	echo "Launch with \"install\" to install or"
	echo "with \"uninstall\" to uninstall"
esac
exit 0
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
	if test -f "lnch.cfg"; then
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
		echo "alias lnch=$currentDir/lnch.sh" >> ~/.bash_aliases
		echo "alias lnch-create=$currentDir/lnch-create.sh" >> ~/.bash_aliases
		touch lnch.cfg
		echo "lnchSPath=$currentDir/lnchfiles" >> lnch.cfg
		echo "savedCreateOption=0" >> lnch.cfg
		mkdir "$currentDir/lnchfiles"
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
	echo "This will uninstall the script."
	echo "Write \"proceed\" to proceed"
	read installOption
	currentDir=`pwd`
	case $installOption in
	[pP][rR][oO][cC][eE][eE][dD])
		sed -i.bak '/lnch/d' ~/.bash_aliases
		rm lnch.cfg
		deleteAllLnch =
		echo "Do you want to completely remove all the shortcuts? (UNREVERSIBLE) [write \"yes-absolutely\" if you want to do it]"
		read deleteAllLnch
		if ((deleteAllLnch == "yes-absolutely")); then
			rm -r "$currentDir/lnchfiles"
		fi
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
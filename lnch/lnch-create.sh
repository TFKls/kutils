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
if ! test -f "$HOME/.lnch/cfg" ; then
	echo "No config file found."
	exit 1
fi
flag=0

source "$HOME/.lnch/cfg"
while getopts ":r:n:c:e:" opt; do
	case $opt in
	r)
		if ! test -f "$HOME/.lnch/lnchfiles/${OPTARG,,}/Launchfile"; then
			echo "Launchfile does not exist."
			exit 1
		fi
		if ! test -e "$HOME/.lnch/lnchfiles/backups/"; then
			mkdir "$HOME/.lnch/lnchfiles/backups"
		fi
		mv "$HOME/.lnch/lnchfiles/${OPTARG,,}/Launchfile" "$HOME/.lnch/lnchfiles/backups/${OPTARG,,}.lnchbk"
		rm -r "$HOME/.lnch/lnchfiles/${OPTARG,,}"
		sed -i.bak "/${OPTARG,,}/d" "$HOME/.lnch/complete"
		rm "$HOME/.lnch/complete.bak"
		echo "The shortcut should be deleted and a backup created"
		exit 0
		;;
	n)
		newLnchName="${OPTARG,,}"
		if test -f "$HOME/.lnch/lnchfiles/$newLnchName/Launchfile"; then
			echo "Launchfile already exists, aborting"
			exit 1
		fi
		mkdir "$HOME/.lnch/lnchfiles/$newLnchName"
		echo "#!/bin/bash" >> "$HOME/.lnch/lnchfiles/$newLnchName/Launchfile"
		chmod +x "$HOME/.lnch/lnchfiles/$newLnchName/Launchfile"
		echo $newLnchName >> "$HOME/.lnch/complete"
		exec $savedCreateOption "$HOME/.lnch/lnchfiles/$newLnchName/Launchfile"
		;;
	c) 
		sed -i.bak "/savedCreateOption/d" "$HOME/.lnch/cfg"
		rm "$HOME/.lnch/cfg.bak"
		echo "savedCreateOption=$OPTARG" >> "$HOME/.lnch/cfg"
		exit 0
		;;
	e) 
		if ! [[ -f "$HOME/.lnch/lnchfiles/${OPTARG,,}/Launchfile" ]] ; then
			echo "Launchfile does not exist."
			exit 1
		fi
		echo $savedCreateOption
		exec $savedCreateOption ${OPTARG,,}
		;;
	esac
done
echo "Wrong argument"
echo "USAGE : "
echo "	lnch-create -n name  -> new shortcut named \"name\""
echo "	lnch-create -e name  -> edit shortcut named \"name\""
echo "	lnch-create -r name  -> remove shortcut named \"name\""
echo "	lnch-create -c name  -> change default editor used for editing shortcuts"
exit 0
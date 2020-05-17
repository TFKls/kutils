#!/bin/bash
# Lnch - a shell program to source other shell programs and create shortcuts
# for other programs not on path.
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
if ! test -f "lnch.cfg" ; then
    echo "No config file found."
    exit 1
fi
source lnch.cfg
if ! test -f "$lnchSPath/${1,,}/Launchfile" ; then
    echo "No such program."
    exit 1
fi
source "$lnchSPath/${1,,}/Launchfile"
# Yes, the code it that simple (exec), it also gives you the possibility for 
# manually creating advanced programs with the power of bash :D
#
# Also I used directories and Launchfiles instead of sth like a main directory 
# with name.lnch files, because some programs may be more advanced and want
# to utilize/manipulate some other files. 
# Because of that I wanted a more segregated enviroment for them to exist in 
# (even though at the end of the day it does not matter and .lnch may have 
# been clearer).
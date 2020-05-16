installPath="" # Here is where you need to enter install path should you use this version 
# source "${installPath}launch.conf" unimplemented feature for config files
noFlag=1
while getopts ":ht" opt; do
  case ${opt} in
    h )
	echo -e "Launch Utlity - by TFKls <dev@tkulis.com>"
	echo -e ""
	echo -e "Launches a shortcut."
	echo -e "Arguments : "; echo -e "launch <program> - launches a program"; echo -e "NOTE : The program to launch must have a shortcut in the launchpath."
	echo -e "launch -h - displays the current menu"
    echo -e "\n\a Note : this version is outdated and unmaintained"
	noFlag=0
      ;;
    \?)

      ;;
  esac
done
# This is bs code - ;p
# Will need to do a full refactor

if ((noFlag == 1))
	then
	    pwd=`pwd`
        echo "Recieved argument : $1"
        cd "${installPath}shortcuts/$1/"
        source "Launchfile"
        cd "$pwd"
fi
# Usage : create a Launchfile in directory $installPath/shortcuts/$name/Launchfile
# There you can create a bash file to source
# I would suggest using the version1 since this is some pure proof of concept (also garbage ;p ) code right here
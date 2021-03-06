#!/bin/bash
# Reset
Color_Off='\033[0m' # Text Reset

# Regular Colors
Black='\033[0;30m'  # Black
Red='\033[0;31m'    # Red
Green='\033[0;32m'  # Green
Yellow='\033[0;33m' # Yellow
Blue='\033[0;34m'   # Blue
Purple='\033[0;35m' # Purple
Cyan='\033[0;36m'   # Cyan
White='\033[0;37m'  # White

# Bold
BBlack='\033[1;30m'  # Black
BRed='\033[1;31m'    # Red
BGreen='\033[1;32m'  # Green
BYellow='\033[1;33m' # Yellow
BBlue='\033[1;34m'   # Blue
BPurple='\033[1;35m' # Purple
BCyan='\033[1;36m'   # Cyan
BWhite='\033[1;37m'  # White

# Underline
UBlack='\033[4;30m'  # Black
URed='\033[4;31m'    # Red
UGreen='\033[4;32m'  # Green
UYellow='\033[4;33m' # Yellow
UBlue='\033[4;34m'   # Blue
UPurple='\033[4;35m' # Purple
UCyan='\033[4;36m'   # Cyan
UWhite='\033[4;37m'  # White

# Background
On_Black='\033[40m'  # Black
On_Red='\033[41m'    # Red
On_Green='\033[42m'  # Green
On_Yellow='\033[43m' # Yellow
On_Blue='\033[44m'   # Blue
On_Purple='\033[45m' # Purple
On_Cyan='\033[46m'   # Cyan
On_White='\033[47m'  # White

# High Intensity
IBlack='\033[0;90m'  # Black
IRed='\033[0;91m'    # Red
IGreen='\033[0;92m'  # Green
IYellow='\033[0;93m' # Yellow
IBlue='\033[0;94m'   # Blue
IPurple='\033[0;95m' # Purple
ICyan='\033[0;96m'   # Cyan
IWhite='\033[0;97m'  # White

# Bold High Intensity
BIBlack='\033[1;90m'  # Black
BIRed='\033[1;91m'    # Red
BIGreen='\033[1;92m'  # Green
BIYellow='\033[1;93m' # Yellow
BIBlue='\033[1;94m'   # Blue
BIPurple='\033[1;95m' # Purple
BICyan='\033[1;96m'   # Cyan
BIWhite='\033[1;97m'  # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'  # Black
On_IRed='\033[0;101m'    # Red
On_IGreen='\033[0;102m'  # Green
On_IYellow='\033[0;103m' # Yellow
On_IBlue='\033[0;104m'   # Blue
On_IPurple='\033[0;105m' # Purple
On_ICyan='\033[0;106m'   # Cyan
On_IWhite='\033[0;107m'  # White

#Templates
Choise="${White}(${BGreen} y${White} / ${BRed}n ${White})${White}"
Line="${IPurple} ================================================================\n"
Logo="${On_IBlack}${BIRed}S${UBlue}${BBlue}ystem ${On_IBlack}${BIRed}U${UBlue}${BBlue}pdater${Color_Off}"

cd "$(dirname "$(readlink -fm "$0")")"

pword="./.password.shadow"
root="/bin/a"
printf "\n"

if ! [ -f "$pword" ]; then
    printf "${BRed}It seems like you don't have sudo password saved.\n"
    printf "${BPurple}Enter it now to save it !\n"
    printf "${BCyan}To modify it later change it in ${UCyan}$pword${BCyan} file.${White}\n"
    read pass
    printf $pass | sudo -S touch "$root"
    while ! [ -f "/bin/a" ]; do
        read -s pass
        echo "$pass" | sudo -S -k touch "$root"
        printf "${BRed}Oops Wrong Password\n"
        printf "${BPurple}Please try again${White}\n"
    done
    sudo rm "$root"
    echo "$pass" >"$pword"
    echo "$pass" | sudo -S -i
    clear
    printf "\n"
fi

ver=$(curl $version)
clear
if [[ $(cat './.version') != $ver ]]; then
    printf "${BGreen}A new version of RunneR is avalable\n"
    printf "${BYellow}Do you want to upgrade ? ${Choise}\n"
    getChoise
    if [ $choise == true ]; then
        printf "${BPurple}Updating...${White}\n"
        git reset HEAD --hard
        git clean -f
        git pull origin master
        printf "${BPurple}Press enter to continue.${White}\n"
        read -s -n 1 a
    fi
    clear
    printf "\n\n"
fi

cat "$pword" | sudo -S apt-get update
clear
printf "${BGreen} Scources Updated\n"
printf $Line
cat "$pword" | sudo -S apt-get autoremove -y
clear
printf "${BGreen} Scources Updated\n"
printf "${BGreen} Unwanted Packages Removed\n"
printf $Line
cat "$pword" | sudo -S apt full-upgrade -y
clear
printf "${BGreen} Scources Updated\n"
printf "${BGreen} Unwanted Packages Removed\n"
printf "${BGreen} All Packages Updated\n"
printf $Line
cat "$pword" | sudo -S apt -f
clear
printf "${BGreen} Scources Updated\n"
printf "${BGreen} Unwanted Packages Removed\n"
printf "${BGreen} All Packages Updated\n"
printf "${BGreen} Fixed Broken Packages\n"
printf $Line

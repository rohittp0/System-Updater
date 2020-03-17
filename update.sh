BGreen='\033[1;32m'
BIPurple='\033[1;95m'

cd "$(dirname "$(readlink -fm "$0")")"

pword="./.password.shadow"
root="/bin/a"
last="$(cat ./LAST_RUN.date)"
printf "\n\n"

if [ -f "$pword" ]; then
    cat "$pword" | sudo -S -i
else
    printf "${BRed}It seems like you don't have sudo password saved.\n"
    printf "${BPurple}Enter it now to save it !\n"
    printf "${BCyan}To modify it later change it in ${UCyan}$pword${BCyan} file.${White}\n"
    read pass
    printf $pass | sudo -S touch "$root"
    while ! [ -f "/bin/a" ]; do
        read pass
        echo "$pass" | sudo -S touch "$root"
        printf "${BRed}Oops Wrong Password\n"
        printf "${BPurple}Please try again${White}\n"
    done
    sudo rm "$root"
    printf "$pass" >"$pword"
fi

clear

if [[ $(date '+%Y-%m-%d') != $last ]]; then

    git remote update
    HEADHASH=$(git rev-parse HEAD)
    UPSTREAMHASH=$(git rev-parse master@{upstream})

    if [ "$HEADHASH" != "$UPSTREAMHASH" ]; then
        clear
        printf "${BGreen}A new version of RunneR is avalable\n"
        printf "${BYellow}Do you want to upgrade ? ${Choise}\n"
        read -s -n 1 key
        while [[ $key != "n" && $key != "N" ]]; do
            if [[ $key == "y" || $key == "y" ]]; then
                git pull -v origin master
                printf "${BPurple}Press enter to continue.${White}\n"
                read -s -n 1 a
                break
            else
                printf "${BRed}Incorrect Option${White}\n"
                read -s -n 1 key
            fi
        done
    fi
    echo "$(date '+%Y-%m-%d')" >"./LAST_RUN.date"
    clear
    printf "\n\n"
fi

sudo apt-get update
clear
printf "${BGreen} Scources Updated"
printf "${IPurple} ----------------------------------------------------------------"
sudo apt-get autoremove -y
clear
printf "${BGreen} Scources Updated"
printf "${BGreen} Unwanted Packages Removed"
printf "${IPurple} ----------------------------------------------------------------"
sudo apt full-upgrade -y
clear
printf "${BGreen} Scources Updated"
printf "${BGreen} Unwanted Packages Removed"
printf "${BGreen} All Packages Updated"
printf "${IPurple} ----------------------------------------------------------------"
sudo apt -f
clear
printf "${BGreen} Scources Updated"
printf "${BGreen} Unwanted Packages Removed"
printf "${BGreen} All Packages Updated"
printf "${BGreen} Fixed Broken Packages"
printf "${IPurple} ----------------------------------------------------------------"

BGreen='\033[1;32m'
BIPurple='\033[1;95m'

echo "rohit.t.p2002" | sudo -S -i
sudo apt-get update
clear
echo -e "${BGreen} Scources Updated"
echo -e "${IPurple} ----------------------------------------------------------------"
sudo apt-get autoremove -y
clear
echo -e "${BGreen} Scources Updated"
echo -e "${BGreen} Unwanted Packages Removed"
echo -e "${IPurple} ----------------------------------------------------------------"
sudo apt full-upgrade -y
clear
echo -e "${BGreen} Scources Updated"
echo -e "${BGreen} Unwanted Packages Removed"
echo -e "${BGreen} All Packages Updated"
echo -e "${IPurple} ----------------------------------------------------------------"
sudo apt -f
clear
echo -e "${BGreen} Scources Updated"
echo -e "${BGreen} Unwanted Packages Removed"
echo -e "${BGreen} All Packages Updated"
echo -e "${BGreen} Fixed Broken Packages"
echo -e "${IPurple} ----------------------------------------------------------------"

#!/bin/bash
NC='\033[0m'
RED='\033[1;38;5;196m'
GREEN='\033[1;38;5;040m'
ORANGE='\033[1;38;5;202m'
BLUE='\033[1;38;5;012m'
BLUE2='\033[1;38;5;032m'
PINK='\033[1;38;5;013m'
GRAY='\033[1;38;5;004m'
NEW='\033[1;38;5;154m'
YELLOW='\033[1;38;5;214m'
CG='\033[1;38;5;087m'
CP='\033[1;38;5;221m'
CPO='\033[1;38;5;205m'
CN='\033[1;38;5;247m'
CNC='\033[1;38;5;051m'
#Coded By Machine404! Don't copy this code without giving me credit~
#https://instagram.com/invisibleclay100
#https://twitter.com/whoami4041
#https://www.youtube.com/channel/UCC_aPnmV_zGfdwktCFE9cPQ
function banner(){
echo -e ${CP}"     ______ _     ___ ____ _  __         _ _  ____ _  _______ ______       #"
echo -e ${CP}"    / / ___| |   |_ _/ ___| |/ /        | / |/ ___| |/ /___ /|  _ \ \      #"
echo -e ${CP}"   | | |   | |    | | |   | ' /_____ _  | | | |   | ' /  |_ \| |_) | |     #"
echo -e ${CP}"  < <| |___| |___ | | |___| . \_____| |_| | | |___| . \ ___) |  _ < > >    #"
echo -e ${CP}"   | |\____|_____|___\____|_|\_\     \___/|_|\____|_|\_\____/|_| \_\ |     #"
echo -e ${CP}"    \_\                                                           /_/      #"
echo -e ${CNC}"        A Simple Tool To Find ClickJacking Vulnerability With POC          #"
echo -e ${YELLOW}"                         Coded By: Machine404                              #"
echo -e ${CP}"          Follow Me On:  ${CPO}Instagram: invisibleclay100                       #"
echo -e ${CP}"                         ${PINK}Twitter:   whoami4041                             #"
echo -e ${RED}"#############################################################################\n "

}
function single_url(){
clear
banner
echo -e -n ${BLUE}"\n[+] Enter domain name (e.g http|https://target.com/) : "
read  url
check=$(curl -s  $url -I)
echo "$check" >> temp.txt
sami=$(cat temp.txt | egrep -w 'X-Frame-Options|Content-Security-Policy|x-frame-options|content-security-policy:' )


if [[ $sami != '' ]];
then
echo -e -n ${CP}"\n[ X ] $url ${CG}NOT VULNERABLE "

else

echo -e -n "\n[ ✔ ] ${NC}$url ${RED}VULNERABLE \n"
sleep 1
echo -e -n ${BLUE}"\nDo U Want To Open POC In Browser: [y/n]: "
read back_press
if [ $back_press = "y"  ]; then
if [ -f vuln.html ]; then
#echo -e -n ${RED}"[*] Old Vuln.html File Found! Removing Old File! " 
rm vuln.html
fi
if [ -f poc.html ];
then
cat poc.html | sed "s|vuln|$url|" >> vuln.html
open vuln.html


else
 echo -e -n ${RED}"[ X ] POC File Not Found! Exiting"    
 exit
fi
elif [ $back_press = "n" ]; then
echo -e -n ${CP}"[+] POC Saved As Vuln.html"
sleep 1
              exit
     fi

fi
}

function mul_url(){
clear
banner
echo -e -n ${CP}"\n[+] Enter path of lists (e.g http|https://target.com/) : "
read  urls
for sanga in $(cat $urls);
do
res=$(curl -s $sanga -I)
echo "$res" >> temp.txt

sami=$(cat temp.txt | egrep -w 'X-Frame-Options|Content-Security-Policy|x-frame-options|content-security-policy:' )

if [[ $sami != '' ]];
then


echo -e -n ${CP}"\n[ X ] ${NC}$sanga ${YELLOW}NOT VULNERABLE "
else

echo -e -n ${BLUE2}"\n[ ✔ ] ${CG}$sanga ${RED}VULNERABLE \n" 
echo "$sanga" >> vulnerable_urls.txt

fi

done
rm temp.txt
}
trap ctrl_c INT
ctrl_c() {
clear
echo -e ${RED}"[*] (Ctrl + C ) Detected, Trying To Exit... "
echo -e ${RED}"[*] Stopping Services... "
if [ -f temp.txt ]; then
rm temp.txt
fi
sleep 1
echo ""
echo -e ${YELLOW}"[*] Thanks For Using CLICK-J1CK3R  :)"
exit
}

menu()
{
clear
banner
echo -e ${YELLOW}"\n[*] Choose Scanning Type: \n "
echo -e "  ${NC}[${CG}"1"${NC}]${CNC} Single Domain Scan"
echo -e "  ${NC}[${CG}"2"${NC}]${CNC} Multiple Domains Scan"
echo -e "  ${NC}[${CG}"3"${NC}]${CNC} Exit"

echo -n -e ${YELLOW}"\n[+] Select: "
        read redi_play
                if [ $redi_play -eq 1 ]; then
                        single_url
                elif [ $redi_play -eq 2 ]; then
                        mul_url
                elif [ $redi_play -eq 3 ]; then
                      exit
                fi
}
menu
#Coded By Machine404! Don't copy this code without giving me credit~
#https://instagram.com/invisibleclay100
#https://twitter.com/whoami4041
#https://www.youtube.com/channel/UCC_aPnmV_zGfdwktCFE9cPQ

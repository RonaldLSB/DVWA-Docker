#!/bin/bash

RunDVWA(){
    read -p "
[+] Run DVWA Image: 
 [1] In Background
 [2] In this terminal
 ~# " runback
    case $runback in
        2)
            echo -e "
[+] Go to http://127.0.0.1:80 to access the Web Application.
[+] To stop your docker container use 'CTRL+C'.\n"
            docker run --rm -it -p 80:80 vulnerables/web-dvwa
            ;;
        1)
            docker run --rm -dit -p 80:80 vulnerables/web-dvwa
            echo -e "
[+] Go to http://127.0.0.1:80 to access the Web Application.
[+] To stop your docker container follow these steps:
 ~# sudo docker ps
 ~# sudo docker stop <container id>\n"           
            ;;
        *)
            echo -e "\n[+] Invalid Option :("
            RunDVWA
            ;;
    esac
}

PullDVWA(){
    read -p "
Pull Image? [y/n]
 ~# " pullimg
    case $pullimg in
        'n')
            echo -e "\n[+] Bye :)\n"
            ;;
        *)
            docker pull vulnerables/web-dvwa
            chekDVWA
            ;;
    esac
}

chekDVWA(){
    echo -e "\n[+] Searching For: DVWA Docker Image"
    if [[ `docker images` == *"vulnerables/web-dvwa"* ]]; then
        echo -e "\n[+] Found :)"
        RunDVWA
    else
        echo -e "\n[+] Not Found :("
        PullDVWA
    fi
}

if [[ $(id -u) != 0 ]]; then
	echo -e "\n[+] Run as root :)\n"
	exit
fi;

echo -e "\n🄳 🅅 🅆 🄰 - 🄳🄰🄼🄽 🅅🅄🄻🄽🄴🅁🄰🄱🄻🄴 🅆🄴🄱 🄰🄿🄿🄻🄸🄲🄰🅃🄸🄾🄽"
chekDVWA

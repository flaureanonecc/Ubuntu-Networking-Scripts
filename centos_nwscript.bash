#!/bin/bash

#This script collects a few different types of information about the network running on the server and ouputs them to both the cmd line and a txt file saved in $HOME/network_reports
#For best results, run with sudo as your user account may not have  all the permissions to execute all of the commands

# This sets the current date in dd-mm-yyyy format to the variable DATE
DATE=$(date +"%d-%m-%Y")

# sets the directory path and if it doesnt exist, creates it.
DIRECTORY="$HOME/network_reports"
mkdir -p "$DIRECTORY"  # -p prevents errors if the directory is already created

echo "Network Info + Today's date: $DATE" | tee "$DIRECTORY/NWInfo_$DATE.txt"
echo "This information is also saved to a file named NWInfo_$DATE.txt and can be found in the folder created by this script called network_reports."

echo " *****************"
echo "IP"
# prints ip addresses  and sends the information to the file
ip a | tee -a "$DIRECTORY/NWInfo_$DATE.txt"
echo " *****************"

# Searches for the public google DNS server (via dig) and sends the output to the file
echo "Searching Google's name server" | tee -a "$DIRECTORY/NWInfo_$DATE.txt"
dig google.com | tee -a "$DIRECTORY/NWInfo_$DATE.txt"
echo " *****************"

# prints the default gateway of the network we're connected to and sends the output to the file
echo "Routing information"
ip route | tee -a "$DIRECTORY/NWInfo_$DATE.txt"
echo " *****************"

# prints the DNS servers used by the server and sends the information to the file
echo "DNS Servers"
cat /etc/resolv.conf | tee -a "$DIRECTORY/NWInfo_$DATE.txt"
echo " *****************"

# prints open ports and sends the information to the file
echo "Open Ports"
sudo ss -tuln | tee -a "$DIRECTORY/NWInfo_$DATE.txt"
echo " *****************"

# prints the network interfaces and sends the information to the file
echo "Network Interfaces"
ip link show | tee -a "$DIRECTORY/NWInfo_$DATE.txt"
echo " *****************"

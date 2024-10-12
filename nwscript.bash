#!/bin/bash

#This script collects a few different types of information about the network running on the server and ouputs them to both the cmd line and a txt file saved in $HOME/network_reports
#For best results, run with sudo as your user account may not have  all the permissions to execute all of the commands

# This sets the current date in dd-mm-yyyy format to the variable DATE
DATE=$(date +"%d-%m-%Y")

# Define the directory path and create it if it doesn't exist
DIRECTORY="$HOME/network_reports"
mkdir -p "$DIRECTORY"  # -p ensures no error if the directory already exists

# Outputs the network information header with the current date, saving it to both the terminal and the file
echo "Network Info + Today's date: $DATE" | tee "$DIRECTORY/NWInfo_$DATE.txt"
echo "This information is also saved to a file named NWInfo_$DATE.txt and can be found in the folder created by this script called network_reports."

echo " *****************"
echo "IP"
# Displays current IP addresses and sends the information to the file
ip a | tee -a "$DIRECTORY/NWInfo_$DATE.txt"
echo " *****************"

# Searches for the Google public DNS server information (via dig) and sends the output to the file
echo "Searching Google's name server" | tee -a "$DIRECTORY/NWInfo_$DATE.txt"
dig google.com | tee -a "$DIRECTORY/NWInfo_$DATE.txt"
echo " *****************"

# Displays the default gateway of the current network and sends the output to the file
echo "Default Gateway"
ip route | grep default | tee -a "$DIRECTORY/NWInfo_$DATE.txt"
echo " *****************"

# Shows the DNS servers configured for the system and sends the information to the file
echo "DNS Servers"
cat /etc/resolv.conf | grep 'nameserver' | tee -a "$DIRECTORY/NWInfo_$DATE.txt"
echo " *****************"

# Displays open ports (services) and sends the information to the file
echo "Open Ports"
sudo ss -tuln | tee -a "$DIRECTORY/NWInfo_$DATE.txt"
echo " *****************"

# Displays the network interfaces and sends the information to the file
echo "Network Interfaces"
ip link show | tee -a "$DIRECTORY/NWInfo_$DATE.txt"
echo " *****************"

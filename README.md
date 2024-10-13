This script runs some common networking commands to gather information about the server it's being run on. After displaying the results, it also writes the results to a file in a directory that it creates called network_reports, which resides in the user's home directory.

These commands are executed when ran:

netplan status

dig

ip route

sudo ss -tuln

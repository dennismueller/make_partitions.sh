#!/bin/bash

# Check parameter
[[ -n "$1" ]] || { echo "Usage: $0 DEVICE (for example /dev/sda)"; exit; }

# Check if file /tmp/fdisk.input exists, if not create it
if [ -f "/tmp/fdisk.input" ]; then true
	# File exists
else
	touch /tmp/fdisk.input
	echo -e "n\np\n1\n\n+102400K\na\n1\nn\np\n2\n\n+1048576K\nt\n2\n82\nn\np\n3\n\n+2097152K\nn\np\n\n\nw" >> /tmp/fdisk.input
fi

# Create Partitions
fdisk $1 < /tmp/fdisk.input 1&>2 > /dev/null

# Check
if [ $? -eq 0 ] ; then
	echo "Befehl wurde durchgeführt!"
else
	echo "Fehler: $1 konnte nicht gefunden werden! "
fi

# Remove fdisk.input file
rm /tmp/fdisk.input


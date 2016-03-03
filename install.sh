#!/bin/bash

case "$1" in 
    install)
        echo "Installing fm_transmitter..."
        echo "Install git..."
        sudo apt-get install git
        echo "Go to /home/pi/ ..."
        sudo cd /home/pi/
        echo "Downloading data from Github..."
        sudo git clone https://github.com/markondej/fm_transmitter/
        echo "Go to /home/pi/fm_transmitter/"
        sudo cd /home/pi/fm_transmitter/
        echo "Install make..."
        sudo apt-get install make gcc g++
        echo "Compile source..."
        sudo make
        echo "Ready!"
        
        ;;
    *)
        echo "==== fm_transmitter_installer ===="
        echo "by clerie (https://github.com/clerie/)"
        echo ""
        echo "Add this:     to:"
        echo "install       run the installation of the fm_transmitter"
        exit 1
        ;;
esac

exit 0

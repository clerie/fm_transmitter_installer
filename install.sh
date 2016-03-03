#!/bin/bash

# Loading status of installation
if [ -d "/home/pi/fm_transmitter/" ]
then
    status="ok"
else
    status="no"
fi

case "$1" in 
    install)
        case "$2" in
            core)
                
                case "$status" in
                    ok)
                        echo "The core is installed "
                    ;;
                    *)
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
                esac
            ;;
        esac
    ;;
    *)
        echo "==== fm_transmitter_installer ===="
        echo "by clerie (https://github.com/clerie/)"
        echo ""
        echo "Add this:         to:"
        echo "install core      run the installation of the fm_transmitter core (do this first)"
        exit 1
    ;;
esac

exit 0

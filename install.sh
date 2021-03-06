#!/bin/bash

# Loading status of installation
# CORE
if [ -f "/home/pi/fm_transmitter/fm_transmitter" ]
then
    statusCORE="ok"
else
    statusCORE="no"
fi
# LAUNCHER
if [ -f "/home/pi/fm_transmitter.sh" ]
then
    statusLAUNCHER="ok"
else
    statusLAUNCHER="no"
fi
# AUTORUN
if [ -f "/etc/init.d/fm_transmitter.sh" ]
then
    statusAUTORUN="ok"
else
    statusAUTORUN="no"
fi






case "$1" in 
    install)
        case "$2" in
            core)
                case "$statusCORE" in
                    ok)
                        echo "The core is installed"
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
            launcher)
                case "$statusLAUNCHER" in
                    ok)
                        echo "The launcher is installed"
                    ;;
                    *)
                        echo "The launcher is not installed"
                        case "$statusCORE" in
                            ok)
                                echo "The core is installed"
                            ;;
                            *)
                                echo "The core is not installed"
                            ;;
                        esac
                    ;;
                esac
            ;;
            autorun)
                case "$statusAUTORUN" in
                    ok)
                        echo "The autorun is installed"
                    ;;
                    *)
                        echo "The autorun is not installed"
                        case "$statusLAUNCHER" in
                            ok)
                                echo "The launcher is installed"
                            ;;
                            *)
                                echo "The launcher is not installed"
                            ;;
                        esac
                    ;;
                esac
            ;;
        esac
    ;;
    *)
        echo "==== fm_transmitter_installer ===="
        echo "by clerie (https://github.com/clerie/)"
        echo ""
        echo "Add this:             to:"
        echo "install core          install the fm_transmitter core"
        echo "                          - first step you had to do"
        echo "                          Installation status: $statusCORE"
        echo "install launcher      install an start-file in /home/pi/"
        echo "                          - provides an easy to use launcher for wav and mp3"
        echo "                          Installation status: $statusLAUNCHER"
        echo "install autorun       install an autorun-file in /etc/init.d/"
        echo "                          - running on default values of launcher"
        echo "                          Installation status: $statusAUTORUN"
        exit 1
    ;;
esac

exit 0

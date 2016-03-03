#!/bin/bash
# /etc/init.d/pirateRadio.sh

i=0
for line in $(cat /home/pi/fm_transmitter/config/frequency.txt)
do
    if [ $i -eq 0 ]
    then
       DEFAULTfrequency=$line
    fi
    i=$(( $i+1 ))
done;

i=0
for line in $(cat /home/pi/fm_transmitter/config/path.txt)
do
    if [ $i -eq 0 ]
    then
       path="$line"
    fi
    i=$(( $i+1 ))
done;

pathEMERGENCY="/home/pi/fm_transmitter/config/jingle/*"

if [ -d "$path" ]
then
    playlist="$path/*"
else
    playlist="$pathEMERGENCY"
fi

# $DEFAULTfrequency


case "$1" in 
    start)
        echo "Piratensender wird gestartet"
        case "$2" in
            frequency)
                echo "Sender wird auf $3 Mhz gestrtet"
                sudo /usr/bin/mpg123 -4 -s -Z -v --gapless $playlist | sudo /home/pi/fm_transmitter/fm_transmitter -f $3 -
            ;;
            path)
                echo "Sender wird auf $3 Mhz gestrtet"
                sudo /usr/bin/mpg123 -4 -s -Z -v --gapless $3 | sudo /home/pi/fm_transmitter/fm_transmitter -f $DEFAULTfrequency -
            ;;
            *)
                echo "Sender wird auf $DEFAULTfrequency Mhz gestartet"
                sudo /usr/bin/mpg123 -4 -s -Z -v --gapless $playlist | sudo /home/pi/fm_transmitter/fm_transmitter -f $DEFAULTfrequency -
            ;;

        esac
        ;;
    stop)
        echo "Piratensender wird beendet"
        killall fm_transmitter
        ;;
    default)
        case "$2" in
            frequency)
                if [ $3 -eq '']
                then
                    echo "Bitte am Ende Frequenz hinzufügen"
                else
                    echo "Standart Frequenz wird auf $3 Mhz gesetzt"
		    echo "$3" > /home/pi/fm_transmitter/config/frequency.txt
                fi
            ;;
            path)
                if [ $3 -eq '']
                then
                    echo "Bitte am Ende Pfad hinzufügen"
                else
                    echo "Standart Pfad wird auf $3 gesetzt"
		    echo "$3" > /home/pi/fm_transmitter/config/path.txt
                fi
            ;;
            *)
                echo "Einstellungen"
                echo "Frequenz: $DEFAULTfrequency"
                echo "Pfad: $path/*"
                echo ""
                echo "Berechnet"
                echo "Playlist: $playlist"
            ;;
        esac
        ;;
    *)
        echo "Usage: /etc/init.d/pirateRadio.sh [start|stop|default] [frequency|path] <value>"
        exit 1
        ;;
esac

exit 0

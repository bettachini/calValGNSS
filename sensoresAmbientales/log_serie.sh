#!/bin/bash

resu=$(ntpdate -qs ntp.aggo-conicet.gob.ar)
MJD=$(( ( $(date +%s -d "$DAY") / 86400 ) + 40587 ))
hora=$(date +"%H:%M")
EXTEN="_NTP_AGGO.txt"
DIRE="/home/pi/Desktop/logNTP/2024/"
NOMBRE="$DIRE$MJD$EXTEN"
char="   "
entrada="$hora$char$resu"
echo $entrada >> $NOMBRE
sleep 5

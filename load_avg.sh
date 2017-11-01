#!/bin/bash

# meri koliki je load average iz /proc/loadavg
# ako je veci od 6.00 posalji mail na odredjene adrese
# crontabom pokreci skriptu svakih 5 minuta


# :D

# PROMENLJIVE

#
# cpucrit je vrednost koja je referenta
#
cpucrit=6

#
# cpuavg je pricitana vrednost iz proc-a
#
cpuavg=`cat /proc/loadavg | cut -d' ' -f1`

#
# naredba koja pretvara float u integer (bash ne moze da operise sas float brojevima)
# 0.5 / 1 omogucava zaokruzivanje na 1.5 =2 1.49 =1
#
# echo "($cpuavg+0.5)/1" | bc
#
#
# cpua promenljiva koja smesta integer za poredjenje
#
cpua=$(echo "($cpuavg+0.5)/1" | bc)

#echo $cpua


# email adrese za report
madresa="dusan@vin.bg.ac.rs"
imadresa2="ivan_m@vin.bg.ac.rs"
madresa3="support@tmf.bg.ac.rs"



# LOGIKA
# ako je  je avg veci od zadataog
# posalji mail na zadate adrese da je cpu preveliki
#
if [ $cpua -ge $cpucrit ]
then
  echo "Granica za CPU alert je   $cpucrit . CPU je prekoracio granicu i iznosi =   $cpuavg" | mutt -s "Veliki CPU na mail serveru VINCA" -- $madresa
  echo "Granica za CPU alert je   $cpucrit . CPU je prekoracio granicu i iznosi =   $cpuavg" | mutt -s "Veliki CPU na mail serveru VINCA" -- $madresa2
  echo "Granica za CPU alert je   $cpucrit . CPU je prekoracio granicu i iznosi =   $cpuavg" | mutt -s "Veliki CPU na mail serveru VINCA" -- $madresa3
fi

# echo "jebote veliki je cpu i iznosi =   $cpua,   $cpuavg"


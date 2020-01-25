#!/bin/bash

## pronadji broj mailova u queue
## ako je broj mailova u queue veci od pretpostvaljanog broja (50)
## obavesti admine na mail adrese da je mailqueue veci od broja
## i da je u pitanju spam


### PROMENLJIVE

## maxmq je broj mailova koji je granica odlucivanja da li je spam report ili ne

maxmq=50

## mq je promenljiva broja mailova u queue

mq=`mailq | tail -n 1 | cut -d' ' -f5`


## mail adrese na koje treba slati spam report ako pstoji
madresa="mail1@mail.com"
#madresa2="mail2@mail.com"

if [ -z "$mq" ]; then
  mq=0
fi




echo $mq


if [ $mq -ge $maxmq ]
 then


  ## obavesti me da je broj veci
    echo "broj je veci"
  ## odradi mailq > izvestaj.txt
    mailq > /root/skripte/izvestaj.txt

    echo "Broj mailova u queue-u je  $mq" | mutt -a "/root/skripte/izvestaj.txt" -s "Sirimo spam -- ponovo" -- $madresa
#    echo "Broj mailova u queue-u je  $mq" | mutt -a "/root/skripte/izvestaj.txt" -s "Sirimo spam test" -- $madresa2



else

  echo "broj mailova je $mq"

fi

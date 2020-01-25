#!/bin/bash

##### /bin/bash -x za debug


### parametri i promenljive
# krit_broj je broj mailova koji se nalazi po jednom coveku u deferred statusu ili incoming
# idealno je da se cronuje na 5 min

krit_broj=50

madresa="support@tmf.bg.ac.rs"

# parametri baze

dbuser="new"
dbpass="thething1234"
dbbase="nss_mysql"
dbtable="user"
username="p2"
password="promenime1234"
password=`openssl passwd -1 -salt xyz $password`

# ovo su stringovi koji ce upisati useru sifru jebise1234

#dbstring="UPDATE $dbtable set PASSWORD = '$password' WHERE user_name = '$username'"
#mysql --user="$dbuser" --host="147.91.42.152" --password="$dbpass" --database="$dbbase" --execute="$dbstring";



### pripremi fajlove
rm /tmp/fs/test2.txt
touch /tmp/fs/test2.txt


# pronadji mailove koji su u deferred statusu
# nadji njihove id
cd /var/spool/postfix/deferred/
find -type f | cut -c 5- > /tmp/fs/test.txt

cd /var/spool/postfix/active
find -type f  | cut -c 3- >> /tmp/fs/test.txt


# pronadji koji useri salju postu preko polja auth user
# zapisi njihova imena u fajl
for i in `cat /tmp/fs/test.txt`
 do
   /usr/sbin/postcat -hq $i | grep "Authenticated sender" | sed -e's/  */ /g' | cut -d" " -f3 | sed 's/.$//' >> /tmp/fs/test2.txt
done



### nadji uniq zapise
for i in `cat /tmp/fs/test2.txt | sort | uniq`
 do

# prebroj koliko ih svako ima
 broj=`grep -o $i /tmp/fs/test2.txt | wc -l`

# ako je broj veci od zadatog krit_broj i ako nisu tmf, root i ostali probrojani nalozi
# promenu mu sifru, jebi mu kevu!

echo ime je $i a broj je $broj

  if [ "$broj" -gt "$krit_broj" ] && [ "$i" != "tmf" ] && [ "$i" != "root" ] && [ "$i" != "valent" ]
    then

  dbstring="UPDATE $dbtable set PASSWORD = '$password' WHERE user_name = '$i'"
 mysql --user="$dbuser" --host="147.91.42.152" --password="$dbpass" --database="$dbbase" --execute="$dbstring";

    echo obradi usera $i broj deferred mailova je $broj > /root/skripte/brojmail_report.txt

 echo "useru $i  je promenjena sifra jer je queue na njegovo ime veci od $krit_broj " | mutt -a "/tmp/fs/test2.txt" -s "useru promenjena sifra TMF - automatska promena" -- $madresa

/usr/sbin/service dovecot stop
sleep 5
/usr/sbin/service dovecot start

   fi
 done




#### ubij dovecot i resetuj servis
#killall telnet
#service dovecot stop
#sleep 5
#service dovecot start

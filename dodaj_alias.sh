#!/bin/bash

# Ova skripta treba da automatizuje popunjavanje aliasa za postfix
# Za novokreiranog linux usera dopisuje dodatna adrese:
#
#
# username:   username@example.com
# ime_prezime:   username
# ime.prezime:   username
# Ime_prezime:   username
# Ime.Prezime:   username
#
#
# Idealno iscitava iz passwd fajla ta imena i automatski ih generise
# Verzija 0.01 treba da pokupi username iz cmd prompta i da pronadje
# ime i prezime u passwdu te da generise aliase
# podrazumeva se da su Ime i Prezime uneti sa prvim velikim slovom
#
# Zavrsetak programa je naredba newaliases koja updatuje postfix bazu aliasa




# echo "Type the year that you want to check (4 digits), followed by [ENTER]:"


echo "Unesi username za koji ces da napravis aliase i pritisni [ENTER]:"
read username


# citaj passwd
imeprezime=`getent passwd $username | cut -d ':' -f 5 | cut -d ',' -f 1`

# Razdvoj $varijablu na $ime i $prezime

ime=$(echo $imeprezime | cut -d " " -f 1)
prezime=$(echo $imeprezime | cut -d " " -f 2)

# konvertuj sve u mala slova
#sime=${ime,,}

sime=`echo $ime | tr '[:upper:]' '[:lower:]'`
sprezime=$(echo $prezime | tr '[:upper:]' '[:lower:]')

# ispisi na ekran
echo "Ime je  " $ime " a prezime je  " $prezime
echo "Nastaviti?  pritisni [y/n]"
read yn





# napuni fajl aliases sa kombinacijama koje su potrebne
echo "# separaor za korisnika $username"  >> /etc/aliases
echo $username":   "$username"@example.com" >> /etc/aliases
echo $sime"_"$sprezime":   "$username >> /etc/aliases
echo $sime"."$sprezime":   "$username >> /etc/aliases
echo $ime"_"$prezime":   "$username >> /etc/aliases
echo $ime"."$prezime":   "$username >> /etc/aliases


# pokreni 
 /usr/bin/newaliases
 
 # izadji
 exit
 

#!/bin/bash

# skirpta se pokrece na backup strani
# ovo bqackupje baze incremnetal
rsync -haz -i --rsh='ssh -p4000' SOURCE_KOMP:/putanja_do_mssql_baza/ /DETINATION/putanja_do_backupa/
chown mssql:mssql -R /DETINATION/putanja_do_backupa/

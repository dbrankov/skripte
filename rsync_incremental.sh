#!/bin/bash

# ovo bqackupje baze incremnetal
rsync -haz -i --rsh='ssh -p4000' 147.91.42.159:/var/dbbackup/ /home/BACKUP/SERVISI/akreditacija2019_baza/
chown mssql:mssql -R /home/BACKUP/SERVISI/akreditacija2019_baza/

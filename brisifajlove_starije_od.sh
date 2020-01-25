#!/bin/bash

#
# BRISI MAILOVE STARIJE OD $DAN
# iz incrimental foldera

PUTANJA="/home/BACKUP/ELAB/incrimentbackup/"
DAN=60

find $PUTANJA -type f -mtime +$DAN -exec rm {} \;

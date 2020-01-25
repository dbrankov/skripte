#!/bin/bash

#
# BRISI MAILOVE STARIJE OD $DAN
# iz incrimental foldera

PUTANJA="/putanja incrimnetal foldera/"
DAN=60

find $PUTANJA -type f -mtime +$DAN -exec rm {} \;

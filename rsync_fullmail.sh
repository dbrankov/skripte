#!/bin/bash



START=$(date +%s)

##rsync -haz --delete -i  --exclude={/var/*,/dev/*,/proc/*,/sys/*,/tmp/*,/mnt/*,/media/*,/root/backup/novi/*} /* 147.91.42.75:/home/BACKUP/Mail/

cd /root/skripte



#rsync -haz --delete -i  --exclude-from='testexclude' /* 147.91.42.75:/home/BACKUP/Mail/
#rsync -haz --delete -i  --include-from='testinclude' /home/* 147.91.42.75:/home/BACKUP/ELAB/home

rsync -haz --delete --log-file /var/log/rsync_backup.log --rsh='ssh -p4000' /home 147.91.42.75:/home/BACKUP/ELAB/

rsync -haz --delete --rsh='ssh -p4000' /etc 147.91.42.75:/home/BACKUP/ELAB/
#rsync -haz --delete --rsh='ssh -p4000' /var/spool 147.91.42.75:/home/BACKUP/ELAB/
rsync -haz --delete  --rsh='ssh -p4000' /root 147.91.42.75:/home/BACKUP/ELAB/


FINISH=$(date +%s)


echo "total time: $(( ($FINISH-$START) / 60 )) minutes, $(( ($FINISH-$START) % 60 )) seconds"

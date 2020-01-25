#!/bin/bash



START=$(date +%s)

##rsync -haz --delete -i  --exclude={/var/*,/dev/*,/proc/*,/sys/*,/tmp/*,/mnt/*,/media/*,/root/backup/novi/*} /* REMOTE_HOST:/path_to_BACKUP/Mail/

cd /root/skripte



#rsync -haz --delete -i  --exclude-from='testexclude' /*  REMOTECOMP:/PATH_TO_BACKUP/ELAB/
#rsync -haz --delete -i  --include-from='testinclude' /home/*  REMOTECOMP:/PATH_TO_BACKUP/ELAB/

rsync -haz --delete --log-file /var/log/rsync_backup.log --rsh='ssh -p4000' /home REMOTECOMP:/PATH_TO_BACKUP/ELAB/

rsync -haz --delete --rsh='ssh -p4000' /etc /home REMOTECOMP:/PATH_TO_BACKUP/ELAB/
#rsync -haz --delete --rsh='ssh -p4000' /var/spool /home REMOTECOMP:/PATH_TO_BACKUP/ELAB/B/
rsync -haz --delete  --rsh='ssh -p4000' /root /home REMOTECOMP:/PATH_TO_BACKUP/ELAB/


FINISH=$(date +%s)


echo "total time: $(( ($FINISH-$START) / 60 )) minutes, $(( ($FINISH-$START) % 60 )) seconds"

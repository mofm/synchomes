#!/bin/bash

# exclude-list file
EXCLUDE="sync_exclude"
# port for rsync over ssh
PORT="your_port"
# backup hostname or IP
HOST="examples.com"
# Your SSH ID KEY
SSH_ID="$HOME/.ssh/id_rsa"
# username for rsync over ssh
USER="user"
# backup directory path on backup host
SYNC_DIRECTORY="/home/user/backup/"

# Check ssh connection

status=$(ssh -q -o BatchMode=yes -o ConnectTimeout=5 -i $SSH_ID $USER@$HOST -p $PORT echo ok 2>&1)
if [[ $status == ok ]] ; then
        echo $HOST connection successful 
elif [[ $status == "Permission denied"* ]] ; then
        echo $HOST $status "Permission denied.Check ssh connection"
else
        echo $HOST $status "Check network and ssh connection"
fi


rsync -avz --exclude-from "$EXCLUDE" --max-size=50M -e 'ssh -p '$PORT'' $HOME "$USER"@"$HOST":"$SYNC_DIRECTORY"

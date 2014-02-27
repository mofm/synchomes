#!/bin/bash

# exclude-list file
EXCLUDE="sync_exclude"
# port for rsync over ssh
PORT="your_port"
# backup hostname or IP
HOST="example.com"
# Your SSH ID KEY
SSH_ID="$HOME/.ssh/your_key"
# username for rsync over ssh
USER="your_user"
# backup directory path on backup host
SYNC_DIRECTORY="/home/backup/test"

# Check ssh connection
check_ssh() {

    ssh_connect=$(ssh -q -o BatchMode=yes -o ConnectTimeout=5 -i $SSH_ID $USER@$HOST -p $PORT echo $?)
    if [[ $ssh_connect == 0 ]] ; then
    	echo $HOST ssh connection successful
    elif [[ $status == "Permission denied"* ]] ; then
        echo $HOST $status "Permission denied.Check ssh connection"
	exit 1
    else
       	echo $HOST $status "Check network and ssh connection"
	exit 1
    fi
}

# Check remote backup directory
check_remotedirectory() {
    check_directory=$(ssh -q -o BatchMode=yes -i $SSH_ID $USER@$HOST -p $PORT [ -d "$SYNC_DIRECTORY" ] &&  echo $?)
    if [[ $check_directory == 0 ]] ; then
    	echo $SYNC_DIRECTORY found.OK.
    else
    	echo $SYNC_DIRECTORY not found.check this!!!
	exit 1
    fi
}

# execute functions
check_ssh && check_remotedirectory

#rsync -avz --exclude-from "$EXCLUDE" --max-size=50M -e 'ssh -p '$PORT'' $HOME "$USER"@"$HOST":"$SYNC_DIRECTORY"

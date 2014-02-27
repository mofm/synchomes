#!/bin/bash

# exclude-list file
EXCLUDE="sync_exclude"
# port for rsync over ssh
PORT="your_port"
# backup hostname or IP
HOST="examples.com"
# username for rsync over ssh
USER="user"
# backup directory path on backup host
SYNC_DIRECTORY="/home/user/backup/"

rsync -avz --exclude-from "$EXCLUDE" --max-size=50M -e 'ssh -p '$PORT'' $HOME "$USER"@"$HOST":"$SYNC_DIRECTORY"

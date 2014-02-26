#!/bin/bash

EXCLUDE="$HOME/rsync_exclude"
PORT="2212"
HOST="piesso.com"
USER="backup"
SYNC_DIRECTORY="/home/backup/test/"

rsync -avz --exclude-from "$EXCLUDE" --max-size=50M -e 'ssh -p '$PORT'' $HOME "$USER"@"$HOST":"$SYNC_DIRECTORY"

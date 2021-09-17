#!/bin/bash

# --------- USER DEPENDENT VARIABLES ----------

# Bitwarden backup folder goes here
BITWARDEN_FOLDER="/opt/bitwarden/bwdata/mssql/backups/"

# Git backup folder goes here
GIT_FOLDER="/opt/bitwarden/bwdata/backup-folder"

# -----------------------------------------------

# get name of nNew backup file that was created today
NEW_FILE=$(find $BITWARDEN_FOLDER -mtime -1 -type f -printf "%f\n")

echo "Copying over $NEW_FILE"

# Copy over the backup file created today over to the git folder
cp $BITWARDEN_FOLDER/$NEW_FILE $GIT_FOLDER/Bitwarden

# Compress the copied over file using gzip format
gzip $GIT_FOLDER/Bitwarden/$NEW_FILE

# Add the new file and push the changes to the git repo
cd $GIT_FOLDER
git add Bitwarden/$NEW_FILE.gz
git commit -m "Backup completed by backup.sh script at $(date)"
git pull origin master
git push
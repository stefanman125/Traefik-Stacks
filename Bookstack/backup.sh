#!/bin/bash

# --------- USER DEPENDENT VARIABLES ----------

# Git backup folder goes here
GIT_FOLDER="/home/user/bookstack/backup-folder/"

# -----------------------------------------------

# Navigate to your specified backup folder
cd $GIT_FOLDER/Bookstack

# Create the name of the backup file
BACKUP_FILENAME=$(date +%Y-%m-%d-%T).sql

# Backup the database and redirect into the file
docker exec bookstack_db /usr/bin/mysqldump -u sqluser --password=passwd bookstackapp > $BACKUP_FILENAME

# Compress the new backed up file
gzip $BACKUP_FILENAME

git pull origin master
# Add the new file and push the changes to the git repo
git add $BACKUP_FILENAME.gz
git commit -m "Backup completed by user using the backup.sh script at $(date)"
git push
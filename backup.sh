#!/bin/bash

# PostgreSQL settings
DATE=$(date +"%Y-%m-%d-%H-%M-%S")
USER=$DB_USER
DB_NAME=$DB_NAME
BACKUP_DIR="/backup"

# Set the filename with date and time of backup
FILENAME="$BACKUP_DIR/$DB_NAME-$DATE.sql"

# Optional: Specify the host and port if not using the default ones
HOST=$DB_HOST
PORT=$DB_PORT

# Perform the backup using pg_dump
PGPASSWORD=$DB_PASSWORD pg_dump -h $HOST -p $PORT -U $USER $DB_NAME > $FILENAME

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo "Backup successfull: $FILENAME"
else
    echo "Backup failed"
    exit 1
fi

# Optional: Remove backups older than 30 days
find $BACKUP_DIR -type f -name "*.sql" -mtime +30 -exec rm {} \;
aws s3 cp s6-user-* s3://$BUCKET_NAME

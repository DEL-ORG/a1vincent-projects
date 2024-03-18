#!/bin/bash

# aws configure information
AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION

# PostgreSQL database information
DB_HOST=$DB_HOST
DB_PORT=$DB_PORT
DB_NAME=$DB_NAME
DB_USER=$DB_USER
DB_PASSWORD=$DB_PASSWORD
BUCKET_NAME=$BUCKET_NAME

aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID && \
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY && \
aws configure set default.region $AWS_DEFAULT_REGION && \
aws configure set output json   

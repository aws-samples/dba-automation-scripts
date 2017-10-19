#!/usr/bin/env bash

# Change this value if you want to work with a different region
REGION="us-west-2"
# Enter the database name you want to take a manual snapshot of
DB="sqltest"

# take a manual snapshot of the database
aws rds create-db-snapshot --db-snapshot-identifier "sqltest-master-snapshot" \
    --db-instance-identifier $DB --tags "Key=project,Value=basedatabase" --region $REGION


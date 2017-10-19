#!/usr/bin/env bash
# Change this value if you want to work with a different region
REGION="us-west-2"
# Change this value to the datbase you want to restore to a point in time.
DB="sqltest"
# Issue a describe-db-instances to retrieve the value of
# "LatestRestorableTime": "2017-10-04T01:53:01Z",
aws rds describe-db-instances --db-instance-identifier sqltest --region $REGION
# If your latest restore time from the output is 2017-10-04T01:53:01Z
#   and your retention period is 1 day the command below will succeed
#
# Change the restore time to match the values on your instance
# Database will be restored to database-name-copy
aws rds restore-db-instance-to-point-in-time --source-db-instance-identifier $DB \
    --target-db-instance-identifier $DB-copy \
    --restore-time 2017-10-04T00:00:00.000Z --region $REGION
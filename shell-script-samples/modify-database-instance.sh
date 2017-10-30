#!/usr/bin/env bash
# Set this value for the database identifier you want to modify
DB="sqltest"

# Change this value if you want to work with a different region
REGION="us-west-2"
# Prerequisites for running these code examples
# This script assumes you have created your parameter and option groups ahead of time or you are using default
PARAMETER_GROUP_NAME="sqlserver-se-12-c2-audit-enabled"
OPTION_GROUP_NAME="sqlserver-se-12-native-backup"

# modify an rds instance to use a bigger box
#   This command can also be used to scale down the instance or change other values based on your engine
aws rds modify-db-instance --db-instance-identifier $DB --db-instance-class db.m4.xlarge \
    --apply-immediately --region $REGION

# modify the rds instance to use a different option group and apply it immediately
aws rds modify-db-instance --db-instance-identifier $DB --option-group-name  $OPTION_GROUP_NAME\
    --apply-immediately --region $REGION
#!/usr/bin/env bash

# Change this value if you want to work with a different region
REGION="us-west-2"
# Change this security group value to one that is valid for your VPC
SECURITY_GROUP="sg-66876201"

# create a new SQLServer RDS Multi-AZ database with default parameter, default option group, and publicly accessible
# database should be Standard Edition v12 with license included
aws rds create-db-instance --db-instance-identifier "sqltest" --allocated-storage 500 --db-instance-class db.m4.large \
    --engine sqlserver-se --engine-version "12.00.4422.0.v1" --master-username "myuser" --master-user-password "mypassword" \
    --vpc-security-group-ids $SECURITY_GROUP --backup-retention-period 7 --license-model license-included \
    --tags "Key=project,Value=configdata" --region "us-west-2" --multi-az --publicly-accessible --region $REGION
# The output of this command will be the database configuration. DB will take a few minutes to create
#   and take the initial snapshot
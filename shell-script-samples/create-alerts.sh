#!/usr/bin/env bash

# Change this value if you want to work with a different region
REGION="us-west-2"
# Change this to your actual email address
EMAILADDR="my-address@example.com"
# Change this value to the datbase you want to set alerts on
DB="sqltest"

aws sns create-topic --name "application-dba-notification" --region us-west-2
#This will prompt you to enter the new topic ARN if you want to run this as a full script
echo "Enter the topic ARN: "
read TOPICARN
# Subscribe to the new topic
# To actually create a subscription, the subscription must be confirmed
aws sns subscribe --topic-arn $TOPICARN \
    --protocol email --notification-endpoint $EMAILADDR

# Adding an alarm through the CLI
aws cloudwatch put-metric-alarm --alarm-name "Commit latency" \
    --alarm-description "commit-latency" --actions-enabled \
    --alarm-actions "$TOPICARN" \
    --metric-name "CommitLatency" --namespace "AWS/RDS" --statistic "Maximum" \
    --dimensions "Name=DBInstanceIdentifier,Value=$DB" --period 300 \
    --evaluation-periods 2 --threshold 5.0 --comparison-operator GreaterThanOrEqualToThreshold \
    --treat-missing-data notBreaching --region $REGION

# Adding an alarm through the CLI
aws cloudwatch put-metric-alarm --alarm-name "Insert latency" \
    --alarm-description "commit-latency" --actions-enabled \
    --alarm-actions "$TOPICARN" \
    --metric-name "InsertLatency" --namespace "AWS/RDS" --statistic "Maximum" \
    --dimensions "Name=DBInstanceIdentifier,Value=$DB" --period 300 \
    --evaluation-periods 2 --threshold 1.0 --comparison-operator GreaterThanOrEqualToThreshold \
    --treat-missing-data notBreaching --region $REGION

# Adding an alarm through the CLI
aws cloudwatch put-metric-alarm --alarm-name "Delete latency" \
    --alarm-description "commit-latency" --actions-enabled \
    --alarm-actions "$TOPICARN" \
    --metric-name "DeleteLatency" --namespace "AWS/RDS" --statistic "Maximum" \
    --dimensions "Name=DBInstanceIdentifier,Value=$DB" --period 300 \
    --evaluation-periods 2 --threshold 1.0 --comparison-operator GreaterThanOrEqualToThreshold \
    --treat-missing-data notBreaching --region $REGION

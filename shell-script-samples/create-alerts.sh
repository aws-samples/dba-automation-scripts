#!/usr/bin/env bash

# Change this value if you want to work with a different region
REGION="us-west-2"
# Change this to your actual email address
EMAILADDR="my-address@example.com"
# Change this value to the datbase you want to set alerts on
DB="sqlse"

aws sns create-topic --name "application-dba-notification" --region $REGION
#This will prompt you to enter the new topic ARN if you want to run this as a full script
echo "Enter the topic ARN: "
read TOPICARN
# Subscribe to the new topic
# To actually create a subscription, the subscription must be confirmed
aws sns subscribe --topic-arn $TOPICARN \
    --protocol email --notification-endpoint $EMAILADDR --region $REGION

# Adding an alarm through the CLI
aws cloudwatch put-metric-alarm --alarm-name "Write throughput" --alarm-description "write-throughput" --actions-enabled \
    --alarm-actions "$TOPICARN" --metric-name "WriteThroughput" --namespace "AWS/RDS" --statistic "Maximum" \
    --dimensions "Name=DBInstanceIdentifier,Value=$DB" --period 300 --evaluation-periods 2 --threshold 48000 \
    --comparison-operator GreaterThanOrEqualToThreshold --treat-missing-data notBreaching --region $REGION

# Adding an alarm through the CLI
aws cloudwatch put-metric-alarm --alarm-name "Write latency" --alarm-description "write-latency" --actions-enabled \
    --alarm-actions "$TOPICARN" --metric-name "WriteLatency" --namespace "AWS/RDS" --statistic "Maximum" \
    --dimensions "Name=DBInstanceIdentifier,Value=$DB" --period 300 --evaluation-periods 2 --threshold 0.004 \
    --comparison-operator GreaterThanOrEqualToThreshold --treat-missing-data notBreaching --region $REGION

# Adding an alarm through the CLI
aws cloudwatch put-metric-alarm --alarm-name "Read Latency" \
    --alarm-description "read-latency" --actions-enabled \
    --alarm-actions "$TOPICARN" \
    --metric-name "ReadLatency" --namespace "AWS/RDS" --statistic "Maximum" \
    --dimensions "Name=DBInstanceIdentifier,Value=$DB" --period 300 \
    --evaluation-periods 2 --threshold 0.010 --comparison-operator GreaterThanOrEqualToThreshold \
    --treat-missing-data notBreaching --region $REGION

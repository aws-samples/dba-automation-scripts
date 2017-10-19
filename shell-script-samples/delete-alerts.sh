#!/usr/bin/env bash

# Change this value if you want to work with a different region
REGION="us-west-2"

# Example for deleting the Commit latency test alarm created earlier through the CLI
aws cloudwatch delete-alarms --alarm-names "Commit latency" --region $REGION

# Example for deleting the Insert latency test alarm created earlier through the CLI
aws cloudwatch delete-alarms --alarm-names "Insert latency" --region $REGION

# Example for deleting the Delete latency test alarm created earlier through the CLI
aws cloudwatch delete-alarms --alarm-names "Delete latency" --region $REGION


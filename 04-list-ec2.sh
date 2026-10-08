#!/bin/bash
# Lesson: using --query and --output to shape AWS CLI results.
# Usage: ./04-list-ec2.sh [region]

REGION="${1:-us-east-1}"

echo "EC2 instances in $REGION"
aws ec2 describe-instances \
    --region "$REGION" \
    --query "Reservations[].Instances[].[InstanceId,State.Name,InstanceType,Tags[?Key=='Name']|[0].Value]" \
    --output table

#!/bin/bash
# Lesson: case statements and tag filters. Great for saving money on dev servers.
# Usage: ./05-ec2-start-stop.sh start|stop <tag-value>
# Targets instances with the tag Environment=<tag-value>, e.g. "dev"

ACTION="$1"
ENV_TAG="$2"

if [ -z "$ACTION" ] || [ -z "$ENV_TAG" ]; then
    echo "Usage: $0 start|stop <environment-tag>"
    exit 1
fi

case "$ACTION" in
    start)
        FILTER_STATE="stopped"
        CMD="start-instances"
        ;;
    stop)
        FILTER_STATE="running"
        CMD="stop-instances"
        ;;
    *)
        echo "Action must be 'start' or 'stop'"
        exit 1
        ;;
esac

IDS=$(aws ec2 describe-instances \
    --filters "Name=tag:Environment,Values=$ENV_TAG" "Name=instance-state-name,Values=$FILTER_STATE" \
    --query "Reservations[].Instances[].InstanceId" \
    --output text)

if [ -z "$IDS" ]; then
    echo "No matching instances found."
    exit 0
fi

echo "Running $ACTION on: $IDS"
aws ec2 $CMD --instance-ids $IDS

#!/bin/bash
# Lesson: checking tools and credentials before doing anything else.
# Concepts: command -v, if/else, exit codes

if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed."
    exit 1
fi

echo "AWS CLI version: $(aws --version)"

# This call fails if credentials are missing or wrong
if aws sts get-caller-identity &> /dev/null; then
    echo "Credentials OK. You are:"
    aws sts get-caller-identity --query "Arn" --output text
else
    echo "Credentials not configured. Run: aws configure"
    exit 1
fi

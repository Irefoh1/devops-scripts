#!/bin/bash
# Lesson: script arguments and variables.
# Usage: ./02-create-s3-bucket.sh my-unique-bucket-name [region]
# Note: S3 bucket names are globally unique.

BUCKET_NAME="$1"
REGION="${2:-us-east-1}"   # default region if none is given

if [ -z "$BUCKET_NAME" ]; then
    echo "Usage: $0 <bucket-name> [region]"
    exit 1
fi

echo "Creating bucket $BUCKET_NAME in $REGION..."

if [ "$REGION" = "us-east-1" ]; then
    aws s3api create-bucket --bucket "$BUCKET_NAME" --region "$REGION"
else
    aws s3api create-bucket --bucket "$BUCKET_NAME" --region "$REGION" \
        --create-bucket-configuration LocationConstraint="$REGION"
fi

# Good practice: block public access by default
aws s3api put-public-access-block --bucket "$BUCKET_NAME" \
    --public-access-block-configuration \
    BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true

echo "Done."

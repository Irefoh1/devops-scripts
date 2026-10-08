# Beginner AWS & DevOps Bash Scripts

Setup: install the AWS CLI and run `aws configure`, then `chmod +x *.sh`.

| Script | Teaches |
|---|---|
| 01-check-aws-setup.sh | `command -v`, if/else, exit codes |
| 02-create-s3-bucket.sh | arguments, default values, S3 basics |
| 03-s3-backup.sh | timestamps, tar, uploading to S3 |
| 04-list-ec2.sh | AWS CLI `--query` and `--output` |
| 05-ec2-start-stop.sh | `case`, tag filters, cost saving |
| 06-health-check.sh | `curl`, status codes, loops |
| 07-disk-alert.sh | `df`, `awk`, thresholds, cron use |
| 08-simple-deploy.sh | `set -euo pipefail`, functions, systemctl |
| 09-log-cleanup.sh | `find`, dry-run safety pattern |

Tip for class: run scripts in a sandbox AWS account and delete resources afterwards to avoid charges.

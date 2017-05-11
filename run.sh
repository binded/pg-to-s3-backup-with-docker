#!/usr/bin/env sh
set -x
set -eo pipefail

backup_type="postgres"
s3_bucket_name=${S3_BUCKET_NAME:-"binded-backups"}

datestr=$(date +%Y-%m-%d)

# PGHOST
# PGPORT
# PGUSER

# TODO: streaming copy

pg_dumpall > /tmp/db.out

aws s3 cp /tmp/db.out "s3://${s3_bucket_name}/${backup_type}/pg-backup-${datestr}.dump"

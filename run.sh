#!/usr/bin/env sh
set -x
set -eo pipefail

databases=($DATABASES)

backup_type="postgres"
s3_bucket_name=${S3_BUCKET_NAME:-"binded-backups"}

datestr=$(date +%Y-%m-%d)

# PGHOST
# PGPORT
# PGUSER

# TODO: streaming copy
for db in "${databases[@]}"; do
  pg_dump -d "$db" >> /tmp/db.out
done


aws s3 cp /tmp/db.out "s3://${s3_bucket_name}/${backup_type}/pg-backup-${datestr}.dump"

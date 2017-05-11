#!/usr/bin/env bash
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
mkdir -p /tmp/backups/

for db in "${databases[@]}"; do
  pg_dump -d "$db" >> "/tmp/backups/${db}.out"
done

tar czf /tmp/dbs.tar.gz -C /tmp backups/

aws s3 cp /tmp/dbs.tar.gz "s3://${s3_bucket_name}/${backup_type}/pg-backup-${datestr}.tar.gz"

#!/bin/bash

set -eu

TMPDIR=/tmp/backups
mkdir -p ${TMPDIR}

b2 authorize-account ${B2_ACCOUNT_ID} ${B2_APPLICATION_KEY}

TIMESTAMP=$(date -u +"%Y%m%d%H%M%S")
TARGET=db_backup_${TIMESTAMP}.gz

mysqldump -A --opt --skip-lock-tables --skip-add-locks --single-transaction --routines -h ${DB_HOST} -u${DB_USER} -p${DB_PASSWORD} | gzip > "${TMPDIR}/${TARGET}"
  
b2 upload-file --noProgress "${B2_BUCKET}" "${TMPDIR}/${TARGET}" "${B2_TARGET_DIR}/${TARGET}" 

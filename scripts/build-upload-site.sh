#!/usr/bin/env bash
set -e

PROJECT_ID="gcp-mastery-495919"
BUCKET_NAME="gcp-mastery-495919-jjk-domain-site-artifacts"
ARTIFACT_PATH="../site-build.tar.gz"
SITE_OBJECT="site-builds/site-build.tar.gz"

echo "Setting GCP project..."
gcloud config set project "$PROJECT_ID"

echo "Checking for compressed site file..."
if [ ! -f "$ARTIFACT_PATH" ]; then
  echo "ERROR: site-build.tar.gz not found at $ARTIFACT_PATH"
  echo "Expected location: root folder beside scripts/"
  exit 1
fi

echo "Checking file size..."
FILE_SIZE_MB=$(du -m "$ARTIFACT_PATH" | cut -f1)

echo "File size: ${FILE_SIZE_MB}MB"

if [ "$FILE_SIZE_MB" -gt 1000 ]; then
  echo "ERROR: site-build.tar.gz is larger than 1000MB."
  echo "GitHub normal file limit is 1000MB."
  exit 1
fi

echo "Creating bucket if it does not exist..."
if ! gcloud storage buckets describe "gs://$BUCKET_NAME" >/dev/null 2>&1; then
  gcloud storage buckets create "gs://$BUCKET_NAME" \
    --location="US" \
    --uniform-bucket-level-access
fi

echo "Uploading compressed site to GCS..."
gcloud storage cp "$ARTIFACT_PATH" "gs://$BUCKET_NAME/$SITE_OBJECT"

echo "Done."
echo "Uploaded to: gs://$BUCKET_NAME/$SITE_OBJECT"
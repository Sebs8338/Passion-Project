#!/usr/bin/env bash
set -e

PROJECT_ID="gcp-mastery-495919"
BUCKET_NAME="gcp-mastery-495919-jjk-domain-site-artifacts"

echo "Setting GCP project..."
gcloud config set project "$PROJECT_ID"

echo "Checking if bucket exists..."
if ! gcloud storage buckets describe "gs://$BUCKET_NAME" >/dev/null 2>&1; then
  echo "Bucket does not exist: gs://$BUCKET_NAME"
  echo "Nothing to delete."
  exit 0
fi

echo "WARNING: This will delete the bucket and everything inside it:"
echo "gs://$BUCKET_NAME"
echo ""

# read -p "Type DELETE to continue: " CONFIRM

# if [ "$CONFIRM" != "DELETE" ]; then
#   echo "Cancelled."
#   exit 1
# fi

echo "Deleting all files inside the bucket..."
gcloud storage rm -r "gs://$BUCKET_NAME/**" || true

echo "Deleting bucket..."
gcloud storage buckets delete "gs://$BUCKET_NAME" --quiet

echo "Done. Bucket destroyed:"
echo "gs://$BUCKET_NAME"
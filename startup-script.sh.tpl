#!/bin/bash
set -e

# Values passed from Terraform
SITE_BUCKET="${site_bucket}"
SITE_OBJECT="${site_object}"
DEFAULT_CHARACTER="${default_character}"
SITE_TITLE="${site_title}"
APP_ROOT="${app_root}"

# Basic setup
apt-get update -y
apt-get install -y nginx curl tar

mkdir -p "$APP_ROOT"
mkdir -p /tmp/jjk-site

# GCP metadata settings
METADATA_URL="http://metadata.google.internal/computeMetadata/v1"
HEADER="Metadata-Flavor: Google"

# Get basic VM metadata
INSTANCE_NAME=$(curl -s -H "$HEADER" "$METADATA_URL/instance/name")
INSTANCE_ID=$(curl -s -H "$HEADER" "$METADATA_URL/instance/id")
PROJECT_ID=$(curl -s -H "$HEADER" "$METADATA_URL/project/project-id")
ZONE_FULL=$(curl -s -H "$HEADER" "$METADATA_URL/instance/zone")
MACHINE_TYPE_FULL=$(curl -s -H "$HEADER" "$METADATA_URL/instance/machine-type")
INTERNAL_IP=$(curl -s -H "$HEADER" "$METADATA_URL/instance/network-interfaces/0/ip")

ZONE=$(basename "$ZONE_FULL")
REGION=$(echo "$ZONE" | sed 's/-[a-z]$//')
MACHINE_TYPE=$(basename "$MACHINE_TYPE_FULL")
DEPLOYED_AT=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Get access token from the VM service account
TOKEN_JSON=$(curl -s -H "$HEADER" "$METADATA_URL/instance/service-accounts/default/token")
ACCESS_TOKEN=$(echo "$TOKEN_JSON" | sed -n 's/.*"access_token": *"\([^"]*\)".*/\1/p')

# Download the React artifact from GCS
curl -fL \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  "https://storage.googleapis.com/$SITE_BUCKET/$SITE_OBJECT" \
  -o /tmp/site-build.tar.gz

# Extract the site
rm -rf /tmp/jjk-site/*
tar -xzf /tmp/site-build.tar.gz -C /tmp/jjk-site

# Copy dist/ contents to Nginx web root
rm -rf "$APP_ROOT"/*

if [ -d "/tmp/jjk-site/dist" ]; then
  cp -R /tmp/jjk-site/dist/* "$APP_ROOT"/
else
  cp -R /tmp/jjk-site/* "$APP_ROOT"/
fi

# Create React runtime config
cat > "$APP_ROOT/site-config.json" <<EOF
{
  "defaultCharacter": "$DEFAULT_CHARACTER",
  "siteTitle": "$SITE_TITLE",
  "deploymentMode": "GCP Compute Engine Runtime",
  "configuredBy": "Terraform startup script"
}
EOF

# Create server metadata file
cat > "$APP_ROOT/server-metadata.json" <<EOF
{
  "Platform": "Google Cloud Platform",
  "Service": "Compute Engine VM",
  "ProjectId": "$PROJECT_ID",
  "InstanceName": "$INSTANCE_NAME",
  "InstanceId": "$INSTANCE_ID",
  "MachineType": "$MACHINE_TYPE",
  "Region": "$REGION",
  "Zone": "$ZONE",
  "InternalIP": "$INTERNAL_IP",
  "WebServer": "Nginx",
  "BuildType": "React Static Build",
  "ArtifactBucket": "$SITE_BUCKET",
  "ArtifactObject": "$SITE_OBJECT",
  "DefaultCharacter": "$DEFAULT_CHARACTER",
  "DeployedAt": "$DEPLOYED_AT"
}
EOF

# Configure Nginx
cat > /etc/nginx/sites-available/jjk-domain-sites <<'NGINX'
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    server_name _;

    root /var/www/jjk-domain-sites;
    index index.html;

    # Root runtime files
    location = /site-config.json {
        add_header Cache-Control "no-store";
        try_files /site-config.json =404;
    }

    location = /server-metadata.json {
        add_header Cache-Control "no-store";
        try_files /server-metadata.json =404;
    }

    # Runtime files through character paths
    location ~ ^/(gojo|sukuna|yuta|higuruma)/(site-config\.json|server-metadata\.json)$ {
        rewrite ^/(gojo|sukuna|yuta|higuruma)/(.*)$ /$2 break;
        add_header Cache-Control "no-store";
        try_files /$2 =404;
    }

    # Static files through character paths
    location ~ ^/(gojo|sukuna|yuta|higuruma)/(assets|images|videos)/(.*)$ {
        rewrite ^/(gojo|sukuna|yuta|higuruma)/(assets|images|videos)/(.*)$ /$2/$3 break;
        try_files $uri =404;
    }

    # Root static files
    location /assets/ {
        try_files $uri =404;
    }

    location /images/ {
        try_files $uri =404;
    }

    location /videos/ {
        try_files $uri =404;
    }

    # Character paths load React
    location ~ ^/(gojo|sukuna|yuta|higuruma)(/.*)?$ {
        try_files /index.html =404;
    }

    # Default React route
    location / {
        try_files $uri $uri/ /index.html;
    }
}
NGINX

# Enable site
ln -sf /etc/nginx/sites-available/jjk-domain-sites /etc/nginx/sites-enabled/jjk-domain-sites
rm -f /etc/nginx/sites-enabled/default

# Permissions
chown -R www-data:www-data "$APP_ROOT"
chmod -R 755 "$APP_ROOT"

# Start Nginx
nginx -t
systemctl enable nginx
systemctl restart nginx
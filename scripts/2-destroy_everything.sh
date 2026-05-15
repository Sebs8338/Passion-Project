echo "Moving to the root directory to run terraform destroy..."
cd ..
echo "Initializing Terraform..."
terraform init
echo "Destroying all resources with Terraform..."
terraform destroy -auto-approve
echo "Moving to the scripts directory to run artifact bucket destroy script..."
cd scripts
chmod +x destroy-artifact-bucket.sh
echo "Running destroy-artifact-bucket.sh to delete the GCS bucket with site artifacts..."
./destroy-artifact-bucket.sh

echo "All resources have been destroyed."
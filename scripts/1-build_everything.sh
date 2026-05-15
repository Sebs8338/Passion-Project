echo "Building and uploading site artifacts..."
chmod +x build-upload-site.sh
echo "Running build-upload-site.sh to build and upload site artifacts..."
./build-upload-site.sh
echo "Moving to the root directory to run terraform commands..."
cd ..
echo "Downloading the necessary Terraform providers and terraform modules..."
terraform init
echo "Validating terraform syntax..."
terraform validate
echo "Terraform configuration is valid."
terraform plan -out=tfplan
echo "Applying Terraform plan..."
terraform apply -auto-approve tfplan

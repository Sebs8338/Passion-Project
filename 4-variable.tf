variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
  default     = "gcp-mastery-495919"
}

variable "site_bucket_name" {
  description = "GCS bucket that stores the React build artifact"
  type        = string
  default     = "gcp-mastery-495919-jjk-domain-site-artifacts"
}

variable "region" {
  description = "The Google Cloud region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Default Google Cloud zone"
  type        = string
  default     = "us-central1-a"
}

variable "bucket_location" {
  description = "GCS bucket location"
  type        = string
  default     = "US"
}



variable "site_object" {
  description = "GCS object path for the React build artifact"
  type        = string
  default     = "site-builds/site-build.tar.gz"
}

variable "site_title" {
  description = "Runtime site title shown on the loading page"
  type        = string
  default     = "JJK Runtime Domain System"
}

variable "app_root" {
  description = "Nginx web root for the React site"
  type        = string
  default     = "/var/www/jjk-domain-sites"
}

variable "network_name" {
  description = "VPC network name"
  type        = string
  default     = "jjk-domain-vpc"
}

variable "public_subnet_1_cidr" {
  description = "CIDR for public subnet 1"
  type        = string
  default     = "10.10.0.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR for public subnet 2"
  type        = string
  default     = "10.10.1.0/24"
}

variable "private_subnet_1_cidr" {
  description = "CIDR for private subnet 1"
  type        = string
  default     = "10.10.10.0/24"
}

variable "private_subnet_2_cidr" {
  description = "CIDR for private subnet 2"
  type        = string
  default     = "10.10.20.0/24"
}

variable "machine_type" {
  description = "Compute Engine machine type"
  type        = string
  default     = "e2-micro"
}

variable "boot_disk_size_gb" {
  description = "Boot disk size for web servers"
  type        = number
  default     = 20
}

variable "gojo_zone" {
  type    = string
  default = "us-central1-a"
}

variable "sukuna_zone" {
  type    = string
  default = "us-central1-b"
}

variable "yuta_zone" {
  type    = string
  default = "us-central1-c"
}

variable "higuruma_zone" {
  type    = string
  default = "us-central1-f"
}
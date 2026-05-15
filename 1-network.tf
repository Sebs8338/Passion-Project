terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.31.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}
# VPC

resource "google_compute_network" "main" {
  name                    = var.network_name
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"

  description = "Custom VPC for JJK domain sites"
}

# Subnets

resource "google_compute_subnetwork" "public_1" {
  name          = "${var.network_name}-public-1"
  ip_cidr_range = var.public_subnet_1_cidr
  region        = var.region
  network       = google_compute_network.main.id

  private_ip_google_access = true
}

resource "google_compute_subnetwork" "public_2" {
  name          = "${var.network_name}-public-2"
  ip_cidr_range = var.public_subnet_2_cidr
  region        = var.region
  network       = google_compute_network.main.id

  private_ip_google_access = true
}

resource "google_compute_subnetwork" "private_1" {
  name          = "${var.network_name}-private-1"
  ip_cidr_range = var.private_subnet_1_cidr
  region        = var.region
  network       = google_compute_network.main.id

  private_ip_google_access = true
}

resource "google_compute_subnetwork" "private_2" {
  name          = "${var.network_name}-private-2"
  ip_cidr_range = var.private_subnet_2_cidr
  region        = var.region
  network       = google_compute_network.main.id

  private_ip_google_access = true
}

# Cloud Router + Cloud NAT for private VM outbound internet

resource "google_compute_router" "nat_router" {
  name    = "${var.network_name}-router"
  region  = var.region
  network = google_compute_network.main.id
}

resource "google_compute_router_nat" "nat" {
  name   = "${var.network_name}-nat"
  router = google_compute_router.nat_router.name
  region = var.region

  nat_ip_allocate_option = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.private_1.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  subnetwork {
    name                    = google_compute_subnetwork.private_2.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
# Datablock to pull the bucket details for the service account permissions
data "google_storage_bucket" "site_artifacts" {
  name = var.site_bucket_name
}

# Service account for private web VMs

resource "google_service_account" "web" {
  account_id   = "jjk-domain-web-sa"
  display_name = "JJK Domain Web Server Service Account"
}

resource "google_storage_bucket_iam_member" "site_artifacts_viewer" {
  bucket = data.google_storage_bucket.site_artifacts.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.web.email}"
}

# Firewall rules

resource "google_compute_firewall" "allow_lb_to_web" {
  name    = "${var.network_name}-allow-lb-to-web"
  network = google_compute_network.main.name

  description = "Allow Google Load Balancer and health checks to reach web servers"

  direction = "INGRESS"

  source_ranges = [
    "35.191.0.0/16",
    "130.211.0.0/22"
  ]

  target_tags = ["jjk-web"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}

resource "google_compute_firewall" "allow_iap_ssh" {
  name    = "${var.network_name}-allow-iap-ssh"
  network = google_compute_network.main.name

  description = "Allow SSH through Identity-Aware Proxy"

  direction = "INGRESS"

  source_ranges = [
    "35.235.240.0/20"
  ]

  target_tags = ["jjk-web"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "allow_internal" {
  name    = "${var.network_name}-allow-internal"
  network = google_compute_network.main.name

  description = "Allow internal traffic inside the VPC"

  direction = "INGRESS"

  source_ranges = [
    var.public_subnet_1_cidr,
    var.public_subnet_2_cidr,
    var.private_subnet_1_cidr,
    var.private_subnet_2_cidr
  ]

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  allow {
    protocol = "icmp"
  }
}

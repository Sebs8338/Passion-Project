# Ubuntu image

data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2204-lts"
  project = "ubuntu-os-cloud"
}

# 4 explicit private instances
# The Gojo Server
resource "google_compute_instance" "gojo" {
  name         = "jjk-gojo-web"
  machine_type = var.machine_type
  zone         = var.gojo_zone
  tags         = ["jjk-web"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size  = var.boot_disk_size_gb
      type  = "pd-balanced"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.private_1.self_link
  }

  metadata_startup_script = templatefile("${path.module}/startup-script.sh.tpl", {
    site_bucket       = data.google_storage_bucket.site_artifacts.name
    site_object       = var.site_object
    default_character = "gojo"
    site_title        = var.site_title
    app_root          = var.app_root
  })

  service_account {
    email  = google_service_account.web.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  depends_on = [
    google_storage_bucket_iam_member.site_artifacts_viewer,
    google_compute_router_nat.nat
  ]
}
# The Sukuna Server
resource "google_compute_instance" "sukuna" {
  name         = "jjk-sukuna-web"
  machine_type = var.machine_type
  zone         = var.sukuna_zone
  tags         = ["jjk-web"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size  = var.boot_disk_size_gb
      type  = "pd-balanced"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.private_1.self_link
  }

  metadata_startup_script = templatefile("${path.module}/startup-script.sh.tpl", {
    site_bucket       = data.google_storage_bucket.site_artifacts.name
    site_object       = var.site_object
    default_character = "sukuna"
    site_title        = var.site_title
    app_root          = var.app_root
  })

  service_account {
    email  = google_service_account.web.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  depends_on = [
    google_storage_bucket_iam_member.site_artifacts_viewer,
    google_compute_router_nat.nat
  ]
}
# Yuta's Server
resource "google_compute_instance" "yuta" {
  name         = "jjk-yuta-web"
  machine_type = var.machine_type
  zone         = var.yuta_zone
  tags         = ["jjk-web"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size  = var.boot_disk_size_gb
      type  = "pd-balanced"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.private_2.self_link
  }

  metadata_startup_script = templatefile("${path.module}/startup-script.sh.tpl", {
    site_bucket       = data.google_storage_bucket.site_artifacts.name
    site_object       = var.site_object
    default_character = "yuta"
    site_title        = var.site_title
    app_root          = var.app_root
  })

  service_account {
    email  = google_service_account.web.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  depends_on = [
    google_storage_bucket_iam_member.site_artifacts_viewer,
    google_compute_router_nat.nat
  ]
}
# Higuruma's Server
resource "google_compute_instance" "higuruma" {
  name         = "jjk-higuruma-web"
  machine_type = var.machine_type
  zone         = var.higuruma_zone
  tags         = ["jjk-web"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size  = var.boot_disk_size_gb
      type  = "pd-balanced"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.private_2.self_link
  }

  metadata_startup_script = templatefile("${path.module}/startup-script.sh.tpl", {
    site_bucket       = data.google_storage_bucket.site_artifacts.name
    site_object       = var.site_object
    default_character = "higuruma"
    site_title        = var.site_title
    app_root          = var.app_root
  })

  service_account {
    email  = google_service_account.web.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  depends_on = [
    google_storage_bucket_iam_member.site_artifacts_viewer,
    google_compute_router_nat.nat
  ]
}
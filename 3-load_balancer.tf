# Health check
# Essentially a healthcheck function that is used by a backend service
resource "google_compute_health_check" "web" {
  name = "jjk-domain-web-health-check"

  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3

  http_health_check {
    port         = 80
    request_path = "/"
  }
}

# One unmanaged instance group per VM.
# Backend services attach to instance groups, not raw VM instances.
# Attaches Gojo's server as a backend
resource "google_compute_instance_group" "gojo" {
  name = "jjk-gojo-instance-group"
  zone = var.gojo_zone

  instances = [
    google_compute_instance.gojo.self_link
  ]

  named_port {
    name = "http"
    port = 80
  }
}
# Attaches Sukuna's server as a backend
resource "google_compute_instance_group" "sukuna" {
  name = "jjk-sukuna-instance-group"
  zone = var.sukuna_zone

  instances = [
    google_compute_instance.sukuna.self_link
  ]

  named_port {
    name = "http"
    port = 80
  }
}
# Attaches Yuta's server as a backend
resource "google_compute_instance_group" "yuta" {
  name = "jjk-yuta-instance-group"
  zone = var.yuta_zone

  instances = [
    google_compute_instance.yuta.self_link
  ]

  named_port {
    name = "http"
    port = 80
  }
}
# Attaches Higuruma's server as a backend
resource "google_compute_instance_group" "higuruma" {
  name = "jjk-higuruma-instance-group"
  zone = var.higuruma_zone

  instances = [
    google_compute_instance.higuruma.self_link
  ]

  named_port {
    name = "http"
    port = 80
  }
}

# One backend service per character
# Attaches Gojo's, Sukuna's, Yuta's, and Higuruma's instance groups as backends
resource "google_compute_backend_service" "all_characters" {
  name        = "jjk-all-characters-backend"
  protocol    = "HTTP"
  port_name   = "http"
  timeout_sec = 30

  health_checks = [
    google_compute_health_check.web.self_link
  ]

  backend {
    group           = google_compute_instance_group.gojo.self_link
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }

  backend {
    group           = google_compute_instance_group.sukuna.self_link
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }

  backend {
    group           = google_compute_instance_group.yuta.self_link
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }

  backend {
    group           = google_compute_instance_group.higuruma.self_link
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

# Global HTTP Load Balancer
# This is the IP the load Balancer uses, it is a lot more lower level than AWS
resource "google_compute_global_address" "web" {
  name = "jjk-domain-web-lb-ip"
}
# This is the routing engine of the load balancer, this is very low level.
# This now gives it the route robin logic so user refresh goes to a random backend
resource "google_compute_url_map" "web" {
  name = "jjk-domain-web-url-map"

  default_service = google_compute_backend_service.all_characters.self_link
}
# This is a forwarding rule that forwards traffic from the LB IP to the URL Map
resource "google_compute_target_http_proxy" "web" {
  name    = "jjk-domain-web-http-proxy"
  url_map = google_compute_url_map.web.self_link
}
# This is a forwarding rule that forwards traffic from the internet to the http proxy
resource "google_compute_global_forwarding_rule" "web" {
  name       = "jjk-domain-web-http-forwarding-rule"
  ip_address = google_compute_global_address.web.address
  port_range = "80"
  target     = google_compute_target_http_proxy.web.self_link
}
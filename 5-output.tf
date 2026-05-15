
output "load_balancer_ip" {
  value = google_compute_global_address.web.address
}

output "site_url" {
  value = "http://${google_compute_global_address.web.address}"
}

output "instances" {
  value = {
    gojo = {
      name = google_compute_instance.gojo.name
      zone = google_compute_instance.gojo.zone
    }

    sukuna = {
      name = google_compute_instance.sukuna.name
      zone = google_compute_instance.sukuna.zone
    }

    yuta = {
      name = google_compute_instance.yuta.name
      zone = google_compute_instance.yuta.zone
    }

    higuruma = {
      name = google_compute_instance.higuruma.name
      zone = google_compute_instance.higuruma.zone
    }
  }
}


output "metadata_test_commands" {
  value = {
    gojo     = "curl http://${google_compute_global_address.web.address}/gojo/server-metadata.json"
    sukuna   = "curl http://${google_compute_global_address.web.address}/sukuna/server-metadata.json"
    yuta     = "curl http://${google_compute_global_address.web.address}/yuta/server-metadata.json"
    higuruma = "curl http://${google_compute_global_address.web.address}/higuruma/server-metadata.json"
  }
}
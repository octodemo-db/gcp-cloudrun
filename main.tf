terraform {
  required_providers {
    google = ">=3.32"
  }
}


data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers"
    ]
  }
}


resource "google_cloud_run_service" "app" {
  name                  = var.gcp_application_name
  location              = var.gcp_region
  project               = var.gcp_project  

  template {
    spec {
      containers {
        image = "${var.gcr_hostname}/${var.gcp_project}/${var.gcr_image}:${var.gcr_image_tag}"
        ports {
          container_port = var.container_port
        }
      }
    }
  }

  traffic {
    percent             = 100
    latest_revision     = true
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location              = google_cloud_run_service.app.location
  project               = google_cloud_run_service.app.project
  service               = google_cloud_run_service.app.name
  policy_data           = data.google_iam_policy.noauth.policy_data
}


output "url" {
  value = "${google_cloud_run_service.app.status[0].url}"
}
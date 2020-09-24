variable "gcp_project" {
    type                = string
    description         = "The GCP Project"
}

variable "gcp_region" {
    type                = string
    description         = "The GCP region to deploy the application to"
    default             = "europe-west1"

    validation {
        condition       = contains(["europe-west1", "us-central1"], var.gcp_region)
        error_message   = "The GCP Region for Cloud Run must be one of the approved choices."
    }
}

variable "gcp_application_name" {
    type                = string
    description         = "The GCP Application Name"
}


variable "gcr_hostname" {
    type                = string
    description         = "The GCR hostname"
    default             = "eu.gcr.io"

    validation {
        condition       = contains(["eu.gcr.io", "gcr.io", "us.gcr.io"], var.gcr_hostname)
        error_message   = "The GCR hostname must be one of the approved choices."
    }
}

variable "gcr_image" {
    type                = string
    description         = "The GCR container image name"
}

variable "gcr_image_tag" {
    type                = string
    description         = "The GCR container image tag to deploy"
}
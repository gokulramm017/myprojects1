terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# --------------------------------------------------
# 500 GB Application / Data Disk
# --------------------------------------------------

resource "google_compute_disk" "data_disk" {
  name = "${var.vm_name}-data-disk"

  type = "pd-standard"
  zone = var.zone
  size = 500

  labels = {
    environment = var.environment
    purpose     = "application-data"
  }
}

# --------------------------------------------------
# Compute Engine VM
# --------------------------------------------------

resource "google_compute_instance" "server" {

  name         = var.vm_name
  machine_type = "e2-standard-8"
  zone         = var.zone

  allow_stopping_for_update = true

  # ------------------------------------------------
  # 100 GB Boot Disk
  # ------------------------------------------------

  boot_disk {
    auto_delete = true

    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"

      size = 100
      type = "pd-standard"
    }
  }

  # ------------------------------------------------
  # 500 GB Application / Data Disk
  # ------------------------------------------------

  attached_disk {
    source      = google_compute_disk.data_disk.id
    device_name = "data-disk"
    mode        = "READ_WRITE"
  }

  # ------------------------------------------------
  # Network
  # ------------------------------------------------

  network_interface {
    network = "default"

    access_config {
      # Ephemeral public IP
    }
  }

  # ------------------------------------------------
  # Labels
  # ------------------------------------------------

  labels = {
    environment = var.environment
    managed_by  = "terraform"
    role        = "application-server"
  }

  # ------------------------------------------------
  # Startup script
  # ------------------------------------------------

  metadata_startup_script = <<-EOF
    #!/bin/bash

    # Update packages
    apt-get update -y

    # Install basic tools
    apt-get install -y \
      curl \
      wget \
      vim \
      git \
      unzip \
      htop

  EOF
}

provider "google" {
  project = "gen-lang-client-0006306294"
  region  = "us-central1"
}

resource "google_compute_instance" "vm_example" {
  count        = var.instance_count
  name         = "quota-vm-${count.index}"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
  }
}

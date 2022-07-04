terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.76.0"
    }
  }
}

provider "yandex" {
  token                    = "auth_token_here"
  cloud_id                 = "b1geif0o8r531j9g9i4f"
  folder_id                = "b1gltdfspvplkhv2p5i0"
  zone                     = "ru-central1-b"
}

resource "yandex_compute_instance" "default" {
  name        = "test-tf"
  platform_id = "standard-v3"
  zone        = "ru-central1-b"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd81u2vhv3mc49l1ccbb"
      size = "20"
      type = "network-hdd"
    }
  }
  network_interface {
    subnet_id = "e2l2fg70r4ua54jffrbf"
  }

    metadata = {
    ssh-keys = "avasekho:${file("/home/avasekho/yandex_rsa.pub")}"
    serial-port-enable = 1
    user-data = file("cloud_config.yaml")
    }

  scheduling_policy {
    preemptible = true
  }

}
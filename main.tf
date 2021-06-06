terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "docker" {}

resource "docker_image" "air" {
  name         = "psychlist/docker-airconnect-arm:latest"
  keep_locally = false
}

resource "docker_container" "airsonos" {
  image = docker_image.air.latest
  name  = "airconnect"
  network_mode = "host"
  restart = "unless-stopped"
  env = ["SUPPRESS_FLUSH=TRUE", "INCLUDE_AIRCAST=TRUE"]
}


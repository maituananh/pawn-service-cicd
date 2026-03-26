terraform {
  required_version = ">= 0.13"

  required_providers {
    dockerhub = {
      source  = "BarnabyShearer/dockerhub"
      version = ">= 0.0.15"
    }
  }
}

resource "dockerhub_repository" "pawn-service-be" {
  name        = var.DOCKER_BACKEND_REPO_NAME
  namespace   = var.DOCKER_USERNAME
  description = "Pawn Service Backend"
}

resource "dockerhub_repository" "pawn-service-fe" {
  name        = var.DOCKER_FRONTEND_REPO_NAME
  namespace   = var.DOCKER_USERNAME 
  description = "Pawn Service Frontend"
}

terraform {
  required_version = ">= 1.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    stripe = {
      source  = "stripe/stripe"
      version = "~> 0.2.0"
    }
    dockerhub = {
      source  = "BarnabyShearer/dockerhub"
      version = ">= 0.0.15"
    }
  }
}

provider "cloudflare" {
  api_token = var.CLOUDFLARE_API_TOKEN
}

provider "github" {
  token = var.GITHUB_TOKEN
}

provider "stripe" {
  api_key = var.STRIPE_SECRET_KEY
}

provider "dockerhub" {
  username = var.DOCKER_USERNAME
  password = var.DOCKER_PASSWORD
}

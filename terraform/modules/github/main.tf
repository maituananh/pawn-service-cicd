terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

# SETUP FOR FRONTEND REPOSITORY
resource "github_repository_webhook" "pawn-service-fe" {
  repository = var.FRONTEND_REPO_NAME

  configuration {
    url          = var.FRONTEND_WEBHOOK_PAYLOAD_URL
    content_type = "json"
    insecure_ssl = false
  }

  active = false

  events = ["pull_request"]
}

# SETUP FOR BACKEND REPOSITORY
resource "github_repository_webhook" "pawn-service-be" {
  repository = var.BACKEND_REPO_NAME

  configuration {
    url          = var.BACKEND_WEBHOOK_PAYLOAD_URL
    content_type = "json"
    insecure_ssl = false
  }

  active = false

  events = ["pull_request"]
}

# SETUP FOR CICD REPOSITORY
resource "github_repository_webhook" "pawn-service-cicd-fe" {
  repository = var.CICD_REPO_NAME

  configuration {
    url          = var.FRONTEND_WEBHOOK_PAYLOAD_URL
    content_type = "json"
    insecure_ssl = false
  }

  active = false

  events = ["pull_request"]
}

resource "github_repository_webhook" "pawn-service-cicd-be" {
  repository = var.CICD_REPO_NAME

  configuration {
    url          = var.BACKEND_WEBHOOK_PAYLOAD_URL
    content_type = "json"
    insecure_ssl = false
  }

  active = false

  events = ["pull_request"]
}

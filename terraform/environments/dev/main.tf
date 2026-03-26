module "cloudflare" {
  source = "../../modules/cloudflare"

  DOMAIN               = var.DOMAIN
  CLOUDFLARE_API_TOKEN = var.CLOUDFLARE_API_TOKEN
  ZONE_ID              = var.ZONE_ID
  ACCOUNT_ID           = var.ACCOUNT_ID
}

module "github" {
  source = "../../modules/github"

  CICD_REPO_NAME               = var.CICD_REPO_NAME
  FRONTEND_REPO_NAME           = var.FRONTEND_REPO_NAME
  BACKEND_REPO_NAME            = var.BACKEND_REPO_NAME
  GITHUB_TOKEN                 = var.GITHUB_TOKEN
  FRONTEND_WEBHOOK_PAYLOAD_URL = var.FRONTEND_WEBHOOK_PAYLOAD_URL
  BACKEND_WEBHOOK_PAYLOAD_URL  = var.BACKEND_WEBHOOK_PAYLOAD_URL
}

module "stripe" {
  source = "../../modules/stripe"

  STRIPE_SECRET_KEY          = var.STRIPE_SECRET_KEY
  STRIPE_WEBHOOK_BACKEND_URL = var.STRIPE_WEBHOOK_BACKEND_URL
}

module "dockerhub" {
  source = "../../modules/dockerhub"

  DOCKER_PASSWORD           = var.DOCKER_PASSWORD
  DOCKER_USERNAME           = var.DOCKER_USERNAME
  DOCKER_FRONTEND_REPO_NAME = var.DOCKER_FRONTEND_REPO_NAME
  DOCKER_BACKEND_REPO_NAME  = var.DOCKER_BACKEND_REPO_NAME
}

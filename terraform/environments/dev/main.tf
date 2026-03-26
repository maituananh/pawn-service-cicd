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

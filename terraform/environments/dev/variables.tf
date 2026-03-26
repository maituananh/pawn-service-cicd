// Cloudflare
variable "DOMAIN" {}
variable "CLOUDFLARE_API_TOKEN" {}
variable "ZONE_ID" {}
variable "ACCOUNT_ID" {}

// GitHub
variable "GITHUB_TOKEN" {}
variable "CICD_REPO_NAME" {}
variable "FRONTEND_REPO_NAME" {}
variable "BACKEND_REPO_NAME" {}
variable "FRONTEND_WEBHOOK_PAYLOAD_URL" {}
variable "BACKEND_WEBHOOK_PAYLOAD_URL" {}

// Stripe
variable "STRIPE_SECRET_KEY" {}
variable "STRIPE_WEBHOOK_BACKEND_URL" {}

// Docker
variable "DOCKER_USERNAME" {}
variable "DOCKER_PASSWORD" {}
variable "DOCKER_FRONTEND_REPO_NAME" {}
variable "DOCKER_BACKEND_REPO_NAME" {}

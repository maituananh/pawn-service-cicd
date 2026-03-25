module "cloudflare" {
  source = "./modules/cloudflare"

  account_id    = var.account_id
  tunnel_secret = var.tunnel_secret
}
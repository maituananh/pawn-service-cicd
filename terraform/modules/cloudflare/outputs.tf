output "tunnel_token" {
  value = base64encode(jsonencode({
    "a" = var.ACCOUNT_ID,
    "t" = cloudflare_zero_trust_tunnel_cloudflared.app.id,
    "s" = base64encode(random_password.tunnel_secret.result)
  }))
  sensitive = true
}
# terraform output tunnel_token

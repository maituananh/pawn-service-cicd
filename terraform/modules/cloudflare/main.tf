terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
  }
}

resource "random_password" "tunnel_secret" {
  length  = 32
  special = false
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "app" {
  account_id    = var.ACCOUNT_ID
  name          = "pawn-service"
  tunnel_secret = base64encode(random_password.tunnel_secret.result)
}

resource "cloudflare_dns_record" "root" {
  zone_id = var.ZONE_ID
  name    = var.DOMAIN
  type    = "CNAME"
  proxied = true
  ttl     = 1
  content = "${cloudflare_zero_trust_tunnel_cloudflared.app.id}.cfargotunnel.com"
}

resource "cloudflare_dns_record" "api" {
  zone_id = var.ZONE_ID
  name    = "api"
  type    = "CNAME"
  proxied = true
  ttl     = 1
  content = "${cloudflare_zero_trust_tunnel_cloudflared.app.id}.cfargotunnel.com"
}

resource "cloudflare_dns_record" "minio-ui" {
  zone_id = var.ZONE_ID
  name    = "minio-ui"
  type    = "CNAME"
  proxied = true
  ttl     = 1
  content = "${cloudflare_zero_trust_tunnel_cloudflared.app.id}.cfargotunnel.com"
}

resource "cloudflare_dns_record" "minio" {
  zone_id = var.ZONE_ID
  name    = "minio"
  type    = "CNAME"
  proxied = true
  ttl     = 1
  content = "${cloudflare_zero_trust_tunnel_cloudflared.app.id}.cfargotunnel.com"
}

resource "cloudflare_dns_record" "grafana" {
  zone_id = var.ZONE_ID
  name    = "grafana"
  type    = "CNAME"
  proxied = true
  ttl     = 1
  content = "${cloudflare_zero_trust_tunnel_cloudflared.app.id}.cfargotunnel.com"
}

resource "cloudflare_dns_record" "jenkins" {
  zone_id = var.ZONE_ID
  name    = "jenkins"
  type    = "CNAME"
  proxied = true
  ttl     = 1
  content = "${cloudflare_zero_trust_tunnel_cloudflared.app.id}.cfargotunnel.com"
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "app" {
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.app.id
  account_id = var.ACCOUNT_ID

  config = {
    ingress = [
      {
        hostname = "${var.DOMAIN}"
        service  = "http://localhost:80"
      },
      {
        hostname = "api.${var.DOMAIN}"
        service  = "http://localhost:80"
      },
      {
        hostname = "minio-ui.${var.DOMAIN}"
        service  = "http://localhost:80"
      },
      {
        hostname = "minio.${var.DOMAIN}"
        service  = "http://localhost:80"
      },
      {
        hostname = "grafana.${var.DOMAIN}"
        service  = "http://localhost:80"
      },
      {
        hostname = "jenkins.${var.DOMAIN}"
        service  = "http://localhost:80"
      },
      {
        service = "http_status:404"
      }
    ]
  }
}

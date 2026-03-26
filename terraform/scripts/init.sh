#!/bin/bash
# Usage: ./scripts/init.sh dev
# Usage: ./scripts/init.sh prod

ENV=${1:-dev}
cd "$(dirname "$0")/../environments/$ENV"
terraform init --target=module.dockerhub
terraform plan --target=module.dockerhub
terraform apply --target=module.dockerhub

# echo "Cloudflare Tunnel Token"
# terraform output tunnel_token

# echo "Stripe Webhook Secret"
# terraform output stripe_webhook_secret

# cloudflared tunnel run pawn-service
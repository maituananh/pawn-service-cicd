#!/bin/bash
# Usage: ./scripts/init.sh dev
# Usage: ./scripts/init.sh prod

ENV=${1:-dev}
cd "$(dirname "$0")/../environments/$ENV"
terraform init
terraform apply

terraform output tunnel_token

# cloudflared tunnel run pawn-service
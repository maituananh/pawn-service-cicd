ENV=${1:-dev}
cd "$(dirname "$0")/../environments/$ENV"

terraform destroy
terraform {
  required_providers {
    stripe = {
      source  = "stripe/stripe"
      version = "~> 0.2.0"
    }
  }
}

resource "stripe_webhook_endpoint" "pawn-service" {
  enabled_events = [
    "checkout.session.completed",
    "checkout.session.expired",
    "payment_intent.payment_failed"
  ]
  url = var.STRIPE_WEBHOOK_BACKEND_URL
}

output "webhook_secret" {
  value = stripe_webhook_endpoint.pawn-service.secret
}

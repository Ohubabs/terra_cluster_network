resource "kubernetes_secret_v1" "aws-auth" {
  metadata {
    name = "aws-auth"
    namespace = "cert-manager"
  }

  data = {
    access-key-id = "AKIARHAJWM4CP6BV6EIF"
    secret-access-key = "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"
  }

  type = "Opaque"
}
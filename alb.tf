resource "helm_release" "alb" {
  name       = "alb"
  namespace  = "default"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"

  values = [
    "${file("alb-values.yml")}"
  ]

  set {
    name = "clusterName"
    value = "TEJE" 
  }
}

#module.load_balancer_controller_irsa_role.aws_iam_policy.load_balancer_controller.id create an output for this
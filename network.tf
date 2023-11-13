resource "helm_release" "nginx" {
  name       = "nginx-ingress"
  create_namespace = true
  namespace = "ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
}
#https://github.com/kubernetes/ingress-nginx/tree/main/charts/ingress-nginx
#https://aws.amazon.com/blogs/containers/exposing-kubernetes-applications-part-3-nginx-ingress-controller/

resource "helm_release" "external-dns" {
  name       = "external-dns"
  create_namespace = true
  namespace = "kube-system"
  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart      = "external-dns"

  values = [
    "${file("dns-values.yml")}"
  ]
}

#https://repost.aws/knowledge-center/eks-set-up-externaldns
#https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/aws.md#set-up-a-hosted-zone
#https://github.com/kubernetes-sigs/external-dns/blob/master/charts/external-dns/values.yaml

resource "helm_release" "cert-manager" {
  name       = "cert-manager"
  create_namespace = true
  namespace = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  set {
    name = "installCRDs"
    value = true
  }

  set {
    name = "serviceAccount.annotations.eks\\amazonaws\\.com\\/role-arn"
    value = "arn:aws:iam::083772204804:role/teje-cert-manager"
  }

}

#https://cert-manager.io/docs/configuration/acme/dns01/route53/
#https://cert-manager.io/docs/installation/helm/
#https://artifacthub.io/packages/helm/cert-manager/cert-manager


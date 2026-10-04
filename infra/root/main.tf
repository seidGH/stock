terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.11.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.32.0"
    }
  }
}

provider "kind" {}

provider "kubernetes" {
  host                   = yamldecode(module.kind_cluster.kubeconfig).clusters[0].cluster.server
  cluster_ca_certificate = base64decode(yamldecode(module.kind_cluster.kubeconfig).clusters[0].cluster["certificate-authority-data"])
  client_certificate     = base64decode(yamldecode(module.kind_cluster.kubeconfig).users[0].user["client-certificate-data"])
  client_key             = base64decode(yamldecode(module.kind_cluster.kubeconfig).users[0].user["client-key-data"])
}

module "kind_cluster" {
  source       = "../modules/kind_cluster"
  cluster_name = var.cluster_name
}

module "k8s_workloads" {
  source     = "../modules/k8s_workloads"
  namespace  = var.namespace
  depends_on = [module.kind_cluster]
}

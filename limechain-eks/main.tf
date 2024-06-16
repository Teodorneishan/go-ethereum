provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

resource "kubernetes_namespace" "test" {
  metadata {
    name = "limechain"
  }
}

resource "kubernetes_deployment" "test" {
  metadata {
    name      = "limechain-blockchain"
    namespace = kubernetes_namespace.test.metadata.0.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "limechain"
      }
    }
    template {
      metadata {
        labels = {
          app = "limechain"
        }
      }
      spec {
        container {
          image = "teodorneishan/limechain-task-teodor:latest"
          name  = "devnet"
          port {
            container_port = 30304
          }
          port {
            container_port = 8552
          }
          port {
            container_port = 8553
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "test" {
  metadata {
    name      = "limechain-svc"
    namespace = kubernetes_namespace.test.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.test.spec.0.template.0.metadata.0.labels.app
    }
    type = "LoadBalancer"
    port {
      port        = 30304
      target_port = 30304
    }
    port {
      port        = 8552
      target_port = 8552
    }
    port {
      port        = 8553
      target_port = 8553
    }
  }
}

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

locals {
  cluster_name = var.clusterName
}

resource "kubernetes_secret_v1" "credentials" {
  metadata {
    name = "docker-cfg"
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${var.registry_server}" = {
          "username" = var.registry_username
          "password" = var.registry_password
          "email"    = var.registry_email
          "auth"     = base64encode("${var.registry_username}:${var.registry_password}")
        }
      }
    })
  }
}

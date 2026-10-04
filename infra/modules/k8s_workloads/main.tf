terraform {

# PROVIDER
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.32.0"
    }
  }
}

# NAME-SPACE

resource "kubernetes_namespace" "stock_ns" {
  metadata {
    name = var.namespace
  }
}

variable "namespace" {
  type    = string
  default = "stock-production"
}

#FRONT-END  Deployment
resource "kubernetes_deployment" "frontend" {
  metadata {
    name      = "frontend"
    namespace = kubernetes_namespace.stock_ns.metadata[0].name
  }

  spec {
    replicas = 3

    selector {
      match_labels = { app = "frontend" }
    }

    template {
      metadata {
        labels = { app = "frontend" }
      }

      spec {
        container {
          image             = "stock-frontend:latest"
          image_pull_policy = "Never"
          name              = "frontend"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}


# BACK-END Deployment
resource "kubernetes_deployment" "backend" {
  metadata {
    name      = "backend"
    namespace = kubernetes_namespace.stock_ns.metadata[0].name
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend"
        }
      }

      spec {
        container {
          image             = "spare_server:latest"
          image_pull_policy = "Never"
          name              = "backend"

          port {
            container_port = 9000
          }

          # READINESS PROBE
            readiness_probe {
              http_get {
                path = "/ready"
                port = 9000
              }

              initial_delay_seconds = 10
              period_seconds        = 5
              timeout_seconds       = 2
              failure_threshold     = 3
              success_threshold     = 1
            }
          # LIVENESS PROBE
          liveness_probe {
            http_get {
              path = "/healthz"
              port = 9000
            }

            initial_delay_seconds = 10
            period_seconds        = 10
            timeout_seconds       = 2
            failure_threshold     = 3
            success_threshold     = 1
          }
        }
      }
    }
  }
}


# BACK-END SVC
resource "kubernetes_service" "backend_svc" {
  metadata {
    name      = "backend-svc"
    namespace = kubernetes_namespace.stock_ns.metadata[0].name
  }

  spec {
    selector = {
      app = "backend"
    }

    port {
      port        = 5000
      target_port = 9000
    }

    type = "ClusterIP"
  }
}

#FRONT-END SVC
resource "kubernetes_service" "frontend_svc" {
  metadata {
    name      = "frontend-svc"
    namespace = kubernetes_namespace.stock_ns.metadata[0].name
  }

  spec {
    selector = { app = "frontend" }

    port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}

# INGRESS
resource "kubernetes_ingress_v1" "stock_ingress" {
  metadata {
    name      = "stock-ingress"
    namespace = kubernetes_namespace.stock_ns.metadata[0].name
}
  spec {
    ingress_class_name = "nginx"

    rule {
      host = "stock.seya"

      http {

        # Backend
        path {
          path      = "/api"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.backend_svc.metadata[0].name

              port {
                number = 5000
              }
            }
          }
        }

        # Frontend
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.frontend_svc.metadata[0].name

              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

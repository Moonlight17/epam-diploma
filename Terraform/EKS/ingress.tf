provider "kubernetes" {
  config_path = "~/Desktop/epam-diploma/Terraform/EKS/.kube/eksconfig"
}

resource "kubernetes_ingress" "example_ingress" {
    metadata {
      name = "ingress"
    }
  
    spec {
      backend {
        service_name = "django"
        service_port = 8000
      }
    
      rule {
        http {
          path {
            backend {
              service_name = "django"
              service_port = 8000
            }
  
            path = "/*"
          }
        }
      }
  
      # tls {
      #   secret_name = "tls-secret"
      # }
    }
  }
  
  resource "kubernetes_service_v1" "example" {
    metadata {
      name = "django"
    }
    spec {
      selector = {
        app = kubernetes_deployment.example.metadata.0.labels.app
      }
      session_affinity = "ClientIP"
      port {
        port        = 8000
        target_port = 8000
      }
  
      type = "NodePort"
    }
  }
  
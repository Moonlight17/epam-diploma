resource "kubernetes_deployment" "example" {
  metadata {
    name = "diploma-app"
    labels = {
        app = "django"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "django"
      }
    }

    template {
      metadata {
        labels = {
          app = "django"
        }
      }

      spec {
        container {
          image = "moonlight234/epam_full:latest"
          name  = "django"

          resources {
            limits = {
              cpu    = "500m"
            }
            requests = {
              cpu    = "100m"
            }
          }

        #   liveness_probe {
        #     http_get {
        #       path = "/api/v1/healthz"
        #       port = 8000

        #       http_header {
        #         name  = "X-Custom-Header"
        #         value = "Awesome"
        #       }
        #     }

        #     initial_delay_seconds = 3
        #     period_seconds        = 3
        #   }
          env {
            name="DATABASE_HOST"
            value="postgres-diploma-rds.chao43ndm64b.eu-central-1.rds.amazonaws.com"
          }
          env {
            name="DB_PORT"
            value="5432"
          }
          env {
            name="POSTGRES_USER"
            value="postgres"
          }
          env {
            name="POSTGRES_PASSWORD"
            value="1q2w3e4r"
          }
          env {
            name="POSTGRES_NAME"
            value="postgres"
          }
        }
      }
    }
  }
}
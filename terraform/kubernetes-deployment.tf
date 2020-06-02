resource "kubernetes_deployment" "switch-uploader-deployment" {
  metadata {
    name = "switch-uploader-deployment"
    labels = {
      App = "switch-uploader"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 2
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "switch-uploader"
      }
    }
    template {
      metadata {
        labels = {
          App = "switch-uploader"
        }
      }
      spec {
        container {
          image = "luloromero19/switch-uploader:v0.01"
          name  = "switch-uploader"
          env {
            name  = "token"
            value = var.token_value
          }
          env {
            name  = "chat"
            value = var.chat_value
          }
          port {
            container_port = 8080
          }

          resources {
            limits {
              cpu    = "0.2"
              memory = "2562Mi"
            }
            requests {
              cpu    = "0.1"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
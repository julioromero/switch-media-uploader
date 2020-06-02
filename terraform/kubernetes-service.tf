resource "kubernetes_service" "switch-uploader-service" {
  metadata {
    name      = "switch-uploader-service"
    namespace = kubernetes_namespace.n.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.switch-uploader-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 8080
    }
    type = "LoadBalancer"
  }
}

output "lb_ip" {
  value = kubernetes_service.switch-uploader-service.load_balancer_ingress[0].ip
}

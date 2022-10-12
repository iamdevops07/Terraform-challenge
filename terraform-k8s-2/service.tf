
resource "kubernetes_service" "webapp-service" {
  metadata {
    name = "webapp-service"
  }
  spec {
    selector = {
      name = "webapp"
    }
    session_affinity = "ClientIP"
    port {
      port        = 8080
      node_port = 30080
    }

    type = "NodePort"
  }
}
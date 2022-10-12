##### foo - service ####


resource "kubernetes_service" "foo" {
  metadata {
    name = "${local.user_data.applications[0].name}-svc"
  }
  spec {
    selector = {
      app = local.user_data.applications[0].name
    }
    session_affinity = "ClientIP"
    port {
      port        = local.user_data.applications[0].port
      target_port = 80
    }

    type = "ClusterIP"
  }
  depends_on = [
    kubernetes_deployment.foo
  ]
}

##### bar - service ####

resource "kubernetes_service" "bar" {
  metadata {
    name = "${local.user_data.applications[1].name}-svc"
  }
  spec {
    selector = {
      app = local.user_data.applications[1].name
    }
    session_affinity = "ClientIP"
    port {
      port        = local.user_data.applications[1].port
      target_port = 80
    }

    type = "ClusterIP"
  }
  depends_on = [
    kubernetes_deployment.bar
  ]
}

##### boom - service ####


resource "kubernetes_service" "boom" {
  metadata {
    name = "${local.user_data.applications[2].name}-svc"
  }
  spec {
    selector = {
      app = local.user_data.applications[2].name
    }
    session_affinity = "ClientIP"
    port {
      port        = local.user_data.applications[2].port
      target_port = 80
    }

    type = "ClusterIP"
  }
  depends_on = [
    kubernetes_deployment.boom
  ]
}
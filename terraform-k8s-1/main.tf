locals {
    # get json 
    user_data = jsondecode(file("${path.module}/input_values/application.json"))
}

##### foo - ingress ####

resource "kubernetes_ingress" "foo_ingress" {
  metadata {
    name = "${local.user_data.applications[0].name}-ingress"
    annotations = {
        "kubernetes.io/ingress.class" = "nginx"
        "nginx.ingress.kubernetes.io/canary" = "true"
        "nginx.ingress.kubernetes.io/canary-weight" = local.user_data.applications[0].traffic_weight
    }
  }

  spec {
    backend {
      service_name = "${local.user_data.applications[0].name}-svc"
      service_port = local.user_data.applications[0].port
    }

    rule {
      http {
        path {
          backend {
            service_name = "${local.user_data.applications[0].name}-svc"
            service_port = local.user_data.applications[0].port
          }

          path = "/"
        }
      }
    }
  }
  depends_on = [
    kubernetes_service.foo
  ]
}

##### bar - ingress ####

resource "kubernetes_ingress" "bar_ingress" {
  metadata {
    name = "${local.user_data.applications[1].name}-ingress"
    annotations = {
        "kubernetes.io/ingress.class" = "nginx"
        "nginx.ingress.kubernetes.io/canary" = "true"
        "nginx.ingress.kubernetes.io/canary-weight" = local.user_data.applications[1].traffic_weight
    }
  }

  spec {
    backend {
      service_name = "${local.user_data.applications[1].name}-svc"
      service_port = local.user_data.applications[1].port
    }

    rule {
      http {
        path {
          backend {
            service_name = "${local.user_data.applications[1].name}-svc"
            service_port = local.user_data.applications[1].port
          }

          path = "/"
        }
      }
    }
  }
  depends_on = [
    kubernetes_service.bar
  ]
}

##### boom - ingress ####

resource "kubernetes_ingress" "boom_ingress" {
  metadata {
    name = "${local.user_data.applications[2].name}-ingress"
    annotations = {
        "kubernetes.io/ingress.class" = "nginx"
        "nginx.ingress.kubernetes.io/canary" = "true"
        "nginx.ingress.kubernetes.io/canary-weight" = local.user_data.applications[2].traffic_weight
    }
  }

  spec {
    backend {
      service_name = "${local.user_data.applications[2].name}-svc"
      service_port = local.user_data.applications[2].port
    }

    rule {
      http {
        path {
          backend {
            service_name = "${local.user_data.applications[2].name}-svc"
            service_port = local.user_data.applications[2].port
          }

          path = "/"
        }
      }
    }
  }
  depends_on = [
    kubernetes_service.boom
  ]
}


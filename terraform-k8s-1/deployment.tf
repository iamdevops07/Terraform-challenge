resource "kubernetes_deployment" "foo" {
  metadata {
    name = local.user_data.applications[0].name
    labels = {
      app = local.user_data.applications[0].name
    }
  }

  spec {
    replicas = local.user_data.applications[0].replicas

    selector {
      match_labels = {
        app = local.user_data.applications[0].name
      }
    }

    template {
      metadata {
        labels = {
          app = local.user_data.applications[0].name
        }
      }

      spec {
        container {
          image = local.user_data.applications[0].image
          name  = local.user_data.applications[0].name
          args  = local.user_data.applications[0].args
          port {
            container_port = local.user_data.applications[0].port
            }
          }
        }
      }
    }
}



resource "kubernetes_deployment" "bar" {
  metadata {
    name = local.user_data.applications[1].name
    labels = {
      app = local.user_data.applications[1].name
    }
  }

  spec {
    replicas = local.user_data.applications[1].replicas

    selector {
      match_labels = {
        app = local.user_data.applications[1].name
      }
    }

    template {
      metadata {
        labels = {
          app = local.user_data.applications[1].name
        }
      }

      spec {
        container {
          image = local.user_data.applications[1].image
          name  = local.user_data.applications[1].name
          args  = local.user_data.applications[1].args
          port {
            container_port = local.user_data.applications[1].port
            }
          }
        }
      }
    }
  }




resource "kubernetes_deployment" "boom" {
  metadata {
    name = local.user_data.applications[2].name
    labels = {
      app = local.user_data.applications[2].name
    }
  }

  spec {
    replicas = local.user_data.applications[2].replicas

    selector {
      match_labels = {
        app = local.user_data.applications[2].name
      }
    }

    template {
      metadata {
        labels = {
          app = local.user_data.applications[2].name
        }
      }

      spec {
        container {
          image = local.user_data.applications[2].image
          name  = local.user_data.applications[2].name
          args  = local.user_data.applications[2].args
          port {
            container_port = local.user_data.applications[2].port
            }
          }
        }
      }
    }
  }

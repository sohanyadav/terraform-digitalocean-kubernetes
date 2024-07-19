provider "digitalocean" {

}

locals {
  name        = "testing"
  environment = "test"
  region      = "nyc3"
}

####################################################################################
##:-This module is from vpc.
####################################################################################

module "vpc" {
  source      = "git::https://github.com/sohanyadav/terraform-digitalocean-vpc.git?ref=v1.0.0"
  name        = "test-network"
  environment = "test"
  label_order = ["name", "environment"]
  region      = "nyc3"
  ip_range    = "10.23.0.0/16"

}

#####################################################################################
##:-This module is from Kubernetes_cluster.
#####################################################################################

module "Kubernetes_cluster" {
  source             = "./../../"
  name               = local.name
  environment        = local.environment
  region             = local.region
  kubernetes_version = "1.25.14-do.0"
  vpc_uuid           = module.vpc.id

  critical_node_pool = {
    critical_node = {
      node_count = 1
      min_nodes  = 1
      max_nodes  = 1
      size       = "s-1vcpu-2gb"
      tags       = ["demo"]
      labels     = { "cluster" = "critical", }
      taint = [
        {
          key    = "name"
          value  = "default"
          effect = "NoSchedule"
        }
      ]
    }
  }

  app_node_pools = {
    app_node = {
      node_count = 1
      min_nodes  = 1
      max_nodes  = 2
      size       = "s-1vcpu-2gb"
      tags       = ["demo"]
      labels     = { "cluster" = "application", }
      taint = [
        {
          key    = "mysize"
          value  = "large"
          effect = "NoSchedule"
        }
      ]
    }
  }
}

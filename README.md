# Terraform Infrastructure as Code (IaC) - digitalocean Kubernetes Module

## Table of Contents
- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [Authors](#authors)
- [License](#license)

## Introduction
This Terraform module creates structured Kubernetes for digitalocean resources with specific attributes.

## Usage

- Use the module by referencing its source and providing the required variables.
Example:Basic
```hcl
module "Kubernetes_cluster" {
  source             = "git::https://github.com/sohanyadav/terraform-digitalocean-kubernete.git?ref=v1.0.0"
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
    }
  }

  app_node_pools = {
    app_node = {
      node_count = 1
      min_nodes  = 1
      max_nodes  = 2
      size       = "s-1vcpu-2gb"
    }
  }
}

```
Example:complete
```hcl
module "Kubernetes_cluster" {
  source             = "git::https://github.com/sohanyadav/terraform-digitalocean-kubernete.git?ref=v1.0.0"
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

```

Please ensure you specify the correct 'source' path for the module.

## Module Inputs

- `name`: A name for the Kubernetes cluster.
- `environment`: Environment (e.g. `prod`, `dev`, `staging`).
- `label_order`: Label order, e.g. `name`,`application`.
- `enabled`: Whether to create the resources. Set to `false` to prevent the module from creating any resources.
- `app_node_pools`: Cluster additional node pools.
- `kubernetes_version` : The slug identifier for the version of Kubernetes used for the cluster.
- `critical_node_pool`: Cluster default node pool.
- `registry_integration`: Enables or disables the DigitalOcean container registry integration for the cluster.
- `maintenance_policy`: A block representing the cluster's maintenance window.

## Module Outputs
- This module currently does not provide any outputs.

# Examples:Basic
For detailed examples on how to use this module, please refer to the '[example](https://github.com/sohanyadav/terraform-digitalocean-Kubernetes/tree/master/_example/basic)' directory within this repository.
# Examples:complete
For detailed examples on how to use this module, please refer to the '[example](https://github.com/sohanyadav/terraform-digitalocean-Kubernetes/tree/master/_example/complete)' directory within this repository.

## Authors
Your Name
Replace '[License Name]' and '[Your Name]' with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.

## License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/sohanyadav/terraform-digitalocean-Kubernetes/blob/master/LICENSE) file for details.



<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.3 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | >= 2.34.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | >= 2.34.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | git::https://github.com/sohanyadav/terraform-digitalocean-labels.git | v1.0.0 |

## Resources

| Name | Type |
|------|------|
| [digitalocean_kubernetes_cluster.cluster](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster) | resource |
| [digitalocean_kubernetes_node_pool.bar](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_node_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_node_pools"></a> [app\_node\_pools](#input\_app\_node\_pools) | Cluster additional node pools. | `map(any)` | `{}` | no |
| <a name="input_auto_upgrade"></a> [auto\_upgrade](#input\_auto\_upgrade) | A boolean value indicating whether the cluster will be automatically upgraded to new patch releases during its maintenance window. | `bool` | `false` | no |
| <a name="input_critical_node_pool"></a> [critical\_node\_pool](#input\_critical\_node\_pool) | Cluster default node pool. | `any` | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether to create the resources. Set to `false` to prevent the module from creating any resources. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| <a name="input_ha"></a> [ha](#input\_ha) | Enable/disable the high availability control plane for a cluster. High availability can only be set when creating a cluster. | `bool` | `true` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | The slug identifier for the version of Kubernetes used for the cluster | `string` | `"1.25.14-do.0"` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | Label order, e.g. `name`,`application`. | `list(string)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| <a name="input_maintenance_policy"></a> [maintenance\_policy](#input\_maintenance\_policy) | A block representing the cluster's maintenance window. | <pre>object({<br>    day        = string<br>    start_time = string<br>  })</pre> | <pre>{<br>  "day": "any",<br>  "start_time": "02:00"<br>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | A name for the Kubernetes cluster. | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | The slug identifier for the region where the Kubernetes cluster will be created. | `string` | `""` | no |
| <a name="input_registry_integration"></a> [registry\_integration](#input\_registry\_integration) | Enables or disables the DigitalOcean container registry integration for the cluster. | `bool` | `false` | no |
| <a name="input_surge_upgrade"></a> [surge\_upgrade](#input\_surge\_upgrade) | Enable/disable surge upgrades for a cluster. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of tag names to be applied to the Kubernetes cluster. | `list(string)` | `[]` | no |
| <a name="input_vpc_uuid"></a> [vpc\_uuid](#input\_vpc\_uuid) | The ID of the VPC where the Kubernetes cluster will be located. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_auto_upgrade"></a> [auto\_upgrade](#output\_auto\_upgrade) | Indicates whether auto-upgrade is enabled for the Kubernetes cluster. |
| <a name="output_cluster_subnet"></a> [cluster\_subnet](#output\_cluster\_subnet) | The subnet used for the Kubernetes cluster. |
| <a name="output_created_at"></a> [created\_at](#output\_created\_at) | The timestamp when the Kubernetes cluster was created. |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The endpoint for the Kubernetes API server. |
| <a name="output_id"></a> [id](#output\_id) | The unique identifier of the Kubernetes cluster. |
| <a name="output_ipv4_address"></a> [ipv4\_address](#output\_ipv4\_address) | The IPv4 address of the Kubernetes cluster. |
| <a name="output_service_subnet"></a> [service\_subnet](#output\_service\_subnet) | The subnet used for Kubernetes services within the cluster. |
| <a name="output_status"></a> [status](#output\_status) | The current status of the Kubernetes cluster. |
| <a name="output_updated_at"></a> [updated\_at](#output\_updated\_at) | The timestamp when the Kubernetes cluster was last updated. |
| <a name="output_urn"></a> [urn](#output\_urn) | The Uniform Resource Name (URN) of the Kubernetes cluster. |
<!-- END_TF_DOCS -->
locals {
  base_service_annotations = [
    {
      name  = "tailscale.com/expose"
      value = "true"
    },
    {
      name  = "tailscale.com/hostname"
      value = local.service_name
    },
    {
      name  = "tailscale.com/tags",
      value = join(",", [for tag in local.normalized_tags : "tag:${tag}"])
    },
  ]
}

output "service_annotations" {
  value = [for cur in local.base_service_annotations : cur if cur.value != ""]
}

output "private_urls" {
  value = [
    {
      url = "${var.service_scheme}://${local.service_name}.${local.tailnet_dns_name}:${var.service_port}"
    }
  ]
}

variable "app_metadata" {
  description = <<EOF
Nullstone automatically injects metadata from the app module into this module through this variable.
This variable is a reserved variable for capabilities.
EOF

  type    = map(string)
  default = {}
}

locals {
  service_name = var.app_metadata["service_name"]
}

variable "tailscale_tags" {
  type    = set(string)
  default = []

  description = <<EOF
A set of tags to apply to this deployment when registering with the Tailnet.
Do not include `tag:` prefix.
EOF
}

variable "service_scheme" {
  type    = string
  default = "http"

  description = <<EOF
This is used for the URL scheme for a private URL on the app.
EOF
}

variable "service_port" {
  type    = number
  default = 80

  description = <<EOF
This is used for the URL port for a private URL on the app.
EOF
}

locals {
  normalized_tags = toset([for tag in var.tailscale_tags : trimprefix(tag, "tag:")])
}

variable "project" {}

variable "credentials_file" {}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-c"
}

# allow for custom name of the network
variable "network_name" {
  description = "The name to use for the network"
  default     = "hello-world-network"
}

# allow for custom name of the instance
variable "instance_name" {
  description = "The name to use for the cloud instance"
  default     = "hello-world-instance"
}

variable "firewall_name" {
  description = "The name to use for the firewall"
  default     = "hello-world-firewall"
}

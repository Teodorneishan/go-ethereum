variable "region" {
  description = "aws region"
  type = string
  default = "eu-central-1"
}

variable "clusterName" {
  description = "Name of the cluster"
  type = string
  default = "limechain-eks"
}

variable "registry_username" {
  description = "Private docker repo"
  type = string
}

variable "registry_password" {
  description = "password of private docker repo"
  type = string
}

variable "registry_email" {
  description = "Registry email"
  type = string
}

variable "registry_server" {
  description = "docker registry server"
  type = string
  default = "docker.io"
}

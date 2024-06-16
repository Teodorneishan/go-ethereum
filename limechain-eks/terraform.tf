terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.56"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.5.1"
    }
    tls = {
      source = "hashicorp/tls"
      version = "~> 4.0.4"
    }
    time = {
      source = "hashicorp/time"
      version = "~> 0.10.0"
    }
    cloudinit = {
      source = "hashicorp/cloudinit"
      version = ">= 2.0"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.31.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.5.1"
    }
  }
  required_version = ">= 1.6.3"
}


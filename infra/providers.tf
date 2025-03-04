terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 6.24"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.default_region

  default_tags {
    tags = {
      Project     = "Netskope-Multi-Region-Publisher-Framework"
      ManagedBy   = "Terraform"
      Environment = var.environment
    }
  }
}

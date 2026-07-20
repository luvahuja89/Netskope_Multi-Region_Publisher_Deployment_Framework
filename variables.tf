variable "default_region" {
  description = "Default AWS Region for root provider fallback"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment Environment (e.g. production, staging, lab)"
  type        = string
  default     = "production"
}

variable "key_name" {
  description = "AWS Key Pair Name for SSH access across regions"
  type        = string
  default     = "Key_test"
}

variable "regional_deployments" {
  description = "Map of regional deployments defining site topology, instance types, and Netskope tokens"
  type = map(object({
    region                  = string
    vpc_cidr                = string
    public_subnet_cidr      = string
    publisher_instance_type = string
    publisher_count         = number
    publisher_ami_id        = optional(string, "")
    registration_token      = optional(string, "")
  }))

  default = {
    "site-US" = {
      region                  = "us-east-1"
      vpc_cidr                = "10.0.0.0/16"
      public_subnet_cidr      = "10.0.1.0/24"
      publisher_instance_type = "t3.medium"
      publisher_count         = 2
    },
    "site-UK" = {
      region                  = "eu-west-2"
      vpc_cidr                = "10.1.0.0/16"
      public_subnet_cidr      = "10.1.1.0/24"
      publisher_instance_type = "t3.medium"
      publisher_count         = 2
    }
  }
}

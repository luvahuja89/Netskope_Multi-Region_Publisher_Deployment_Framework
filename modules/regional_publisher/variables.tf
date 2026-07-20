variable "site_id" {
  description = "Unique identifier for the site (e.g. site-US, site-UK)"
  type        = string
}

variable "region" {
  description = "AWS region for deployment"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the regional VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet housing Netskope Publishers"
  type        = string
}

variable "publisher_instance_type" {
  description = "EC2 instance type for Netskope Publisher"
  type        = string
  default     = "t3.medium"
}

variable "publisher_count" {
  description = "Number of Publisher instances to launch for High Availability"
  type        = number
  default     = 2
}

variable "publisher_ami_id" {
  description = "AMI ID for Netskope Private Access Publisher (leave blank to auto-discover)"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "AWS SSH Key Pair name"
  type        = string
}

variable "registration_token" {
  description = "Netskope Private Access Publisher Registration Token"
  type        = string
  default     = ""
  sensitive   = true
}

variable "tags" {
  description = "Custom resource tags"
  type        = map(string)
  default     = {}
}

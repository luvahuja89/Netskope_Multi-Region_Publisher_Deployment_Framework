environment = "production-standard"
key_name    = "Key_test"

regional_deployments = {
  "site-US" = {
    region                  = "us-east-1"
    vpc_cidr                = "10.0.0.0/16"
    public_subnet_cidr      = "10.0.1.0/24"
    publisher_instance_type = "t3.medium"
    publisher_count         = 2
    registration_token      = "CHANGE_ME_REAL_TOKEN_SITE_US"
  },
  "site-UK" = {
    region                  = "eu-west-2"
    vpc_cidr                = "10.1.0.0/16"
    public_subnet_cidr      = "10.1.1.0/24"
    publisher_instance_type = "t3.medium"
    publisher_count         = 2
    registration_token      = "CHANGE_ME_REAL_TOKEN_SITE_UK"
  }
}

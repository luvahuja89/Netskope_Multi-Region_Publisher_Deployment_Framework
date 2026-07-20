environment = "production-enterprise"
key_name    = "enterprise-prod-key"

regional_deployments = {
  # North America
  "site-US-EAST" = {
    region                  = "us-east-1"
    vpc_cidr                = "10.100.0.0/16"
    public_subnet_cidr      = "10.100.1.0/24"
    publisher_instance_type = "t3.medium"
    publisher_count         = 2
    registration_token      = "TOKEN_US_EAST_PROD"
  },
  "site-US-WEST" = {
    region                  = "us-west-2"
    vpc_cidr                = "10.101.0.0/16"
    public_subnet_cidr      = "10.101.1.0/24"
    publisher_instance_type = "t3.medium"
    publisher_count         = 2
    registration_token      = "TOKEN_US_WEST_PROD"
  },
  "site-CANADA" = {
    region                  = "ca-central-1"
    vpc_cidr                = "10.102.0.0/16"
    public_subnet_cidr      = "10.102.1.0/24"
    publisher_instance_type = "t3.small"
    publisher_count         = 2
    registration_token      = "TOKEN_CANADA_PROD"
  },

  # Europe & Middle East
  "site-UK" = {
    region                  = "eu-west-2"
    vpc_cidr                = "10.103.0.0/16"
    public_subnet_cidr      = "10.103.1.0/24"
    publisher_instance_type = "t3.medium"
    publisher_count         = 2
    registration_token      = "TOKEN_UK_PROD"
  },
  "site-GERMANY" = {
    region                  = "eu-central-1"
    vpc_cidr                = "10.104.0.0/16"
    public_subnet_cidr      = "10.104.1.0/24"
    publisher_instance_type = "t3.medium"
    publisher_count         = 2
    registration_token      = "TOKEN_GERMANY_PROD"
  },
  "site-FRANCE" = {
    region                  = "eu-west-3"
    vpc_cidr                = "10.105.0.0/16"
    public_subnet_cidr      = "10.105.1.0/24"
    publisher_instance_type = "t3.small"
    publisher_count         = 2
    registration_token      = "TOKEN_FRANCE_PROD"
  },

  # Asia Pacific & Latin America
  "site-JAPAN" = {
    region                  = "ap-northeast-1"
    vpc_cidr                = "10.106.0.0/16"
    public_subnet_cidr      = "10.106.1.0/24"
    publisher_instance_type = "t3.medium"
    publisher_count         = 2
    registration_token      = "TOKEN_JAPAN_PROD"
  },
  "site-SINGAPORE" = {
    region                  = "ap-southeast-1"
    vpc_cidr                = "10.107.0.0/16"
    public_subnet_cidr      = "10.107.1.0/24"
    publisher_instance_type = "t3.medium"
    publisher_count         = 2
    registration_token      = "TOKEN_SINGAPORE_PROD"
  },
  "site-INDIA" = {
    region                  = "ap-south-1"
    vpc_cidr                = "10.108.0.0/16"
    public_subnet_cidr      = "10.108.1.0/24"
    publisher_instance_type = "t3.medium"
    publisher_count         = 2
    registration_token      = "TOKEN_INDIA_PROD"
  },
  "site-BRAZIL" = {
    region                  = "sa-east-1"
    vpc_cidr                = "10.109.0.0/16"
    public_subnet_cidr      = "10.109.1.0/24"
    publisher_instance_type = "t3.small"
    publisher_count         = 2
    registration_token      = "TOKEN_BRAZIL_PROD"
  }
}

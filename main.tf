# -----------------------------------------------------------------------------
# Root Module: Multi-Region Netskope Publisher Deployment Framework
# -----------------------------------------------------------------------------

module "regional_publisher" {
  for_each = var.regional_deployments

  source = "./modules/regional_publisher"

  site_id                 = each.key
  region                  = each.value.region
  vpc_cidr                = each.value.vpc_cidr
  public_subnet_cidr      = each.value.public_subnet_cidr
  publisher_instance_type = each.value.publisher_instance_type
  publisher_count         = each.value.publisher_count
  publisher_ami_id        = each.value.publisher_ami_id
  key_name                = var.key_name
  registration_token      = each.value.registration_token

  tags = {
    SiteID      = each.key
    Region      = each.value.region
    Environment = var.environment
  }
}

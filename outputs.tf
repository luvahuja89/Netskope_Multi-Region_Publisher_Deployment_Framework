output "regional_publishers_summary" {
  description = "Summary of deployed Netskope regional sites, VPCs, and Publisher IP addresses"
  value = {
    for site_id, site_module in module.regional_publisher : site_id => {
      vpc_id                = site_module.vpc_id
      subnet_id             = site_module.subnet_id
      publisher_public_ips  = site_module.publisher_public_ips
      publisher_private_ips = site_module.publisher_private_ips
    }
  }
}

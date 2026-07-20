output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.this.id
}

output "subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "publisher_public_ips" {
  description = "Public IP addresses of Netskope Publishers"
  value       = aws_instance.publisher[*].public_ip
}

output "publisher_private_ips" {
  description = "Private IP addresses of Netskope Publishers"
  value       = aws_instance.publisher[*].private_ip
}

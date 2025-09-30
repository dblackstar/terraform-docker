output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_id" {
  value = aws_subnet.subnet.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.gateway.id
}

output "route_table_id" {
  value = aws_route_table.route_table.id
}

output "security_group_id" {
  value = aws_security_group.sg.id
}

output "key_pair_id" {
  value = aws_key_pair.ssh_key.id
}

output "instance_id" {
  value = aws_instance.ec2.id
}
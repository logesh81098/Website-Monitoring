output "vpc-id" {
  value = aws_vpc.website-monitoring.id
}

output "private-subnet-id" {
  value = aws_subnet.website-monitoring-private-subnet.id
}
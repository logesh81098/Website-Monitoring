output "website-monitoring-server-sg" {
  value = aws_security_group.website-monitoring-sg.id
}
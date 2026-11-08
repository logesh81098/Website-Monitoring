################################################################################################################################
#                                                Security Group 
################################################################################################################################

resource "aws_security_group" "website-monitoring-sg" {
  name = "Website Monitoring SG"
  description = "Security Group created for Website Monitoring Server"
  vpc_id = var.vpc-id
  ingress {
    from_port = var.port-ssh
    to_port = var.port-ssh
    protocol = "tcp"
    cidr_blocks = [var.my-ip]
    description = "Allow to connect server via SSH only from my ip address"
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [var.anywhere-ip]
    description = "Allow anyone from anywhere"
  }
  tags = {
    Name = "Website Monitoring SG"
  }
}
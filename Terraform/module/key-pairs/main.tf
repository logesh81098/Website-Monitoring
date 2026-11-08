################################################################################################################################
#                                                Key pair 
################################################################################################################################

resource "tls_private_key" "website-monitoring" {
  algorithm = "RSA"
  rsa_bits = 4098
}

resource "aws_key_pair" "website-monitoring" {
  key_name = "Website Monitoring Server Key"
  public_key = tls_private_key.website-monitoring.public_key_openssh
}

resource "local_file" "private-key" {
  filename = "website-monitoring-server.pem"
  content = tls_private_key.website-monitoring.private_key_openssh
}
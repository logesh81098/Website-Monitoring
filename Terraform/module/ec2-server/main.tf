################################################################################################################################
#                                        Elastic Compute Cloud
################################################################################################################################

resource "aws_instance" "website-monitoring-server" {
  ami = var.ami-id
  instance_type = var.instance-type
  subnet_id = var.subnet-id
  key_name = var.keypairs
  iam_instance_profile = var.instance-profile
  vpc_security_group_ids = [var.security-group]
  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    encrypted = true
    delete_on_termination = true
  }
  tags = {
    Name = "Website Monitoring Server"
  }
}
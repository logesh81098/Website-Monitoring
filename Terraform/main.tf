module "vpc" {
  source = "./module/vpc"
}

module "security-groups" {
  source = "./module/security-groups"
  vpc-id = module.vpc.vpc-id
}

module "key-pairs" {
  source = "./module/key-pairs"
}

module "iam" {
  source = "./module/iam"
}

module "ec2-server" {
  source = "./module/ec2-server"
  subnet-id = module.vpc.private-subnet-id
  security-group = module.security-groups.website-monitoring-server-sg
  keypairs = module.key-pairs.website-monitoring-server-keypair
  instance-profile = module.iam.instance-profile
}
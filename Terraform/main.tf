module "vpc" {
  source = "./module/vpc"
}

module "security-groups" {
  source = "./module/security-groups"
  vpc-id = module.vpc.vpc-id
}
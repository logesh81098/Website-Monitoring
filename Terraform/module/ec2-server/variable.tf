variable "ami-id" {
  default = "ami-08e3b3155fc937a94"
}

variable "instance-type" {
  default = "t3.medium"
}

variable "subnet-id" {
  default = {}
}

variable "security-group" {
  default = {}
}

variable "keypairs" {
  default = {}
}

variable "instance-profile" {
  default = {}
}

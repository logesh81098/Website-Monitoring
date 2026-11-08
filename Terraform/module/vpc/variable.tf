variable "vpc-cidr" {
  default = "10.0.0.0/16"
}

variable "public-subnet-cidr" {
  default = "10.0.1.0/24"
}

variable "private-subnet-cidr" {
  default = "10.0.4.0/24"
}

variable "anywhere-ip" {
  default = "0.0.0.0/0"
}

variable "az1" {
  default = "ap-south-1a"
}
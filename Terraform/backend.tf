terraform {
  backend "s3" {
    bucket = "terraform-backend-files-logesh"
    key = "Website-Monitoring"
    region = "us-east-1"
  }
}
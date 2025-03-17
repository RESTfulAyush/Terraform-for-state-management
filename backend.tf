terraform {
  backend "s3" {
    bucket = "terraform0325"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}

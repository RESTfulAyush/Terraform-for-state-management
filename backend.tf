terraform {
  backend "s3" {
    bucket = "terraform13072003"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}

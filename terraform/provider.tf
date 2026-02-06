terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.31.0"
    }
  }
}

provider "aws" {
  # Configuration options
  #   access_key = "enter_your_access_key_here"
  #     secret_key = "enter_your_secret_key_here"
  region = "ap-south-1"
}

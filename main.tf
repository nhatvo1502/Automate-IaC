provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "keypair-1234"
    key = "terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}

resource "aws_key_pair" "create_keypair" {
  key_name = "tien08"
  public_key = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCJgKe/Ko/3pXldymY2/bwP70xPJzP6NpKS9iQP450sWFtc5VuG3fqaOvGMzhrS3VUseALddYALiWmgf+cgjdvASeW3eIl54y2253QTme4eb1WOZ2/MvcANBuiJFqItL7SR4xlaAuI48yS8lh7L2OIIpzy8PUV+EcPD9KGKsAicFwIDAQAB"
}

resource "" "name" {
  
}
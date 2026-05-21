module "network" {
  source   = "./modules/network"
  vpc_cidr = var.vpc_cidr
  tags     = local.common_tags
}

locals {
  common_tags = {
    Project     = "NimbusKart"
    Environment = "staging"
    Owner       = "Priya"
    ManagedBy   = "terraform"
  }
}

resource "aws_security_group" "web_sg" {
  name   = "web-sg"
  vpc_id = module.network.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  tags = local.common_tags
}



resource "aws_s3_bucket" "logs" {
  bucket = "nimbuskart-logs"

  tags = local.common_tags
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.logs.id

  versioning_configuration {
    status = "Enabled"
  }
}



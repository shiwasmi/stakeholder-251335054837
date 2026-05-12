provider "aws" {
  region = "ap-south-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.40.0"
    }
  }
}

module "bucket1" {
  source      = "git::https://github.com/shiwasmi/aws_tf_modules.git//modules/s3bucket?ref=v1.8.0"
  bucket_name = "terraform-bucket-sagar-251335054837"
  bucket_acl  = "private" # or "public-read" depending on your need
}

module "myec2" {
  source            = "git::https://github.com/shiwasmi/aws_tf_modules.git//modules/ec2?ref=v1.8.0"
  ec2_instance_type = "t3.micro"
}

module "my_vpc" {
  source     = "git::https://github.com/shiwasmi/aws_tf_modules.git//modules/vpc?ref=v1.8.0"
  vpc_name   = "sagar-vpc"
  cidr_block = "10.0.0.0/16"

  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
}

module "mysql_db" {
  source                 = "git::https://github.com/shiwasmi/aws_tf_modules.git//modules/mysqldb?ref=v1.8.0"
  db_name                = var.db_name
  db_username            = var.db_username
  db_password            = var.db_password
  instance_class         = var.instance_class
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_ids = [
    "subnet-08e18b60ea182c880",
    "subnet-0809eaeaacc4d4ce0"
  ]
}

terraform {
  backend "s3" {
    bucket = "my-epam-diploma-bucket-serov"
    key    = "tf-states/rds-state.tfstate"
    region = "eu-central-1"
  }
}

provider "aws" {
  region = var.region
  profile = var.profile
}

data "terraform_remote_state" "eks" {
  # backend = "s3"
  # config = {
  #   bucket = "my-epam-diploma-bucket-serov"
  #   key = "tf-states/eks-state.tfstate"
  #   region = var.region
  # }
}


# terraform {
#     required_providers {
#         aws = {
#             source  = "hashicorp/aws"
#             version = "~> 4.0"
#         }
#     }
#     required_version = "~> 1.0"
# }

# # Configure the AWS Provider
# provider "aws" {
#     region = "eu-central-1"
#     default_tags {
#         tags = {
#             "Owner" = "DevOps"
#         }
#     }
# }


# resource "aws_db_instance" "rds" {
#   identifier             = "postgres-diploma-rds"
#   allocated_storage      = 5
#   engine                 = "postgres"
#   engine_version         = "14"
#   instance_class         = "db.t3.micro"
#   db_name                = var.db_name
#   username               = var.db_username
#   password               = var.db_password
#   parameter_group_name   = "default.postgres14"
#   publicly_accessible    = true # for local debug
#   skip_final_snapshot    = true
#   multi_az               = false

#   tags = {
#     Name = "epam-diploma-rds"
#   }
# }

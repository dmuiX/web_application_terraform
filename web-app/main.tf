terraform {
  cloud {
    organization = "dmuiX"

    workspaces {
      name = "web-app"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "web-app" {
  source                   = "../web-app-module"
  aws_region               = var.aws_region
  aws_profile              = var.aws_profile
  web_app_instance_profile = var.web_app_instance_profile
  web_app_iam_user         = var.web_app_iam_user
  web_app_db_username      = var.web_app_db_username
  web_app_sg_instances     = var.web_app_sg_instances
  web_app_db_identifier    = var.web_app_db_identifier
  web_app_sg_alb           = var.web_app_sg_alb
  web_app_domain           = var.web_app_domain
  web_app_alb              = var.web_app_alb
  web_app_target_group     = var.web_app_target_group
}

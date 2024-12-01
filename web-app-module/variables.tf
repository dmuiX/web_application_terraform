
//aws
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "aws_profile" {
  description = "The AWS profile to use"
  type        = string
}

//iam
variable "web_app_iam_user" {
  description = "The username for the IAM user"
  type        = string
}

//compute
variable "web_app_instance_profile" {
  description = "The instance profile for the web app"
  type        = string
}

//db
variable "web_app_db_identifier" {
  description = "The identifier for the web app database"
  type        = string
}

variable "web_app_db_username" {
  description = "The username for the web app database"
  type        = string
}

//networking
variable "web_app_sg_alb" {
  description = "The security group for the ALB"
  type        = string
}

variable "web_app_sg_instances" {
  description = "The name of the security group for the web app instances"
  type = string
}

variable "web_app_alb" {
  description = "The name of the application load balancer"
  type        = string
}

variable "web_app_target_group" {
  description = "The target group for the web app"
  type        = string
}

//dns
variable "web_app_domain" {
  description = "The domain name for the web app"
  type        = string
}
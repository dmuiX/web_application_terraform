# web-app on aws deployed with terraform

this is an web application running on 2 ec2 behind an application load balancer and a Route53 domain.
mainly just created for learning purposes

This application uses the terraform cloud as a backend. Workspace is configured to run locally though and just save the state on the cloud.

Because of these Problems:

## Setup terraform cloud
```yaml
Terraform v1.10.0
on linux_amd64
Initializing plugins and modules...
╷
│ Error: failed to get shared config profile, terraform
│ 
│   with provider["registry.terraform.io/hashicorp/aws"],
│   on main.tf line 26, in provider "aws":
│   26: provider "aws" {
│ 
╵
Operation failed: failed running terraform plan (exit 1)
```

Problem is workspace is via default configured to run everything on a remote server
disable it and everything is working fine

## web-app-module is not found when outside of the web-app folder

same error as above has to do with remote execution and therefore not finding what is on my local machine
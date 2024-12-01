resource "aws_instance" "web-app-instance_1" {
  ami             = "ami-0a628e1e89aaedf80" # Ubuntu 24.04 LTS // us-east-1
  instance_type   = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.web_app_instance_profile.id
  security_groups = [aws_security_group.web-app-sg-instances.name]
  user_data       = <<-EOF
              #!/bin/bash
              echo "Hello, World 1" > index.html
              python3 -m http.server 8080 &
              EOF
}

resource "aws_instance" "web-app-instance_2" {
  ami             = "ami-0a628e1e89aaedf80" # Ubuntu 24.04 LTS // eu-central-1
  instance_type   = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.web_app_instance_profile.id
  security_groups = [aws_security_group.web-app-sg-instances.name]
  user_data       = <<-EOF
              #!/bin/bash
              echo "Hello, World 2" > index.html
              python3 -m http.server 8080 &
              EOF
}
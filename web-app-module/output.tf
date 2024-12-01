output "web-app-db-password" {
    value = aws_db_instance.web-app-db-instance.password
    sensitive = true
}
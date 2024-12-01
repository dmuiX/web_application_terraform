resource "random_password" "web-app-db-password" {
  length  = 20
}

resource "aws_db_instance" "web-app-db-instance" {
  allocated_storage          = 10
  auto_minor_version_upgrade = true
  engine                     = "postgres"
  engine_version             = "12" # Free Tier only allows RDS Postgres db 12
  instance_class             = "db.t3.micro" # Seems to be that t3 is necessary as well for postgres 12
  identifier                 = var.web_app_db_identifier
  username                   = var.web_app_db_username # master username seems also not like to be a longer one and with -
  password                   = random_password.web-app-db-password.result # no special characters other than: '/', '@', '"', ' ' allowed
  skip_final_snapshot        = true
}

resource "aws_db_instance" "default" {
  allocated_storage       = 10
  db_name                 = "mydb"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin"
  password                = "Cloud123"
  #db_subnet_group_name    = aws_db_subnet_group.sub-grp.id
  parameter_group_name    = "default.mysql8.0"

  # Enable backups and retention
  #backup_retention_period  = 7   # Retain backups for 7 days
  #backup_window            = "02:00-03:00" # Daily backup window (UTC)

  # Enable monitoring (CloudWatch Enhanced Monitoring)
 # monitoring_interval      = 60  # Collect metrics every 60 seconds
  #monitoring_role_arn      = aws_iam_role.rds_monitoring.arn

  # Enable performance insights
  #performance_insights_enabled          = true
  #performance_insights_retention_period = 7  # Retain insights for 7 days

  # Maintenance window
  #maintenance_window = "sun:04:00-sun:05:00"  # Maintenance every Sunday (UTC)

  # Enable deletion protection (to prevent accidental deletion)
  #deletion_protection = true

  # Skip final snapshot
  skip_final_snapshot = true
}

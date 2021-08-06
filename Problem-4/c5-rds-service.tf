module "rds_mysql_instance" {
  source                                   = "./modules/aws_rds"
  rds_allocatd_storage                     = 10
  rds_database_engine                      = "mysql"
  rds_database_engine_version              = "5.7"
  rds_db_instance_type                     = "db.t2.micro"
  rds_initial_database_name                = "wordpress_db"
  rds_database_username                    = "root"
  rds_database_user_password               = "9aiv5e78"
  rds_parameter_group_name                 = "default.mysql5.7"
  rds_max_allocated_storage                = 1000
  rds_db_engine_auto_minor_version_upgrade = true
  rds_delete_automated_backups             = true
  rds_database_publicly_access             = true
  rds_skip_final_snapshot                  = true
  rds_vpc_security_group_ids               = ["${module.rds_sg.security_group_id}"]
  tags = {
    Name = "wordpress-backend-mysql"
  }
}